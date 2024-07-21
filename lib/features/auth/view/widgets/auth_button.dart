import 'package:flutter/material.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    this.onPressed,
    required this.child,
    this.padding,
  });
  final VoidCallback? onPressed;
  final Widget child;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        width: 200,
        padding: padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Pallate.buttonBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: child),
      ),
    );
  }
}
