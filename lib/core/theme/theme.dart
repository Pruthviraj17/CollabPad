import 'package:flutter/material.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          width: 2,
          color: color,
        ),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallate.backGrounfGradient2,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _border(Pallate.textFadeColor),
      fillColor: Pallate.textFillColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
        borderSide: const BorderSide(
          color: Pallate.transparentColor,
        ),
      ),
      filled: true,
    ),
  );
}
