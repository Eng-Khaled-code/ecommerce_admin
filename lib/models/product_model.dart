import 'package:cloud_firestore/cloud_firestore.dart';

import '../references/product_ref.dart';

class ProductModel
{

  String? id;
  String? category;
  String? name;
  String? brand;
  String? imageURL;
  int? quantity;
  double? price;
  String? desc;
  Timestamp? publishDate;
  String? shortInfo;
  String? status;
  int? likeCounter;

  ProductRef productRef=ProductRef();

  ProductModel();
  ProductModel.some(this.id,this.price,this.name,this.imageURL,this.shortInfo);

  ProductModel.fromSnapshoot(Map<String,dynamic> productData )
  {

    id = productData[productRef.productId];
    category = productData[productRef.category];
    name = productData[productRef.productName];
    brand = productData[productRef.brand];
    price = productData[productRef.price];
    quantity = productData[productRef.quantity];
    imageURL=productData[productRef.imageUrl];
    desc=productData[productRef.description];
    publishDate=productData[productRef.publishDate];
    shortInfo=productData[productRef.shortInfo];
    status=productData[productRef.status];
    likeCounter=productData[productRef.likeCounter]??0;

  }

  Map<String,dynamic> toMap({String?productId,String? proName,String? desc,String? shortInf,String?brand,String?category,int?quantity,double?price,String?imgUrl}){
    return {

      productRef.productId:productId,
      productRef.productName:proName,
      productRef.description:desc,
      productRef.shortInfo:shortInf,
      productRef.brand:brand,
      productRef.category:category,
      productRef.quantity:quantity,
      productRef.price:price,
      productRef.imageUrl:imgUrl,
      productRef.status:'avalible',
      productRef.publishDate:DateTime.now(),

    };
  }

}