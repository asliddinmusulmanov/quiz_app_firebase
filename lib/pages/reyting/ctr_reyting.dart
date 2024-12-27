import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/core/services/cloud_firebase_ser.dart';
import 'package:app_quiz/data/models/reyting_model.dart';

class ReytingController {
  static bool isLoading = false;
  static List<ReytingModelList> reytinglist = [];

  static Future<void> getAllData(Function updateState) async {
    updateState(() {
      isLoading = true;
    });

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await CFSServise.getDocument(
              collectionPath: 'users', documentId: 'reyting');

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();
        if (data != null && data.containsKey('user')) {
          var userData = data['user'];
          if (userData is List) {
            reytinglist = userData
                .map((item) => ReytingModelList.fromJson(item))
                .toList();
            // Sort the list by 'ball' in descending order
            reytinglist.sort((a, b) => b.ball.compareTo(a.ball));
          } else {
            debugPrint('The "user" field is not a list.');
          }
        } else {
          debugPrint('The "user" field does not exist in the document.');
        }
      } else {
        debugPrint('No document found with the ID "reyting".');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }

    updateState(() {
      isLoading = false;
    });
  }
}
