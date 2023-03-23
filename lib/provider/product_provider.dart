import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/product_services.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;

  ProductServices productServices = ProductServices();

  String searchedValue = "";
  String selectedCategory = "All";

  File? imageFile;
  String? category;
  String? brand;
  List<String>? categoriesList;

  List<String>? brandList;

  Future<void> loadBrandList() async {
    brandList = await productServices.getBrandsList();
    notifyListeners();
  }

  setBrand(String brand1) {
    brand = brand1;
    notifyListeners();
  }

  setCategoryDropDown(String category1) {
    category = category1;
    notifyListeners();
  }

  setProductImage(File image) {
    imageFile = image;
    notifyListeners();
  }

  setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  setSearchedValue(String value) {
    searchedValue = value;
    notifyListeners();
  }

  resetSearchAndCategory() {
    selectedCategory = "All";
    searchedValue = "";
    notifyListeners();
  }

  Future<void> loadCategoriesList() async {
    categoriesList = await productServices.getCategoriesList();
    notifyListeners();
  }

  Future<bool> productOperations(
      {String? type,
      String? productIdForUpdate,
      String? proName,
      String? desc,
      String? shortInf,
      int? quantity,
      double? price,
      String? imgUrl}) async {
    try {
      isLoading = true;
      notifyListeners();

      await productServices.productOperations(
          image: imageFile,
          type: type,
          productIdForUpdate: productIdForUpdate,
          proName: proName,
          desc: desc,
          shortInf: shortInf,
          brand: brand,
          category: category,
          quantity: quantity,
          price: price,
          imgUrl: imgUrl);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "Product " + type! + "ed successfully");
      return true;
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!);
      return false;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      isLoading = true;
      notifyListeners();

      await productServices.deleteProduct(productId);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "Product deleted successfully");
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!);
    }
  }
}
