import 'package:final_ecommerce_admin/pl/utilities/strings.dart';
import 'package:final_ecommerce_admin/pl/utilities/text_style/text_styles.dart';
import 'package:final_ecommerce_admin/pl/utilities/widgets/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../drawer/drawer.dart';
import 'floating_action_button.dart';

class ScreenTemplate extends StatelessWidget {
  ScreenTemplate(this.body, this.appBarTitle);
  final Widget? body;
  final String? appBarTitle;
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    bool showFAB = (appBarTitle == Strings.products ||
            appBarTitle == Strings.brands ||
            appBarTitle == Strings.categories)
        ? true
        : false;
    return WillPopScope(
        onWillPop: () async {
          bool con = appBarTitle == Strings.appName ? false : true;
          !con
              ? showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("خروج"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: Text("yes")),
                          CancelButton(
                            textColor: Colors.black,
                            fontSize: 12,
                          ),
                        ],
                        content: Text("هل تريد الخروج من التطبيق بالفعل"),
                      ))
              :
              // ignore: unnecessary_statements
              () {};
          return true;
        },
        child: Scaffold(
          key: scafoldKey,
          appBar: buildingMainAppBar(),
          drawer: MyDrawer(),
          floatingActionButton:
              showFAB ? CustomFloatingAButton(type: appBarTitle) : null,
          body: body,
        ));
  }

  AppBar buildingMainAppBar() {
    return AppBar(
      title: Text(appBarTitle!, style: TextStyles.title),
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
