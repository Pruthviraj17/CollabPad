import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/features/auth/viewmodel/auth_viewmodel.dart';
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

  Color getBaseColor() {
    return state!.selectedBackGrounfGradient1;
  }

  void resetBgColors() {
    state = state!.copyWith(
      selectedBackGrounfGradient1: const Color(0xFF0D1441),
      selectedBackGrounfGradient2: const Color(0xFF283584),
      selectedBackGrounfGradient3: const Color(0xFF376AB2),
    );
  }

  Future<bool> cancelBgColors() async {
    Color? color =
        await ref.read(authViewmodelProvider.notifier).getThemeColor();
    if (color != null) {
      changeBgColors(color);
      return true;
    }
    return false;
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
