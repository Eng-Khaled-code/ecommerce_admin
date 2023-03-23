
import 'package:final_ecommerce_admin/provider/brand_provider.dart';
import 'package:final_ecommerce_admin/provider/dashboard_provider.dart';
import 'package:final_ecommerce_admin/pl/home/dashboard/dashboard.dart';
import 'package:final_ecommerce_admin/pl/screen_template/screen_template.dart';
import 'package:final_ecommerce_admin/pl/utilities/strings.dart';
import 'package:final_ecommerce_admin/provider/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'provider/category_provider.dart';
import 'provider/order_provider.dart';
import 'provider/theme_provider.dart';
import 'firebase_options.dart';
import 'pl/utilities/themes/app_thems/dark_them_data.dart';
import 'pl/utilities/themes/app_thems/light_them_data.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => BrandProvider()),

      ],
      child:
    Consumer<ThemeProvider>(
    builder: (context, theme, _) =>MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ecommerce app administration',
    themeMode:theme.themeMode==Strings.lightMode? ThemeMode.light:ThemeMode.dark,
    theme:lightThemeData(),
    darkTheme:darkThemeData(),
        home: ScreenTemplate(Dashboard(),Strings.appName),

    )));
  }
}
