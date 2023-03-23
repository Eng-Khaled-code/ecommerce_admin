import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/services/dashboard_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardProvider extends ChangeNotifier {
  bool isLoading = false;

  int? usersCount;
  int? productsCount;
  int? ordersCount;
  double? revenueValue;
  int? soldCount;
  int? categoryCount;

  DashboardServices dashboardServices = DashboardServices();

  DashboardProvider() {
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      isLoading = true;
      notifyListeners();
      usersCount = await dashboardServices.getUsersCount();
      productsCount = await dashboardServices.getProductCount();
      ordersCount = await dashboardServices.getOrdersCount();
      revenueValue = await dashboardServices.getRevenue();
      soldCount = await dashboardServices.getSoldCount();
      categoryCount = await dashboardServices.getCategoryCount();

      isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }
}
