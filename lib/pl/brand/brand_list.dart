import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/provider/brand_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../references/product_ref.dart';
import '../products/products/search_text_field.dart';
import '../utilities/helper/helper.dart';
import '../utilities/strings.dart';
import '../utilities/widgets/notification_card.dart';
import 'brand_card.dart';

// ignore: must_be_immutable
class BrandList extends StatelessWidget {
  String? screenSizeDesign;
  double? width;
  @override
  Widget build(BuildContext context) {
    BrandProvider brandProvider = Provider.of<BrandProvider>(context);
    screenSizeDesign = Helper().getDesignSize(context);
    width = MediaQuery.of(context).size.width;
    return Container(
        color: Theme.of(context).colorScheme.background == Colors.white
            ? Colors.blue
            : Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            CustomSearchTextField(type: "brand", brandProvider: brandProvider),
            SizedBox(height: 20),
            brandListWidget(brandProvider),
          ],
        ));
  }

  Widget brandListWidget(BrandProvider brandProvider) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35)),
                color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: brandProvider.searchStream(),
                builder: (context, snapshot) {
                  return !snapshot.hasData || brandProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : snapshot.data!.size == 0 &&
                              brandProvider.searchedValue == ""
                          ? NotificationCard(msg: "No items")
                          : snapshot.data!.size == 0 &&
                                  brandProvider.searchedValue != ""
                              ? NotificationCard(msg: "Retry Search")
                              : Container(
                                  height: 500,
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20,
                                              childAspectRatio: 6,
                                              maxCrossAxisExtent:
                                                  screenSizeDesign ==
                                                          Strings.smallDesign
                                                      ? width!
                                                      : width! * .3),
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: (context, position) {
                                        return BrandCard(
                                          brandId:
                                              snapshot.data!.docs[position].id,
                                          brand: snapshot.data!.docs[position]
                                              [ProductRef().brand],
                                          brandProvider: brandProvider,
                                        );
                                      }),
                                );
                }),
          )
        ],
      ),
    );
  }
}
