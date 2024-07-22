// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Pallate {
  Color selectedBackGrounfGradient1;
  Color selectedBackGrounfGradient2;
  Color selectedBackGrounfGradient3;

  Pallate({
    this.selectedBackGrounfGradient1 = const Color(0xFF0D1441),
    this.selectedBackGrounfGradient2 = const Color(0xFF283584),
    this.selectedBackGrounfGradient3 = const Color(0xFF376AB2),
  });

  static Color backGrounfGradient2 = const Color(0xFF283584);
  static const Color buttonBgColor = Color(0xff4759C5);
  static const Color lightPurpleColor = Color(0xff899AFF);
  static const Color textFadeColor = Color.fromARGB(127, 255, 255, 255);
  static const Color whiteColor = Colors.white;
  static const Color transparentColor = Colors.transparent;
  static const Color textFillColor = Color.fromARGB(47, 180, 177, 189);

  Pallate copyWith({
    required Color selectedBackGrounfGradient1,
    required Color selectedBackGrounfGradient2,
    required Color selectedBackGrounfGradient3,
  }) {
    return Pallate(
        selectedBackGrounfGradient1: selectedBackGrounfGradient1,
        selectedBackGrounfGradient2: selectedBackGrounfGradient2,
        selectedBackGrounfGradient3: selectedBackGrounfGradient3);
  }
}
