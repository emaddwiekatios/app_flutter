

import 'dart:ui';

import 'package:get/get.dart';
import 'package:clean_arch_app/main.dart';


class  LocaleController extends GetxController
 {


 Locale currentLanguage=
 prefs!.getString('Lang') == 'ar' ?
 const Locale('ar'): const Locale('en');

  void changeLanguage(Locale langCode)
    {

    currentLanguage=langCode;
     prefs!.setString('Lang', langCode.toString());
   // print('prefs =${prefs!.getString('Lang')}');
    Get.updateLocale(langCode);
  }

}