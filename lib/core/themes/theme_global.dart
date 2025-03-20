import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';

class ThemeGlobal {
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.darkPrimary,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: AppColors.darkPrimary,
      surface: AppColors.darkPrimary,
      onSurface: Colors.white,
    ),
  );
}
