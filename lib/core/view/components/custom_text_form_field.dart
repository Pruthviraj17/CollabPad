import 'package:flutter/material.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.prefixWidget});
  final TextEditingController textEditingController;
  final String hintText;
  final Widget? prefixWidget;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: prefixWidget,
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeights.thinWeight,
        ),
      ),
    );
  }
}
