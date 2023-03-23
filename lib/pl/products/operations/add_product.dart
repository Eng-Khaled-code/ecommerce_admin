import 'package:final_ecommerce_admin/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/strings.dart';
import '../../utilities/text_style/text_styles.dart';
import '../../utilities/widgets/custom_text_field.dart';
import 'brand_widget.dart';
import 'category_widget.dart';
import 'product_photo.dart';

// ignore: must_be_immutable
class AddProductPage extends StatelessWidget {
  final String? imgURL;
  final String? prodID;
  final String? type;
  String? prodName;
  int? qty;
  double? price;
  String? desc;
  String? shortInfo;

  AddProductPage(
      {Key? key,
      this.imgURL = "",
      this.prodName = "",
      this.qty = 0,
      this.price = 0,
      this.desc = "",
      this.shortInfo = "",
      this.prodID,
      @required this.type})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String? screenSizeDesign;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    screenSizeDesign = Helper().getDesignSize(context);
    return Padding(
      padding:
          EdgeInsets.all(screenSizeDesign == Strings.largeDesign ? 100 : 8.0),
      child: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  ProductPhotoWidget(
                    imgUrl: imgURL,
                    productProvider: productProvider,
                  ),
                  SizedBox(height: 10),
                  _buildProductNameTextField(),
                  SizedBox(height: 10),
                  _buildDescriptionTextField(),
                  SizedBox(height: 10),
                  _buildShortInfoTextField(),
                  SizedBox(height: 10),
                  CategoryWidget(productProvider: productProvider),
                  SizedBox(height: 10),
                  BrandWidget(productProvider: productProvider),
                  SizedBox(height: 10),
                  _buildQuantityTextField(),
                  SizedBox(height: 10),
                  _buildPriceTextField(),
                  SizedBox(height: 30),
                  buildSubmitButtonWidget(productProvider, context),
                ],
              )),
    );
  }

  Future<void> validateAndUpload(
      ProductProvider productProvider, BuildContext context) async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      if (await productProvider.productOperations(
          type: type,
          productIdForUpdate: prodID,
          proName: prodName,
          desc: desc,
          shortInf: shortInfo,
          quantity: qty,
          price: price,
          imgUrl: imgURL)) Navigator.pop(context);
    }
  }

  Widget _buildProductNameTextField() {
    return CustomTextField(
      icon: Icons.featured_play_list_outlined,
      onSave: (value) => prodName = value,
      label: "Product Name",
      initialValue: prodName,
    );
  }

  Widget _buildDescriptionTextField() {
    return CustomTextField(
      icon: Icons.description,
      onSave: (value) => desc = value,
      label: "Description",
      initialValue: desc,
    );
  }

  Widget _buildShortInfoTextField() {
    return CustomTextField(
      icon: Icons.info,
      onSave: (value) => shortInfo = value,
      label: "Short Info",
      initialValue: shortInfo,
    );
  }

  Widget _buildQuantityTextField() {
    return CustomTextField(
      icon: Icons.production_quantity_limits,
      onSave: (value) => qty = int.parse(value),
      label: "quantity",
      initialValue: qty.toString(),
      textInputType: TextInputType.number,
    );
  }

  Widget _buildPriceTextField() {
    return CustomTextField(
      icon: Icons.price_change_rounded,
      onSave: (value) => price = double.parse(value),
      label: "price",
      initialValue: price.toString(),
      textInputType: TextInputType.numberWithOptions(decimal: true),
    );
  }

  Widget buildSubmitButtonWidget(
      ProductProvider productProvider, BuildContext context) {
    return ElevatedButton(
      onPressed: () async => await validateAndUpload(productProvider, context),
      child: Text(type!, style: TextStyles.title),
    );
  }
}
