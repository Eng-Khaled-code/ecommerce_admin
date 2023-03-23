import 'package:flutter/material.dart';
import '../../../provider/product_provider.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({key, this.productProvider}) : super(key: key);
  final ProductProvider? productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider!.loadBrandList();

    return productProvider!.brandList == null
        ? Center(child: CircularProgressIndicator())
        : DropdownButtonFormField<String>(
            hint: Text('Choose a brand'),
            value: productProvider!.brand ??
                (productProvider!.brandList != null
                    ? productProvider!.brandList!.first
                    : ""),
            items: productProvider!.brandList == null
                ? []
                : productProvider!.brandList!.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
            onChanged: (String? value) => productProvider!.setBrand(value!));
  }
}
