import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../pl/utilities/strings.dart';

class ThemeProvider with ChangeNotifier {

  String? themeMode;
  final GetStorage storage=GetStorage();
  ThemeProvider(){
    themeMode=storage.read(Strings.mode)??Strings.lightMode;

  }
  void setThemeMode(String mode){
    themeMode=mode;
    storage.write(Strings.mode,mode );
    notifyListeners();
  }

}