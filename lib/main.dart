import 'package:clean_arch_app/Feature_Post/presentation/manager/Language/Locale.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/Auth.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/onbording/View_Onboarding/onbording.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/splash/splash.dart';

import 'package:clean_arch_app/core/resource/ThemeManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Feature_Post/presentation/pages/Home/Home.dart';
import 'Feature_Post/presentation/pages/Login/view_login/view_login.dart';

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
  //myappp  new  one
  @override
  Widget build(BuildContext context) {
    Locale lang = prefs!.getString('Lang') == 'ar'
        ? const Locale('ar')
        : const Locale('en');
    return GetBuilder<Auth>(
      init: Auth(),
      builder: ((controller) {

        //print('controller=');
        //print(controller.isAuth);
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: getApplicationTheme(),
          // onGenerateRoute: RouteGenerator.getRoute,
          // initialRoute: RoutesManager.splashRoute,
          locale: lang,
          translations: LocaleLang(),
          //home: login(),
          home: controller.isAuth
              ?  const Home()
              : FutureBuilder(
                  future: controller.tryAutoLogin(),
                  builder: (context, authsnapshot)
              {
               // print('authsnapshot.connectionState');
               // print(authsnapshot.connectionState);
              //  print(controller.token);
                 return  authsnapshot.connectionState == ConnectionState.waiting
                          ?const  Splash()
                           : const login();

                         // : login();
              }
          ),
          routes: {
            '/Home': (context) => const Home(),
            '/Splash': (context) => const Splash(),
            '/Onboarding': (context) => const OnBoarding(),
            '/login': (context) => const login(),
          },
        );
      }),
    );
  }
}
