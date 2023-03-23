import 'package:flutter/material.dart';

import '../utilities/strings.dart';
class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
    UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage:AssetImage(Strings.appIconAssets) ,
        backgroundColor: Colors.grey,
      ),
      accountEmail: Text("ecommerce.com"),
      accountName: Text( "Admin application"),
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
