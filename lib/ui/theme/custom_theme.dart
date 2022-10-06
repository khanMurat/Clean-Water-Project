import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme._init();
  static final CustomTheme _instance = CustomTheme._init();
  static CustomTheme get instance => _instance;

  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorKit.welcomeBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorKit.blueShade,
      elevation: 1,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        color: ColorKit.whiteColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: ColorKit.cyanColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: ColorKit.blueColor,
        primary: ColorKit.blueShade,
        shape: const StadiumBorder(),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorKit.blueShade,
    ),
  );
}
