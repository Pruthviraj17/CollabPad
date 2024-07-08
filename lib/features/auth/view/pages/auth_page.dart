import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/core/utils/screen_size.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/view/widgets/bg_gradient.dart';
import 'package:vpn_apk/core/view/widgets/frosted_glass_widget.dart';
import 'package:vpn_apk/features/auth/view/widgets/join_room_widget.dart';
import 'package:vpn_apk/features/auth/view/widgets/create_room_widget.dart';
import 'package:vpn_apk/features/auth/viewmodel/watch_auth_screen.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isJoinRoom = ref.watch(isJoinRoomProvider);

    return Scaffold(
      body: BgGradientWidget(
        child: Row(
          children: [
            Center(
              child: Flexible(
                fit: FlexFit.tight,
                child: Hero(
                  tag: "collab_animation",
                  child: Lottie.asset(
                    "assets/animations/collab_animation.json",
                    fit: BoxFit.cover,
                  ),
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
                      CustomTextWidget(
                        text: !isJoinRoom ? "Create Room" : "Join Room",
                        fontSize: FontSize.large,
                        fontWeight: FontWeights.hardBoldWeight,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(isJoinRoomProvider.notifier).state =
                              !(ref.read(isJoinRoomProvider.notifier).state);
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontWeight: FontWeights.thinWeight,
                              fontSize: FontSize.semiMedium,
                              color: Pallate.whiteColor,
                            ),
                            children: [
                              TextSpan(
                                  text: isJoinRoom
                                      ? "Create a new room? "
                                      : "Already created room? "),
                              TextSpan(
                                text:
                                    isJoinRoom ? "Create Room!" : "Join Room!",
                                style: const TextStyle(
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
                  child: isJoinRoom
                      ? const JoinRoomWidget()
                      : const CreateRoomWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
