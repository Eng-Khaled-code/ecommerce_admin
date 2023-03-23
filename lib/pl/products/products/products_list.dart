import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/pl/products/products/product_card.dart';
import 'package:final_ecommerce_admin/pl/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product_model.dart';
import '../../../provider/product_provider.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/widgets/notification_card.dart';

// ignore: must_be_immutable
class ProductsListStreamBuilder extends StatelessWidget {
  ProductsListStreamBuilder({Key? key}) : super(key: key);

  String? screenSizeDesign;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    screenSizeDesign = Helper().getDesignSize(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: searchStream(productProvider),
          builder: (context, snapshot) {
            return !snapshot.hasData || productProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : snapshot.data!.size == 0 &&
                        productProvider.searchedValue == ""
                    ? NotificationCard(msg: "No items")
                    : snapshot.data!.size == 0 &&
                            productProvider.searchedValue != ""
                        ? NotificationCard(msg: "Retry Search")
                        : Container(
                            height: height,
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 7 / 2.5,
                                        maxCrossAxisExtent: screenSizeDesign ==
                                                Strings.smallDesign
                                            ? width
                                            : width * .4),
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, position) {
                                  ProductModel product =
                                      ProductModel.fromSnapshoot(
                                          snapshot.data!.docs[position].data());
                                  return ProductCard(
                                    productModel: product,
                                    productProvider: productProvider,
                                  );
                                }),
                          );
          }),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchStream(
      ProductProvider productProvider) {
    if (productProvider.searchedValue != "") {
      return productProvider.selectedCategory != "All"
          ? (FirebaseFirestore.instance
              .collection("products")
              .where("category", isEqualTo: productProvider.selectedCategory)
              .where("product_name",
                  isGreaterThanOrEqualTo: productProvider.searchedValue)
              .snapshots())
          : (FirebaseFirestore.instance
              .collection("products")
              .where("product_name",
                  isGreaterThanOrEqualTo: productProvider.searchedValue)
              .snapshots());
    } else {
      return productProvider.selectedCategory != "All"
          ? (FirebaseFirestore.instance
              .collection("products")
              .where("category", isEqualTo: productProvider.selectedCategory)
              .snapshots())
          : (FirebaseFirestore.instance.collection("products").snapshots());
    }
  }
}
