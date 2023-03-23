import 'package:final_ecommerce_admin/provider/brand_provider.dart';
import 'package:final_ecommerce_admin/provider/category_provider.dart';
import 'package:flutter/material.dart';
import '../../../provider/product_provider.dart';

// ignore: must_be_immutable
class CustomSearchTextField extends StatelessWidget {
  CustomSearchTextField(
      {Key? key,
      this.type = "product",
      this.categoryProvider,
      this.brandProvider,
      this.productProvider})
      : super(key: key);

  late ProductProvider? productProvider;
  late BrandProvider? brandProvider;
  late CategoryProvider? categoryProvider;
  final String? type;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (type == "product")
            productProvider!.resetSearchAndCategory();
          else if (type == "brand")
            brandProvider!.resetSearch();
          else
            categoryProvider!.resetSearch();
          return true;
        },
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(18)),
          child: TextField(
            onChanged: (value) {
              if (type == "product")
                productProvider!.setSearchedValue(value);
              else if (type == "brand")
                brandProvider!.setSearchedValue(value);
              else
                categoryProvider!.setSearchedValue(value);
            },
            style: TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "   Search  ...",
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ),
        ));
  }
}
