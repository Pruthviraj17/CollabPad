import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 25,
      height: 25,
      child: CircularProgressIndicator(
        color: Pallate.whiteColor,
      ),
    );
  }
}
