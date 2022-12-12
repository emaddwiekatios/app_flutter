import 'package:clean_arch_app/Feature_Post/presentation/manager/Language/Locale.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Onbording/View_Onboarding/onbording.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/splash/splash.dart';
import 'package:clean_arch_app/core/resource/RoutesManager.dart';
import 'package:clean_arch_app/core/resource/ThemeManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Feature_Post/presentation/manager/Language/LocaleController.dart';
SharedPreferences?  prefs;
void main() async{
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
  Widget build(BuildContext context)  {
      Locale lang = prefs!.getString('Lang') == 'ar' ? Locale('ar'):Locale('en');
    return GetMaterialApp(


      title: 'Flutter Demo',
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: RoutesManager.splashRoute,
     locale: lang ,
     translations: LocaleLang(),
     // home: const splash(),
    );
  }

}
