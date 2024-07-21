import 'package:collabpad/core/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.prefixWidget,
    this.isPassword = false,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final Widget? prefixWidget;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter ${hintText.toLowerCase()}";
        }
        if (isPassword) {
          if (value.length < 6) {
            return "Please enter ${hintText.toLowerCase()} at least 6 digit";
          }
        }
        return null;
      },
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
