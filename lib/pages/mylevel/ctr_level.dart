import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/core/services/cloud_firebase_ser.dart';

class MyLevelController {
  static bool isLoading = false;
  static List<Map<String, dynamic>> reytinglist = [];

  static Future<void> getAllData(Function updateState) async {
    updateState(() {
      isLoading = true;
    });

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await CFSServise.getDocument(
              collectionPath: 'mylevel', documentId: 'reyting');

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();
        if (data != null && data.containsKey('ball')) {
          var userData = data['ball'];
          if (userData is List) {
            reytinglist = List<Map<String, dynamic>>.from(userData);
          } else {
            debugPrint('The "ball" field is not a list.');
          }
        } else {
          debugPrint('The "ball" field does not exist in the document.');
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

  static Future<void> updateBallValue(int index, Function updateState) async {
    try {
      // Update Firestore document
      reytinglist[index][reytinglist[index].keys.first] = 0;

      await CFSServise.updateContact(
        id: 'reyting',
        collectionPath: 'mylevel',
        data: {
          'ball': reytinglist,
        },
      );

      updateState(() {
        reytinglist[index][reytinglist[index].keys.first] = 0;
      });
    } catch (e) {
      debugPrint('Error updating data: $e');
    }
  }
}
