

import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_arch_app/main.dart';


class  LocaleController extends GetxController
 {


 Locale currentLanguage=
 prefs!.getString('Lang') == 'ar' ?
 Locale('ar'):Locale('en');

  void changeLanguage(Locale langcode)
    {

    currentLanguage=langcode;
     prefs!.setString('Lang', langcode.toString());
    print('prefs =${prefs!.getString('Lang')}');
    Get.updateLocale(langcode);
  }

}