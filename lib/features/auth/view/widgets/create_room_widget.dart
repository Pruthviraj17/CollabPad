import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_apk/core/utils/screen_size.dart';
import 'package:vpn_apk/features/auth/view/widgets/auth_button.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/view/components/custom_text_form_field.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:flutter/material.dart';
import 'package:vpn_apk/features/auth/viewmodel/watch_auth_screen.dart';

class CreateRoomWidget extends ConsumerStatefulWidget {
  const CreateRoomWidget({super.key});

  @override
  ConsumerState<CreateRoomWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends ConsumerState<CreateRoomWidget> {
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _roomPassController = TextEditingController();

  @override
  void dispose() {
    _roomNameController.dispose();
    _roomPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomTextWidget(
              text:
                  "After creating room you will get ID & Password, which you can share to your Team Mates/Colleagues to join.",
              color: Pallate.textFadeColor,
              fontSize: FontSize.medium,
              fontWeight: FontWeights.semiBold,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextFormField(
              textEditingController: _roomNameController,
              hintText: "Room Name",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              textEditingController: _roomPassController,
              hintText: "Room Password",
            ),
            const SizedBox(
              height: 40,
            ),
            AuthButton(
              onPressed: () async {},
              child: const CustomTextWidget(
                text: "CREATE ROOM",
                color: Pallate.whiteColor,
                fontWeight: FontWeights.hardBoldWeight,
                fontSize: FontSize.semiMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
