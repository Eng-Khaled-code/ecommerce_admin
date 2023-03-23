import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/references/product_ref.dart';

class BrandServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "brands";
  ProductRef productRef = ProductRef();

  Future<void> addBrand(String name) async {
    String brandId = DateTime.now().millisecondsSinceEpoch.toString();

    await _firestore.collection(ref).doc(brandId).set({productRef.brand: name});
  }

  Future<void> updateBrand(
      {String? brandId, String? newName, String? oldName}) async {
    await _firestore
        .collection(ref)
        .doc(brandId)
        .update({productRef.brand: newName});

    QuerySnapshot snapshot = await _firestore
        .collection(productRef.collection)
        .where(productRef.brand, isEqualTo: oldName)
        .get();

    snapshot.docs.forEach((document) async {
      await _firestore
          .collection(productRef.collection)
          .doc(document.id)
          .update({productRef.brand: newName});
    });
  }

  Future<void> deleteBrand({String? brandId, String? name}) async {
    QuerySnapshot snapshot = await _firestore
        .collection(productRef.collection)
        .where(productRef.brand, isEqualTo: name)
        .get();

    snapshot.docs.forEach((document) async {
      await _firestore
          .collection(productRef.collection)
          .doc(document.id)
          .update({productRef.brand: "unknown"});
    });

    await _firestore.collection(ref).doc(brandId).delete();
  }
}
