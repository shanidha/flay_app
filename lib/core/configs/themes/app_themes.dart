import 'package:flay_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    fontFamily: FontConstants.fontFamily,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.dark,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.background,
      contentTextStyle: TextStyle(color: AppColors.primary),
    ),
       textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary,
      selectionHandleColor:AppColors.primary, 
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle:  TextStyle(
        color:AppColors. primary,
        fontWeight: FontWeight.w400,
      ),
      
      contentPadding: const EdgeInsets.all(16),
      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineColor)),
                        
      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineColor)),
                        focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineColor)),
      border:const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineColor)),
      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineColor)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color: AppColors.background),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
    ),
  );
}
