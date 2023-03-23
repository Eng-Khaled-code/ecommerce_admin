
class CartItemModel {


  String? id;
  String? name;
  int? itemCount;
  double? price;
  String? imageURL;
  String? shortInfo;
  double? unitPrice;
  CartItemModel({this.name,this.itemCount,this.price,this.id,this.imageURL,this.shortInfo,this.unitPrice});

  CartItemModel.fromSnapshot(Map<String,dynamic> data){
    id=data["id"];
    name=data["product_name"];
    itemCount=data["item_count"];
    price=data["total_price"];
    imageURL=data["image_url"];
    shortInfo=data["short_info"];
    unitPrice=data["unit_price"];


  }


}
