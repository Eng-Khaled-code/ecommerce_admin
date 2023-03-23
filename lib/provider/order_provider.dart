import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/services/order_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderProvider with ChangeNotifier {
  bool loading = false;
  int? count;
  int? soldCount;
  double? revenue;
  OrderServices _orderServices = OrderServices();

  Future<void> sendOrder({String? orderId}) async {
    try {
      loading = true;
      notifyListeners();

      await _orderServices.sendOrder(orderId: orderId);
      notifyListeners();

      loading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "Order has been Sent successfully");
    } on FirebaseException catch (e) {
      loading = false;
      Fluttertoast.showToast(msg: e.message!);
      notifyListeners();
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> myStream({String? orderId}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> _stream = FirebaseFirestore
        .instance
        .collection("orders")
        .doc(orderId)
        .get()
        .asStream();
    return _stream;
  }
}
