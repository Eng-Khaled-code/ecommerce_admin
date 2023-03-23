
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';
import '../utilities/helper/helper.dart';
import '../utilities/strings.dart';

class CustomDrawerTile extends StatelessWidget {
  const CustomDrawerTile({Key? key,this.text,this.to,this.icon}) : super(key: key);
  final IconData? icon;
  final String? text;
  final Widget? to;


  @override
  Widget build(BuildContext context) {
     Color color=text=="Help"?Colors.greenAccent:Colors.blueAccent;
    return ListTile(
    title: Text(text!),
    leading: Icon(
    icon,
    color:color,
    ),
    onTap: ()=>text=="Night mode"?(){} :Helper().goTo(to: to,context: context),
      trailing: text=="Night mode"?switchMode():null,
    );
  }

Consumer switchMode(){

  return Consumer<ThemeProvider>(
      builder: (context, theme, _)=>
          Switch(
              value:theme.themeMode==Strings.darkMode ,
              onChanged: (value){
                String newValue=value ?Strings.darkMode:Strings.lightMode;
                theme.setThemeMode(newValue);

              }));
}

}
