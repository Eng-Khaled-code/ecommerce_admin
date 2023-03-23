
import 'package:final_ecommerce_admin/pl/drawer/drawer_tile.dart';
import 'package:final_ecommerce_admin/pl/screen_template/screen_template.dart';
import 'package:flutter/material.dart';
import '../brand/brand_list.dart';
import '../category/category_list.dart';
import '../help_page/help_page.dart';
import '../home/dashboard/dashboard.dart';
import '../orders/orders_page.dart';
import '../products/products/searching_screen.dart';
import '../setting/setting_page.dart';
import '../utilities/strings.dart';
import 'drawer_header.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          CustomDrawerHeader(),
          CustomDrawerTile(icon:Icons.home, text: "Home", to:ScreenTemplate(Dashboard(),Strings.appName)),
          CustomDrawerTile(icon:Icons.change_history, text: Strings.products, to: ScreenTemplate(SearchingScreen(),Strings.products)),
          CustomDrawerTile(icon:Icons.category, text: Strings.categories, to: ScreenTemplate(CategoryList(),Strings.categories)),
          CustomDrawerTile(icon:Icons.library_books,text: Strings.brands, to:ScreenTemplate(BrandList(),Strings.brands)),
          CustomDrawerTile(icon:Icons.shopping_cart,text: Strings.orders, to:ScreenTemplate(OrdersPage(),Strings.orders)),
          Divider(color: Colors.blueAccent,),
          CustomDrawerTile(icon:Icons.settings,text: Strings.setting,to :ScreenTemplate(SettingPage(),Strings.setting)),
          CustomDrawerTile(icon:Icons.help, text: Strings.help,to: ScreenTemplate(HelpPage(),Strings.help)),
        ],
      ),
    );
  }
}
