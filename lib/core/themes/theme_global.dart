import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';

class ThemeGlobal {
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.primary,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme:  ColorScheme.light(
        primary: Colors.white,
        onPrimary: AppColors.primary,
        surface: AppColors.primary,
        onSurface: Colors.white,
      ));
}
