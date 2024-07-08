import 'package:flutter/material.dart';

void showCustomSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
        ),
      ),
    );
}
