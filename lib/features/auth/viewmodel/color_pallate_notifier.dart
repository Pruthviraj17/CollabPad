import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_pallate_notifier.g.dart';

@Riverpod(keepAlive: true)
class ColorPallateNotifier extends _$ColorPallateNotifier {
  @override
  Pallate? build() {
    return null;
  }

  void init() {
    state = Pallate();
  }

  void changeBgColors(Color color) {
    state = state!.copyWith(
      selectedBackGrounfGradient1: color,
      selectedBackGrounfGradient2: lightenColor(color, 0.38),
      selectedBackGrounfGradient3: lightenColor(color, 0.5),
    );
  }

  Color lightenColor(Color color, double percentage) {
    assert(percentage >= 0 && percentage <= 1,
        'Percentage must be between 0 and 1');
    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + percentage).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
