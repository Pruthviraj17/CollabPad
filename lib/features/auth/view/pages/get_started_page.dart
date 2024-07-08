import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/core/utils/screen_size.dart';
import 'package:vpn_apk/core/view/animations/page_navigation_animation.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/view/widgets/bg_gradient.dart';
import 'package:vpn_apk/features/auth/view/pages/auth_page.dart';
import 'package:vpn_apk/core/view/widgets/frosted_glass_widget.dart';
import 'package:vpn_apk/features/auth/view/widgets/get_started_widget.dart';
import 'package:vpn_apk/features/auth/view/widgets/join_room_widget.dart';
import 'package:vpn_apk/features/auth/view/widgets/create_room_widget.dart';
import 'package:vpn_apk/features/auth/viewmodel/watch_auth_screen.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradientWidget(
        child: Row(
          children: [
            Center(
              child: Hero(
                tag: "collab_animation",
                child: Lottie.asset(
                  "assets/animations/collab_animation.json",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      const CustomTextWidget(
                        text: "Get Started !",
                        fontSize: FontSize.large,
                        fontWeight: FontWeights.hardBoldWeight,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageNavigationAnimation(
                              page: const AuthPage(),
                            ),
                          );
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeights.thinWeight,
                              fontSize: FontSize.semiMedium,
                              color: Pallate.whiteColor,
                            ),
                            children: [
                              TextSpan(
                                  text: "Fill the Details or skip for now. "),
                              TextSpan(
                                text: "Skip?",
                                style: TextStyle(
                                  color: Pallate.lightPurpleColor,
                                  fontWeight: FontWeights.semiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                FrostedGlassWidget(
                  width: ScreenSize.width(context) * 0.5,
                  height: ScreenSize.height(context) * 0.6,
                  child: const GetStartedWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
