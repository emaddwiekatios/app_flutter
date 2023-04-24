//import 'dart:html';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Category/CategoryMain.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductMain.dart';
import 'package:clean_arch_app/core/resource/RoutesManager.dart';
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
import 'Feature_Post/presentation/pages/Login/view_login/loginNew.dart';
import 'Feature_Post/presentation/pages/Login/view_login/view_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Feature_Post/presentation/pages/Products/ProductAdd.dart';


SharedPreferences? prefs;
void main() async {


  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();

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


        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: getApplicationTheme(),
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: RoutesManager.splashRoute,
          locale: lang,
          translations: LocaleLang(),
          //home: login(),
          home: controller.isAuth
              ?   PreHome():
               FutureBuilder(
                  future: controller.tryAutoLogin(),
                  builder: (context, authsnapshot)
               {
                 
                 return

                   authsnapshot.connectionState ==  ConnectionState.done
                        ? const Splash() //login()
                       :const  Splash();

              }
          ),

          routes: {

            '/Home': (context) => const Home(),
            '/PreHome': (context) => PreHome(),
            '/Splash': (context) => const Splash(),
            //'/ProductMain': (context) =>  ProductMain(),
            '/ProductMainNew': (context) =>  ProductMainNew(),
            '/ProductAdd': (context) =>  ProductAdd(),
            '/CategoryMain': (context) =>  CategoryMain(),


            '/Onboarding': (context) => const OnBoarding(),
            '/login': (context) => const login(),
            '/SignIn': (context) =>  SignIn(),



          },
        );
      }),
    );
  }
}
