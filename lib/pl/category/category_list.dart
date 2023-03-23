import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce_admin/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../references/product_ref.dart';
import '../products/products/search_text_field.dart';
import '../utilities/helper/helper.dart';
import '../utilities/strings.dart';
import '../utilities/widgets/notification_card.dart';
import 'category_card.dart';

// ignore: must_be_immutable
class CategoryList extends StatelessWidget {
  String? screenSizeDesign;
  double? width;

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    screenSizeDesign = Helper().getDesignSize(context);
    width = MediaQuery.of(context).size.width;

    return Container(
        color: Theme.of(context).colorScheme.background == Colors.white
            ? Colors.blue
            : Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            CustomSearchTextField(
                type: "category", categoryProvider: categoryProvider),
            SizedBox(height: 20),
            categoryListWidget(categoryProvider),
          ],
        ));
  }

  Widget categoryListWidget(CategoryProvider categoryProvider) {
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
                stream: categoryProvider.searchStream(),
                builder: (context, snapshot) {
                  return !snapshot.hasData || categoryProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : snapshot.data!.size == 0 &&
                              categoryProvider.searchedValue == ""
                          ? NotificationCard(msg: "No items")
                          : snapshot.data!.size == 0 &&
                                  categoryProvider.searchedValue != ""
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
                                        return CategoryCard(
                                          categoryId:
                                              snapshot.data!.docs[position].id,
                                          category:
                                              snapshot.data!.docs[position]
                                                  [ProductRef().category],
                                          categoryProvider: categoryProvider,
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
