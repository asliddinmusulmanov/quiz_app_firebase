
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/core/services/cloud_firebase_ser.dart';
import 'package:app_quiz/data/models/savollar_model.dart';

class SavollarController {
  static bool isLoading = false;
  static List<TestModelList> savollarlisti = [];
  static List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
  static int darslar = 0;

  static Future<void> getModulesAndLessons(
    Function updateState, {
    required String collectionpath,
  }) async {
    isLoading = true;
    savollarlisti.clear();
    list.clear();
    updateState(() {});
    list = await CFSServise.readAllData(collectionPath: collectionpath);
    int modulesCount = list.length;
    debugPrint('Number of modules: $modulesCount');
    if (list.isNotEmpty) {
      var firstModule = list.first;
      darslar = firstModule.data().length;
      debugPrint('Number of lessons in the first module: $darslar');
    }
    isLoading = false;
    updateState(() {});
  }

  static Future<void> getLessonDetails(
    Function updateState,
    String modul,
    String lesson, {
    required String collectionpath,
  }) async {
    isLoading = true;
    savollarlisti.clear();
    list.clear();
    updateState(() {});

    list = await CFSServise.readAllData(collectionPath: collectionpath);

    QueryDocumentSnapshot<Map<String, dynamic>>? documentModule;
    for (var doc in list) {
      if (doc.id == modul) {
        documentModule = doc;
        break;
      }
    }

    if (documentModule != null) {
      Map<String, dynamic>? lessonData = documentModule.data()[lesson];
      if (lessonData != null) {
        int easyCount = (lessonData['easy'] as List).length;
        int mediumCount = (lessonData['medium'] as List).length;
        int hardCount = (lessonData['hard'] as List).length;

        debugPrint('Number of easy questions: $easyCount');
        debugPrint('Number of medium questions: $mediumCount');
        debugPrint('Number of hard questions: $hardCount');

        savollarlisti =
            (lessonData['easy'] as List).map((item) => TestModelList.fromJson(item)).toList();
        savollarlisti.addAll(
            (lessonData['medium'] as List).map((item) => TestModelList.fromJson(item)).toList());
        savollarlisti.addAll(
            (lessonData['hard'] as List).map((item) => TestModelList.fromJson(item)).toList());

        debugPrint('Total number of questions: ${savollarlisti.length}');
      } else {
        debugPrint('Lesson $lesson not found in module $modul');
      }
    } else {
      debugPrint('Module $modul not found');
    }

    isLoading = false;
    updateState(() {});
  }

  // get question

  static Future<void> getQuestions(
    Function updateState,
    String collectionPath,
    String modul,
    String dars,
    String level
  ) async {
    isLoading = true;
    updateState(() {});
    debugPrint('$collectionPath $modul $dars');
    list = await CFSServise.readAllData(collectionPath: collectionPath);

    QueryDocumentSnapshot<Map<String, dynamic>>? document1modul;
    for (var doc in list) {
      if (doc.id == modul) {
        document1modul = doc;
        break;
      }
    }

    if (document1modul != null) {
      debugPrint(document1modul[dars][level].toString());
      debugPrint('\x1B[100m${document1modul[dars][level]}\x1B[0m');

      savollarlisti = (document1modul[dars][level] as List)
          .map((item) => TestModelList.fromJson(item))
          .toList();
    } else {
      debugPrint('Document with ID 1modul not found');
    }

    isLoading = false;
    updateState(() {});
  }



  static Future<void> addQuestion(TestModelList newQuestion, Function updateState,String languagename,String modul,String dars,String level) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await CFSServise.getDocument(
        collectionPath: languagename,
        documentId: modul,
      );

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();
        if (data != null) {
          if (!data.containsKey(dars)) {
            data[dars] = {level: []};
          } else if (!data[dars].containsKey(level)) {
            data[dars][level] = [];
          }

          List<dynamic> existingQuestions = data[dars][level];
          existingQuestions.add(newQuestion.toJson());

          await CFSServise.setDocument(
            id: modul,
            collectionPath: languagename,
            data: data,
          );
        }
      } else {
        await CFSServise.setDocument(
          id: modul,
          collectionPath: languagename,
          data: {
            '1dars': {
              'easy': [newQuestion.toJson()],
            },
          },
        );
      }

      savollarlisti.add(newQuestion);
      updateState(() {});
    } catch (e) {
      debugPrint('Error adding question: $e');
    }
  }


}
