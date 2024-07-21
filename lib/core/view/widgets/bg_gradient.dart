import 'package:flutter/material.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';

class BgGradientWidget extends StatelessWidget {
  const BgGradientWidget({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Pallate.backGrounfGradient1,
            Pallate.backGrounfGradient2,
            Pallate.backGrounfGradient3,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: child,
    );
  }
}
