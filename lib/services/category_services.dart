import 'package:cloud_firestore/cloud_firestore.dart';

import '../references/product_ref.dart';

class CategoryServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "categories";
  ProductRef productRef = ProductRef();

  Future<void> addCategory(String name) async {
    String categoryId = DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore
        .collection(ref)
        .doc(categoryId)
        .set({productRef.category: name});
  }

  Future<void> updateCategory(
      {String? categoryId, String? newName, String? oldName}) async {
    await _firestore
        .collection(ref)
        .doc(categoryId)
        .update({productRef.category: newName});

    QuerySnapshot snapshot = await _firestore
        .collection(productRef.collection)
        .where(productRef.category, isEqualTo: oldName)
        .get();

    snapshot.docs.forEach((document) async {
      await _firestore
          .collection(productRef.collection)
          .doc(document.id)
          .update({productRef.category: newName});
    });
  }

  Future<void> deleteCategory({String? categoryId, String? name}) async {
    QuerySnapshot snapshot = await _firestore
        .collection(productRef.collection)
        .where(productRef.category, isEqualTo: name)
        .get();

    snapshot.docs.forEach((document) async {
      await _firestore
          .collection(productRef.collection)
          .doc(document.id)
          .update({productRef.category: "not categorized"});
    });

    await _firestore.collection(ref).doc(categoryId).delete();
  }
}
