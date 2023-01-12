import 'ColorManger.dart';
import 'FontManager.dart';
import 'StyleManger.dart';
import 'package:flutter/material.dart';

import 'ValueManger.dart';
ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkGrey,
      disabledColor: ColorManager.grey, // will be used incase of disabled button for example
      // ripple color
      splashColor: ColorManager.primaryOpacity70,
    // card view theme
      //disabledColor: ColorManager.grey1,
      // will be used incase of disabled button for example
      //accentColor: ColorManager.grey,
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s8),


    // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s8,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontManagerSize.s16)),
    // App bar theme

    // Button theme
      buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
  disabledColor: ColorManager.grey1,
  buttonColor: ColorManager.primary,
  splashColor: ColorManager.primaryOpacity70),

  // elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  textStyle: getRegularStyle(color: ColorManager.white), backgroundColor: ColorManager.primary,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(AppSize.s8)))),


  // Text theme


      textTheme: TextTheme(
  headline1: getSemiBoldStyle(
  color: ColorManager.darkGrey, fontSize: FontManagerSize.s16),
  subtitle1: getMediumStyle(
  color: ColorManager.lightGrey, fontSize: FontManagerSize.s14),
  caption: getRegularStyle(color: ColorManager.grey1),
  bodyText1: getRegularStyle(color: ColorManager.grey)),

    // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.grey1),

        // label style
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s2),
            borderRadius: const  BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s4),
            borderRadius:const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s2),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s2),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));


}