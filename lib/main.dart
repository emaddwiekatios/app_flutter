//import 'dart:html';
import 'package:device_preview/device_preview.dart';

import 'package:clean_arch_app/Feature_Post/presentation/manager/Language/Locale.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/Auth.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/onbording/View_Onboarding/onbording.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/splash/splash.dart';

import 'package:clean_arch_app/core/resource/ThemeManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Feature_Post/presentation/pages/Home/Home.dart';
import 'Feature_Post/presentation/pages/Home/PreHome.dart';
import 'Feature_Post/presentation/pages/Login/view_login/view_login.dart';

SharedPreferences? prefs;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  //await GetStorage.init();
/////fdfdfdfdfdfdfd
  ////updaedddddd
  runApp(const MyApp());
     //emad 15/2/2023
  //   runApp(
  //     DevicePreview(
  //       enabled: true,
  //       tools: [
  //         ...DevicePreview.defaultTools,
  //        // const CustomPlugin(),
  //       ],
  //       builder: (context) => const MyApp(),
  //     ),
  //   );

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
              ?   PreHome():
               FutureBuilder(
                  future: controller.tryAutoLogin(),
                  builder: (context, authsnapshot)
               {print(' controller.isAuth=${ controller.isAuth}');
                print('authsnapshot connectionState${authsnapshot.connectionState}');
                 return

                   authsnapshot.connectionState ==  ConnectionState.waiting
                          ? const Splash()
                          : const login();
                         // : login();
              }
          ),

          routes: {

            '/Home': (context) => const Home(),
            '/PreHome': (context) => PreHome(),
            '/Splash': (context) => const Splash(),
            '/Onboarding': (context) => const OnBoarding(),
            '/login': (context) => const login(),

          },
        );
      }),
    );
  }
}
