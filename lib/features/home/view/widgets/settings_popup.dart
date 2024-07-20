import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/providers/room_model_notifier.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/core/view/animations/page_navigation_animation.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/features/auth/view/pages/auth_page.dart';
import 'package:vpn_apk/features/home/utils/show_room_details.dart';

class SettingsPopup extends ConsumerWidget {
  const SettingsPopup( {super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomModel=ref.watch(roomModelNotifierProvider);
    Widget settingsTile({
      required IconData iconData,
      required String title,
      required VoidCallback onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: Pallate.whiteColor,
            ),
            const SizedBox(
              width: 11,
            ),
            CustomTextWidget(
              text: title,
              textOverflow: TextOverflow.ellipsis,
              fontSize: FontSize.semiMedium,
            ),
          ],
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(31, 255, 255, 255),
            Color.fromARGB(47, 0, 0, 0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingsTile(
              iconData: Icons.other_houses_outlined,
              title: "Room Details",
              onTap: () {
                showRoomDetails(context, roomModel!);
              },
            ),
            const SizedBox(
              width: 150,
              child: Divider(
                color: Pallate.textFadeColor,
                thickness: 0.5,
              ),
            ),
            settingsTile(
              iconData: Icons.logout_rounded,
              title: "Log Out",
              onTap: () {
                // ref.read(authRemoteRepositoryProvider).closeSocketConnection();
                Navigator.of(context).pushReplacement(
                  PageNavigationAnimation(
                    page: const AuthPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
