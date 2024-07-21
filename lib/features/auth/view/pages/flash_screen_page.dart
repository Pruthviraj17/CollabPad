import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_apk/core/view/animations/page_navigation_animation.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/utils/screen_size.dart';
import 'package:vpn_apk/features/auth/view/pages/auth_page.dart';
import 'package:vpn_apk/core/view/widgets/bg_gradient.dart';
import 'package:vpn_apk/features/auth/view/pages/get_started_page.dart';

class FlashScreenPage extends StatefulWidget {
  const FlashScreenPage({super.key, required this.isGetStartedScreen});
  final bool isGetStartedScreen;

  @override
  State<FlashScreenPage> createState() => _FlashScreenPageState();
}

class _FlashScreenPageState extends State<FlashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageNavigationAnimation(
          page: widget.isGetStartedScreen
              ? const GetStartedPage()
              : const AuthPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradientWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomTextWidget(
                text: "Welcome to CollabPad",
                fontWeight: FontWeights.hardBoldWeight,
                fontSize: FontSize.large,
                fontFamily: "Montserrat Bold",
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenSize.width(context) * 0.05,
                  right: ScreenSize.width(context) * 0.05,
                  top: 11,
                ),
                child: const CustomTextWidget(
                  text:
                      "Start collaborating with your colleagues seamlessly and efficiently.\n Share ideas, work together in real-time, and achieve your goals.",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeights.thinWeight,
                  fontSize: FontSize.medium,
                ),
              ),
              Hero(
                tag: "collab_animation",
                child: Center(
                  child: Lottie.asset(
                    "assets/animations/collab_animation.json",
                    width: ScreenSize.width(context) * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
