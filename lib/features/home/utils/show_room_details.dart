import 'package:collabpad/core/constants/text_styles.dart';
import 'package:collabpad/core/models/room_model.dart';
import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/core/view/components/custom_text_widget.dart';
import 'package:collabpad/core/view/widgets/frosted_glass_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showRoomDetails(BuildContext context, RoomModel roomModel) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Pallate.transparentColor,
          content: FrostedGlassWidget(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidget(
                        text: "Room Details",
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: FontSize.large,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  roomDetailsTile(
                    title: "Room Name",
                    desc: roomModel.roomName!,
                    iconData: Icons.label_important_rounded,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  roomDetailsTile(
                    title: "Room Id",
                    desc: roomModel.roomId!,
                    iconData: Icons.numbers_rounded,
                    trailingWidget: IconButton(
                      onPressed: () =>
                          _copyTextToClipboard(context, roomModel.roomId!),
                      icon: const Icon(
                        Icons.copy_rounded,
                        color: Pallate.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  roomDetailsTile(
                    title: "Room Password",
                    desc: roomModel.password!,
                    iconData: Icons.lock_outline_rounded,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void _copyTextToClipboard(BuildContext context, String textToCopy) {
  Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text copied to clipboard!'),
      ),
    );
  });
}

Widget roomDetailsTile({
  required String title,
  required String desc,
  required IconData iconData,
  Widget? trailingWidget,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        iconData,
        color: Pallate.whiteColor,
      ),
      const SizedBox(
        width: 21,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: title,
            textOverflow: TextOverflow.ellipsis,
            fontSize: FontSize.medium,
          ),
          CustomTextWidget(
            text: desc,
            textOverflow: TextOverflow.ellipsis,
            fontSize: FontSize.semiMedium,
          ),
        ],
      ),
      const Spacer(),
      if (trailingWidget != null) trailingWidget
    ],
  );
}
