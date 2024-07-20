import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/providers/room_model_notifier.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';

class RoomMembersList extends ConsumerWidget {
  const RoomMembersList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomModel = ref.watch(roomModelNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          CustomTextWidget(
            text: roomModel!.roomName.toUpperCase(),
            color: Pallate.lightPurpleColor,
            fontSize: FontSize.semiLarge,
            fontFamily: "Montserrat Bold",
            fontWeight: FontWeights.hardBoldWeight,
          ),
          const SizedBox(
            height: 30,
          ),
          const CustomTextWidget(
            text: "ROOM MEMBERS",
            color: Pallate.whiteColor,
            fontSize: FontSize.medium,
            fontFamily: "Montserrat Bold",
            fontWeight: FontWeights.boldWeight,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: roomModel.activeUsers.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final roomUser = roomModel.activeUsers[index];
                return Tooltip(
                  message: "${roomUser.username}: ${roomUser.id}",
                  child: Container(
                    height: 60,
                    width: 50,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Pallate.textFillColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: CustomTextWidget(
                              text: "${roomUser.username}: ${roomUser.id}",
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: FontSize.semiMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            color: Pallate.textFadeColor,
            thickness: 0.5,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextWidget(
            text: "Total Room Member: ${roomModel.activeUsers.length}",
            color: Pallate.textFadeColor,
            fontSize: FontSize.semiMedium,
          ),
        ],
      ),
    );
  }
}
