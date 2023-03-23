import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/services/category_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../references/product_ref.dart';

class CategoryProvider extends ChangeNotifier {
  bool isLoading = false;
  String searchedValue = "";

  CategoryServices categoryServices = CategoryServices();

  setSearchedValue(String value) {
    searchedValue = value;
    notifyListeners();
  }

  resetSearch() {
    searchedValue = "";
    notifyListeners();
  }

  Future<void> addCategory({String? category}) async {
    try {
      isLoading = true;
      notifyListeners();

      await categoryServices.addCategory(category!);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "category added successfully");
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> updateCategory(
      {String? categoryId, String? newName, String? oldName}) async {
    try {
      isLoading = true;
      notifyListeners();

      await categoryServices.updateCategory(
          categoryId: categoryId, newName: newName, oldName: oldName);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "category updated successfully");
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> deleteCategory({String? categoryId, String? name}) async {
    try {
      isLoading = true;
      notifyListeners();

      await categoryServices.deleteCategory(categoryId: categoryId, name: name);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "category deleted successfully");
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchStream() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? searchStream;
    if (searchedValue != "") {
      searchStream = FirebaseFirestore.instance
          .collection("categories")
          .where(ProductRef().category, isGreaterThanOrEqualTo: searchedValue)
          .snapshots();
    } else {
      searchStream =
          FirebaseFirestore.instance.collection("categories").snapshots();
    }
    return searchStream;
  }
}
