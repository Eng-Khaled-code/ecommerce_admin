import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/references/product_ref.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';

class ProductServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  ProductRef productRef = ProductRef();

  Future<List<String>> getBrandsList() async {
    List<String> brands = [];

    QuerySnapshot snapshot =
        await _firebaseFirestore.collection("brands").get();

    for (DocumentSnapshot documentSnapshot in snapshot.docs) {
      brands.add(documentSnapshot[productRef.brand]);
    }

    return brands;
  }

  Future<List<String>> getCategoriesList() async {
    List<String> categories = [];

    QuerySnapshot snapshot =
        await _firebaseFirestore.collection("categories").get();

    for (DocumentSnapshot documentSnapshot in snapshot.docs) {
      categories.add(documentSnapshot[productRef.category]);
    }

    return categories;
  }

  Future<void> productOperations(
      {File? image,
      String? type,
      String? productIdForUpdate,
      String? proName,
      String? desc,
      String? shortInf,
      String? brand,
      String? category,
      int? quantity,
      double? price,
      String? imgUrl}) async {
    ProductModel productModel = ProductModel();
    Map<String, dynamic>? data;
    if (type == "add") {
      String productId = DateTime.now().millisecondsSinceEpoch.toString();
      String downloadedURL = await uploadProductPictureToStorage(
          productPic: image, proId: productId);
      print(image!.path + "           " + downloadedURL);

      data = productModel.toMap(
          productId: productId,
          proName: proName,
          brand: brand,
          category: category!,
          quantity: quantity!,
          price: price,
          imgUrl: downloadedURL,
          desc: desc!,
          shortInf: shortInf);

      await createProduct(data: data);
    } else if (type == "update") {
      //deleting oldimage from storage
      if (image != null) {
        FirebaseStorage.instance.refFromURL(imgUrl!).delete();
        String downloadedURL = await uploadProductPictureToStorage(
            productPic: image, proId: productIdForUpdate);

        data = productModel.toMap(
            productId: productIdForUpdate,
            proName: proName!,
            brand: brand!,
            category: category!,
            quantity: quantity,
            price: price,
            imgUrl: downloadedURL,
            desc: desc,
            shortInf: shortInf);
      } else {
        data = productModel.toMap(
            productId: productIdForUpdate,
            proName: proName!,
            brand: brand!,
            category: category!,
            quantity: quantity,
            price: price,
            imgUrl: imgUrl,
            desc: desc,
            shortInf: shortInf);
      }
      await updateProduct(data: data);
    }
  }

  Future<void> createProduct({Map<String, dynamic>? data}) async {
    await _firebaseFirestore
        .collection(productRef.collection)
        .doc(data![productRef.productId])
        .set(data);
  }

  Future<void> updateProduct({Map<String, dynamic>? data}) async {
    await _firebaseFirestore
        .collection(productRef.collection)
        .doc(data![productRef.productId])
        .update(data);
  }

  Future<void> deleteProduct(String productId) async {
    _firebaseFirestore
        .collection(productRef.collection)
        .doc(productId)
        .delete();
  }

  Future<String> uploadProductPictureToStorage(
      {File? productPic, String? proId}) async {
    String imgFileName = proId!;
    String proImageUrl = "";

    try {
      Uint8List fileBytes = await productPic!.readAsBytes();

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("products pictures")
          .child(imgFileName);

      UploadTask storageUploadTask;
      if (kIsWeb)
        storageUploadTask = storageReference.putData(fileBytes);
      else
        storageUploadTask = storageReference.putFile(productPic);

      TaskSnapshot storageTaskSnapshot =
          await storageUploadTask.whenComplete(() {});

      proImageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return proImageUrl;
  }
}
