import 'package:cloud_firestore/cloud_firestore.dart';

import '../references/order_ref.dart';
import '../references/product_ref.dart';

class DashboardServices
{

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  OrderRef orderRef=OrderRef();

  Future<int> getUsersCount()async{

    int count=0;
    QuerySnapshot snapshot  =
    await _firebaseFirestore
        .collection("users")
        .get();

    count=snapshot.size;

    return count;
  }

  Future<int> getProductCount()async{

  int? count;
    QuerySnapshot snapshot  =
    await _firebaseFirestore
        .collection(ProductRef().collection)
        .get();

    count=snapshot.size;

    return count;
  }

  Future<int> getOrdersCount ()async {
    int? count;

    QuerySnapshot snapshot=
    await _firebaseFirestore
        .collection(orderRef.collection)
        .get();

    count=snapshot.size;
    return count;
  }

  Future<int> getSoldCount ()async {
    int count=0;

    QuerySnapshot snapshot=
    await _firebaseFirestore
        .collection(orderRef.collection)
        .get();

    snapshot.docs.forEach((element) {
      count +=element.get(orderRef.totalItemCount) as int;
    });

    return count;
  }

  Future<double> getRevenue ()async {
    double count=0;

    QuerySnapshot snapshot=  await _firebaseFirestore
        .collection(orderRef.collection)
        .where(orderRef.isSuccess,isEqualTo: "recived")
        .get();

    snapshot.docs.forEach((element) {
      count+=element.get(orderRef.totalAmount);
    });

    return count;
  }

  Future<int> getCategoryCount ()async{
    int?count;
   QuerySnapshot snapshot= await _firebaseFirestore
      .collection("categories")
      .get();

  count=snapshot.size;
  return count;
  }


}