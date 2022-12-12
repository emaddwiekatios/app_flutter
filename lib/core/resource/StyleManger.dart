import 'package:flutter/material.dart';

import 'FontManager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return  TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontManagerSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontManagerWeight.regular, color);
}
// light text style

TextStyle getLightStyle(
    {double fontSize = FontManagerSize.s14, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontManagerWeight.light, color);
}
// bold text style

TextStyle getBoldStyle(
    {double fontSize = FontManagerSize.s24, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontManagerWeight.bold, color);
}

// semi bold text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontManagerSize.s16, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontManagerWeight.semiBold, color);
}


// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontManagerSize.s14, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontManagerWeight.medium, color);
}
