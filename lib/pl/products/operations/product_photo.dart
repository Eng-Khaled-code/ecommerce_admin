import 'dart:io';
import 'package:final_ecommerce_admin/provider/product_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilities/text_style/text_styles.dart';

class ProductPhotoWidget extends StatelessWidget {
  ProductPhotoWidget(
      {Key? key, required this.imgUrl, required this.productProvider})
      : super(key: key);
  final String? imgUrl;
  final ProductProvider? productProvider;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressProductPhotoButton(context),
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1)),
      child: displayImage1(),
    );
  }

  onPressProductPhotoButton(BuildContext context) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Product Image",
              style: TextStyles.title,
            ),
            children: [
              SimpleDialogOption(
                child: Text("Capture with camera"),
                onPressed: () => picImage(ImageSource.camera, context),
              ),
              SimpleDialogOption(
                child: Text("Select from Gallery"),
                onPressed: () => picImage(ImageSource.gallery, context),
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  picImage(ImageSource imageSource, BuildContext context) async {
    Navigator.pop(context);
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    File image = File(pickedImage!.path);
    productProvider!.setProductImage(image);
  }

  Widget displayImage1() {
    if (productProvider!.imageFile == null && imgUrl == "")
      return Icon(Icons.add, size: 100, color: Colors.grey);
    else if (productProvider!.imageFile == null && (imgUrl != ""))
      return Image.network(
        imgUrl!,
        fit: BoxFit.cover,
      );
    else {
      if (kIsWeb)
        return Image.network(
          productProvider!.imageFile!.path,
          fit: BoxFit.cover,
        );
      else
        return Image.file(
          productProvider!.imageFile!,
          fit: BoxFit.cover,
        );
    }
  }
}
