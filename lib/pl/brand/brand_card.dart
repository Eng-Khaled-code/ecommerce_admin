import 'package:final_ecommerce_admin/provider/brand_provider.dart';
import 'package:flutter/material.dart';

import '../utilities/widgets/input_dialog.dart';

class BrandCard extends StatelessWidget {
  const BrandCard(
      {Key? key,
      @required this.brand,
      @required this.brandId,
      this.brandProvider})
      : super(key: key);
  final String? brandId;
  final String? brand;
  final BrandProvider? brandProvider;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(brandId!),
      onDismissed: (direction) async =>
          brandProvider!.deleteBrand(brandId: brandId, name: brand),
      child: ListTile(
        onTap: () => updateBrand(context),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              brand!,
              style: TextStyle(color: Colors.blue),
            ),
            Divider(
              height: 2.0,
              color: Colors.blue,
            )
          ],
        ),
      ),
      background: dismissibleBackground(),
    );
  }

  updateBrand(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => InputDialog(
              title: "Update Brand",
              initialValue: brand,
              onSave: (value) async {
                Navigator.pop(context);
                await brandProvider!.updateBrand(
                    brandId: brandId, newName: value, oldName: brand);
              },
            ));
  }

  Container dismissibleBackground() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red[100], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [Spacer(), Icon(Icons.delete, size: 30)],
      ),
    );
  }
}
