import 'package:collabpad/core/constants/text_styles.dart';
import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/core/view/components/custom_text_widget.dart';
import 'package:collabpad/core/view/widgets/frosted_glass_widget.dart';
import 'package:collabpad/features/auth/view/widgets/auth_button.dart';
import 'package:collabpad/features/auth/viewmodel/color_pallate_notifier.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showCustomColorPicker(
    {required BuildContext context, required WidgetRef ref}) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Pallate.transparentColor,
          content: FrostedGlassWidget(
            width: 800,
            height: 600,
            child: Column(
              children: [
                ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.wheel: true,
                  },
                  onColorChanged: (Color color) {
                    ref
                        .read(colorPallateNotifierProvider.notifier)
                        .changeBgColors(color);
                  },
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    children: [
                      AuthButton(
                        onPressed: () {
                          // update the color property in local
                          Navigator.of(context).pop();
                        },
                        child: const CustomTextWidget(
                          text: "SET THEME",
                          color: Pallate.whiteColor,
                          fontWeight: FontWeights.hardBoldWeight,
                          fontSize: FontSize.semiMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const CustomTextWidget(
                          text: "Cancel!",
                          fontWeight: FontWeights.thinWeight,
                          fontSize: FontSize.semiMedium,
                          color: Pallate.textFadeColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const CustomTextWidget(
                          text: "Reset?",
                          fontWeight: FontWeights.thinWeight,
                          fontSize: FontSize.semiMedium,
                          color: Pallate.textFadeColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
