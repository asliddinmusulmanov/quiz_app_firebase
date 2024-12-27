
import 'package:cloud_firestore/cloud_firestore.dart';

class CFSServise {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    return await db.collection(collectionPath).doc(documentId).get();
  }

  static Future<void> setDocument({
    required String id,
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      final documentRef = db.collection(collectionPath).doc(id);
      await documentRef.set(data, SetOptions(merge: true)); // Use merge option to update the existing document
    } catch (e) {
      throw Exception('Error updating document: $e');
    }
  }

  static Future<void> updateContact({
    required String id,
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    try {
      final documentRef = db.collection(collectionPath).doc(id);
      await documentRef.set(data, SetOptions(merge: true)); // Use merge option to update the existing document
    } catch (e) {
      throw Exception('Error updating document: $e');
    }
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readAllData({
    required String collectionPath,
  }) async {
    final snapshot = await db.collection(collectionPath).get();
    return snapshot.docs;
  }
}
