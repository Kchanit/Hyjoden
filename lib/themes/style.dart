import 'package:flutter/material.dart';
import 'package:hyjoden/themes/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Poppins',
    
    textTheme: const TextTheme(
      // login and register screen
      headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: kColorsBlack,),

      // app bar
      headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400, color: kColorsGrey),
      headline3: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: kColorsGrey),

      // headline in body
      headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: kColorsGrey),

      // subtitle
      subtitle1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: kColorsGrey),

      // error msg
      bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: kColorsGrey),
    ),
  );

}