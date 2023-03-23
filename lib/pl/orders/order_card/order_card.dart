import 'package:flutter/material.dart';
import '../../../models/cart_item_model.dart';
import '../../screen_template/screen_template.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/text_style/text_styles.dart';
import '../order_details/order_datails.dart';
import 'order_item.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List? orderData;
  final String? orderId;
  final bool? navigate;
  final double? orderTotalPrice;

  OrderCard(
      {Key? key,
      this.itemCount,
      this.orderData,
      this.orderId,
      this.navigate,
      this.orderTotalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (navigate == true) {
          Helper().goTo(
              context: context,
              to: ScreenTemplate(
                  OrderDetails(orderId: orderId!), "Order Details"));
        }
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: itemCount! * 230.0,
        decoration: cartDecoration(context),
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, position) {
            CartItemModel model =
                CartItemModel.fromSnapshot(orderData![position]);
            return Column(
              children: [
                position == 0 ? totalOrderPrice() : Container(),
                OrderItem(cartItemModel: model),
              ],
            );
          },
        ),
      ),
    );
  }

  BoxDecoration cartDecoration(BuildContext context) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.background == Colors.white
            ? Colors.blue
            : Theme.of(context).colorScheme.background);
  }

  Center totalOrderPrice() {
    return Center(
      child: Text(
        "Total Price : " + orderTotalPrice!.toStringAsFixed(1),
        style: TextStyles.title,
      ),
    );
  }
}
