import 'package:final_ecommerce_admin/pl/products/operations/add_product.dart';
import 'package:final_ecommerce_admin/provider/product_provider.dart';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../screen_template/screen_template.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/text_style/text_styles.dart';

class ProductCard extends StatelessWidget {
  final ProductModel? productModel;
  ProductCard({Key? key, this.productModel, this.productProvider})
      : super(key: key);
  final ProductProvider? productProvider;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(productModel!.id!),
      onDismissed: (direction) async =>
          await productProvider!.deleteProduct(productModel!.id!),
      child: InkWell(
          onTap: () => updateProduct(context),
          child: Container(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              borderContainer(context),
              cardImage(),
            ],
          ))),
      background: dismissibleBackground(),
    );
  }

  Container dismissibleBackground() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red[100], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Spacer(),
          Icon(
            Icons.delete,
            size: 30,
          )
        ],
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: Colors.lightBlueAccent,
    );
  }

  Container borderContainer(BuildContext context) {
    return Container(
      height: 136,
      decoration: decoration(),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: .5)]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [topLeftTextWidget(context), bottomRow(context)]),
      ),
    );
  }

  cardImage() {
    return Positioned(
        top: 5,
        right: 15.0,
        bottom: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.0),
          child: FadeInImage.assetNetwork(
            image: productModel!.imageURL!,
            fit: BoxFit.cover,
            width: 130.0,
            placeholder: 'assets/images/glow.gif',
          ),
        ));
  }

  topLeftTextWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(productModel!.name!, style: TextStyles.title),
            Text(
              productModel!.shortInfo!,
              maxLines: 2,
            ),
            Text(
              "Brand : " + productModel!.brand!,
            )
          ],
        ),
      ),
    );
  }

  bottomRow(BuildContext context) {
    return Row(
      children: [priceContainer(), favButton(), quantityContainer()],
    );
  }

  favButton() {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite,
            color: Colors.pinkAccent,
          ),
          SizedBox(width: 5.0),
          Text(productModel!.likeCounter.toString())
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
    );
  }

  Container priceContainer() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      child: Text("${productModel!.price}\$"),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Container quantityContainer() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      child: Text("Qty: ${productModel!.quantity}",
          style: TextStyle(color: Colors.white)),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  updateProduct(BuildContext context) {
    Helper().goTo(
        context: context,
        to: ScreenTemplate(
            AddProductPage(
              type: "update",
              qty: productModel!.quantity,
              desc: productModel!.desc,
              shortInfo: productModel!.shortInfo,
              price: productModel!.price,
              prodID: productModel!.id,
              prodName: productModel!.name,
              imgURL: productModel!.imageURL,
            ),
            "Update Product"));

    productProvider!.setBrand(productModel!.brand!);
    productProvider!.setCategoryDropDown(productModel!.category!);
  }
}
