import 'package:collabpad/core/constants/text_styles.dart';
import 'package:collabpad/core/providers/user_model_notifier.dart';
import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/core/utils/screen_size.dart';
import 'package:collabpad/core/view/components/custom_text_widget.dart';
import 'package:collabpad/core/view/widgets/bg_gradient.dart';
import 'package:collabpad/core/view/widgets/frosted_glass_widget.dart';
import 'package:collabpad/features/auth/utils/show_color_picker_dialogue.dart';
import 'package:collabpad/features/auth/view/widgets/create_room_widget.dart';
import 'package:collabpad/features/auth/view/widgets/join_room_widget.dart';
import 'package:collabpad/features/auth/viewmodel/watch_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isJoinRoom = ref.watch(isJoinRoomProvider);
    final userModel = ref.watch(userModelNotifierProvider);

    return Scaffold(
      body: BgGradientWidget(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "collab_animation",
                      child: Lottie.asset(
                        "assets/animations/collab_animation.json",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextWidget(
                            text: " ${userModel != null ? "Hello" : ""} ",
                            fontSize: FontSize.large,
                            color: Pallate.lightPurpleColor,
                            fontWeight: FontWeights.hardBoldWeight,
                            fontFamily: "Montserrat Bold",
                          ),
                          CustomTextWidget(
                            text:
                                "${userModel != null ? userModel.username : "Welcome to CollabPAD"} !",
                            fontSize: FontSize.semiLarge,
                            color: Pallate.whiteColor,
                            fontWeight: FontWeights.hardBoldWeight,
                            fontFamily: "Montserrat Bold",
                          ),
                        ],
                      ),
                    ),
                  ],
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
                        InkWell(
                          onTap: () {
                            ref.read(isJoinRoomProvider.notifier).state =
                                !(ref.read(isJoinRoomProvider.notifier).state);
                          },
                          splashColor: Pallate.transparentColor,
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
                                  text: isJoinRoom
                                      ? "Create Room!"
                                      : "Join Room!",
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: TextButton(
                      onPressed: () =>
                          showCustomColorPicker(context: context, ref: ref),
                      child: const CustomTextWidget(
                        text: "Change Theme Color ?",
                        fontWeight: FontWeights.thinWeight,
                        fontSize: FontSize.semiMedium,
                        color: Pallate.textFadeColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
