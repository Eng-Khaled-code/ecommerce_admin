import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/services/brand_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../references/product_ref.dart';

class BrandProvider with ChangeNotifier {
  bool isLoading = false;
  String searchedValue = "";

  BrandServices brandServices = BrandServices();

  setSearchedValue(String value) {
    searchedValue = value;
    notifyListeners();
  }

  resetSearch() {
    searchedValue = "";
    notifyListeners();
  }

  Future<void> addBrand({String? brand}) async {
    try {
      isLoading = true;
      notifyListeners();

      await brandServices.addBrand(brand!);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "brand added successfully");
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> updateBrand(
      {String? brandId, String? newName, String? oldName}) async {
    try {
      isLoading = true;
      notifyListeners();

      await brandServices.updateBrand(
          brandId: brandId, newName: newName, oldName: oldName);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "brand updated successfully");
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> deleteBrand({String? brandId, String? name}) async {
    try {
      isLoading = true;
      notifyListeners();

      await brandServices.deleteBrand(brandId: brandId, name: name);

      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "brand deleted successfully");
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
          .collection("brands")
          .where(ProductRef().brand, isGreaterThanOrEqualTo: searchedValue)
          .snapshots();
    } else {
      searchStream =
          FirebaseFirestore.instance.collection("brands").snapshots();
    }
    return searchStream;
  }
}
