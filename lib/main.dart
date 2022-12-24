import 'package:clean_arch_app/Feature_Post/presentation/manager/Language/Locale.dart';

import 'package:clean_arch_app/core/resource/RoutesManager.dart';
import 'package:clean_arch_app/core/resource/ThemeManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Feature_Post/presentation/pages/Home/Home.dart';

SharedPreferences? prefs;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  //await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Locale lang = prefs!.getString('Lang') == 'ar'
        ? const Locale('ar')
        : const Locale('en');
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: RoutesManager.splashRoute,
      locale: lang,
      translations: LocaleLang(),
      // home: const splash(),
      routes: {
        'Home': (context) => const Home(),
      },
    );
  }
}
