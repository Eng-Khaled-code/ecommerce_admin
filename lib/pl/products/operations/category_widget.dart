import 'package:flutter/material.dart';

import '../../../provider/product_provider.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({key, this.productProvider}) : super(key: key);

  final ProductProvider? productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider!.loadCategoriesList();

    return productProvider!.brandList == null
        ? Center(child: CircularProgressIndicator())
        : DropdownButtonFormField<String>(
            hint: Text('Choose a category'),
            value: productProvider!.category ??
                (productProvider!.categoriesList != null
                    ? productProvider!.categoriesList!.first
                    : ""),
            items: productProvider!.categoriesList == null
                ? []
                : productProvider!.categoriesList!.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
            onChanged: (String? value) =>
                productProvider!.setCategoryDropDown(value!));
  }
}
