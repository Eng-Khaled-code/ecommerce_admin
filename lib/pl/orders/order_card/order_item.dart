import 'package:flutter/material.dart';

import '../../../models/cart_item_model.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, this.cartItemModel}) : super(key: key);

  final CartItemModel? cartItemModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 190.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              itemImage(),
              SizedBox(width: 20.0),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(
                          cartItemModel!.name!,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(
                          cartItemModel!.shortInfo!,
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Expanded(
                        child: Text(
                      "Item count : " + cartItemModel!.itemCount.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Expanded(
                        child: Text(
                      "Unit price : " + cartItemModel!.unitPrice.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  "Total Price : ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(cartItemModel!.price.toString() + " \$",
                                    style: TextStyle(color: Colors.yellow))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // Flexible(child: Container()),
                ],
              ))
            ],
          ),
        ),
        Divider(
          height: 5.0,
          color: Colors.white,
        )
      ],
    );
  }

  Padding itemImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/glow.gif',
          imageSemanticLabel: "image loading",
          image: cartItemModel!.imageURL!,
          width: 120.0,
          height: 150.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
