import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../references/order_ref.dart';
import '../utilities/helper/helper.dart';
import '../utilities/strings.dart';
import '../utilities/widgets/notification_card.dart';
import 'order_card/order_card.dart';

// ignore: must_be_immutable
class OrdersPage extends StatelessWidget {
  String? screenSizeDesign;
  OrderRef orderRef = OrderRef();

  @override
  Widget build(BuildContext context) {
    screenSizeDesign = Helper().getDesignSize(context);
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: myStream(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : snapshot.data!.size == 0
                  ? NotificationCard(
                      msg: "Orders List Empty\n start adding orders")
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: .8,
                          maxCrossAxisExtent:
                              screenSizeDesign == Strings.smallDesign
                                  ? width
                                  : width * 0.41),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, position) {
                        return OrderCard(
                          itemCount: snapshot.data!.docs[position]
                              .get(orderRef.cartList)
                              .length,
                          orderData: snapshot.data!.docs[position]
                              .get(orderRef.cartList),
                          orderId: snapshot.data!.docs[position].id,
                          navigate: true,
                          orderTotalPrice: snapshot.data!.docs[position]
                              .get(orderRef.totalAmount),
                        );
                      });
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> myStream() {
    return FirebaseFirestore.instance
        .collection(orderRef.collection)
        .snapshots();
  }
}
