import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/references/order_ref.dart';

class OrderServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  OrderRef orderRef = OrderRef();

  Future<void> sendOrder({String? orderId, int? quantity}) async {
    await _firestore
        .collection(orderRef.collection)
        .doc(orderId)
        .update({orderRef.isSuccess: "sent"});
  }
}
