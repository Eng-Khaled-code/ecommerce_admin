
import 'package:final_ecommerce_admin/pl/products/products/products_list.dart';
import 'package:final_ecommerce_admin/pl/products/products/search_text_field.dart';
import 'package:final_ecommerce_admin/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'categories_list_widget.dart';

class SearchingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider=Provider.of<ProductProvider>(context);
    return  Container(
        color: Theme.of(context).colorScheme.background==Colors.white?Colors.blue:Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            CustomSearchTextField(productProvider:productProvider),
            CategoriesListWidget(),
            SizedBox(height: 20),
            products()],
        ),

    );
  }

 Expanded products(){
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35)),
                color: Colors.white),
          ),
          ProductsListStreamBuilder(),

        ],
      ),
    );
  }
}
