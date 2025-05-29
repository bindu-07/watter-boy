import 'package:flutter/material.dart';
import 'package:water_boy/utils/theme/custom_themes/appbar_theme.dart';
import 'package:water_boy/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:water_boy/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:water_boy/utils/theme/custom_themes/chip_theme.dart';
import 'package:water_boy/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:water_boy/utils/theme/custom_themes/outlined_botton_theme.dart';
import 'package:water_boy/utils/theme/custom_themes/text_filed_theme.dart';
import 'package:water_boy/utils/theme/custom_themes/text_theme.dart';

class WatterAppTheme {
  WatterAppTheme._();

  ////  Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: WatterTextTheme.lightTextTheme,
    chipTheme: WatterChipTheme.lightChipTheme,
    elevatedButtonTheme: WatterElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: WatterAppBarTheme.lightAppBarTheme,
    checkboxTheme: WatterCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: WatterBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: WatterOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: WatterTextFiledTheme.lightInputDecorationTheme
  );

  ///// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: WatterTextTheme.darkTextTheme,
    chipTheme: WatterChipTheme.darkChipTheme,
    elevatedButtonTheme: WatterElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: WatterAppBarTheme.darkAppBarTheme,
    checkboxTheme: WatterCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: WatterBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: WatterOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: WatterTextFiledTheme.darkInputDecorationTheme
  );
}