import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/product_provider.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider=Provider.of<ProductProvider>(context);

    return Container(
      height: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance.collection("categories").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? CircularProgressIndicator()
                : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.size,
                itemBuilder: (BuildContext context,int position){
                  QuerySnapshot data=snapshot.data!;

                QueryDocumentSnapshot item=data.docs[position];
                   return InkWell(
                  onTap: ()=>
                    productProvider.setCategory(item.get("category")),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(item.get("category"),style: TextStyle(color: Colors.white),),
                    decoration: BoxDecoration(
                        color :item.get("category") ==productProvider.selectedCategory? Colors.white.withOpacity(0.4): Colors.transparent,
                        borderRadius: BorderRadius.circular(12.0)),
                  ));});
          }),
    );
  }
}
