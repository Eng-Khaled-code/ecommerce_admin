import 'package:final_ecommerce_admin/pl/screen_template/screen_template.dart';
import 'package:final_ecommerce_admin/pl/utilities/helper/helper.dart';
import 'package:final_ecommerce_admin/pl/utilities/strings.dart';
import 'package:final_ecommerce_admin/provider/brand_provider.dart';
import 'package:final_ecommerce_admin/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../products/operations/add_product.dart';
import '../utilities/widgets/input_dialog.dart';

class CustomFloatingAButton extends StatelessWidget {
  const CustomFloatingAButton({Key? key, this.type}) : super(key: key);
  final String? type;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => onPress(context),
      label: Text(
        type == Strings.products
            ? "Add Product"
            : type == Strings.categories
                ? "Add Category"
                : "Add brand",
        style: TextStyle(color: Colors.white),
      ),
      icon: Icon(Icons.add_shopping_cart),
      isExtended: true,
      elevation: 2.0,
    );
  }

  onPress(BuildContext context) {
    if (type == Strings.products)
      Helper().goTo(
          context: context,
          to: ScreenTemplate(AddProductPage(type: "add"), "Add Product"));
    else if (type == Strings.brands)
      addBrand(context);
    else
      addCategory(context);
  }

  void addBrand(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InputDialog(
              title: "Add Brand",
              onSave: (value) async {
                Navigator.pop(context);
                await Provider.of<BrandProvider>(context, listen: false)
                    .addBrand(brand: value);
              },
            ));
  }

  void addCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InputDialog(
              title: "Add Category",
              onSave: (value) async {
                Navigator.pop(context);
                await Provider.of<CategoryProvider>(context, listen: false)
                    .addCategory(category: value);
              },
            ));
  }
}
