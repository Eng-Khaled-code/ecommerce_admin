import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/pl/orders/order_details/shipping_address/shipping_details.dart';
import 'package:final_ecommerce_admin/pl/orders/order_details/status_banner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../provider/order_provider.dart';
import '../../../references/order_ref.dart';
import '../../utilities/text_style/text_styles.dart';
import '../order_card/order_card.dart';

// ignore: must_be_immutable
class OrderDetails extends StatelessWidget {
  final String? orderId;

  OrderDetails({Key? key, this.orderId}) : super(key: key);
  OrderRef orderRef = OrderRef();
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: orderProvider.myStream(orderId: orderId),
      builder: (con, snap) {
        Map<String, dynamic> data = {};

        if (snap.hasData) data = snap.data!.data()!;

        return !snap.hasData
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusBanner(status: data[orderRef.isSuccess]),
                    totalAmountWidget(data[orderRef.totalAmount]),
                    orderIdWidget(),
                    orderTime(data[orderRef.orderTime]),
                    Divider(height: 2.0),
                    OrderCard(
                        itemCount: data[orderRef.cartList].length,
                        orderData: data[orderRef.cartList],
                        navigate: false,
                        orderId: orderId,
                        orderTotalPrice: data[orderRef.totalAmount]),
                    Divider(height: 2.0),
                    ShippingDetails(
                      orderProvider: orderProvider,
                      status: data[orderRef.isSuccess],
                      orderId: orderId,
                      userId: data[orderRef.orderBy],
                      addressId: data[orderRef.addressId],
                    )
                  ],
                ),
              );
      },
    );
  }

  Padding orderTime(String time) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text("Order At : " +
            DateFormat("dd MMMM yyyy - hh:mm aa").format(
                DateTime.fromMicrosecondsSinceEpoch(int.tryParse(time)!))));
  }

  Padding orderIdWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text("Order ID : " + orderId!));
  }

  Padding totalAmountWidget(double totalAmount) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Total amount : " + totalAmount.toStringAsFixed(1),
          style: TextStyles.title,
        ),
      ),
    );
  }
}
