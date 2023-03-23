import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../models/address_model.dart';
import '../../../../provider/order_provider.dart';
import '../../../../references/address_ref.dart';
import '../../../utilities/text_style/text_styles.dart';
import 'address_details.dart';

class ShippingDetails extends StatelessWidget {
  final String? orderId;
  final String? addressId;
  final String? status;
  final OrderProvider? orderProvider;
  final String? userId;

  ShippingDetails(
      {Key? key,
      this.orderId,
      this.status,
      this.orderProvider,
      this.userId,
      this.addressId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: myStream(),
        builder: (con, dataSnap) {
          return !dataSnap.hasData
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        title(),
                        AddressDetailsTable(
                          addressModel:
                              AddressModel.fromSnapshot(dataSnap.data!),
                        ),
                        Divider(height: 2.0),
                        sendOrderButton()
                      ]),
                );
        });
  }

  sendOrder(String status) async {
    if (status == "not checked") {
      await orderProvider!.sendOrder(orderId: orderId!);
    } else if (status == "sent") {
      Fluttertoast.showToast(msg: "you sent this order before");
    } else if (status == "recived")
      Fluttertoast.showToast(msg: "the client has received this order");
    else {
      Fluttertoast.showToast(msg: "the client has received this order");
    }
  }

  Padding title() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Text(
        "Shipment Details",
        style: TextStyles.title,
      ),
    );
  }

  Widget sendOrderButton() {
    return orderProvider!.loading
        ? CircularProgressIndicator()
        : status == "not checked"
            ? Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () async => await sendOrder(status!),
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Send Order",
                        ),
                      ),
                    )))
            : Container();
  }

  myStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection(AddressRef().collection)
        .doc(addressId)
        .get();
  }
}
