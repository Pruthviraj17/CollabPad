import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vpn_apk/core/models/room_model.dart';
import 'package:vpn_apk/core/providers/room_model_notifier.dart';
import 'package:vpn_apk/core/utils/show_custom_snackbar.dart';
import 'package:vpn_apk/core/view/animations/page_navigation_animation.dart';
import 'package:vpn_apk/features/auth/repositories/auth_remote_repository.dart';
import 'package:vpn_apk/features/auth/view/widgets/auth_button.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/view/components/custom_text_form_field.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/features/home/view/pages/dashboard_page.dart';

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

  Future<void> createRoom() async {
    final res = await ref.read(authRemoteRepositoryProvider).createRoom(
          roomName: _roomNameController.text,
          password: _roomPassController.text,
        );
    if (mounted) {
      final val = switch (res) {
        Left(value: final l) => _showMessage(context, l.message),
        Right(value: final r) => _navigateToDashboard(r),
      };
    }
  }

  void _navigateToDashboard(RoomModel roomModel) {
    ref.read(roomModelNotifierProvider.notifier).addRoom(roomModel);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageNavigationAnimation(
          page: const DashboardPage(),
        ),
      );
    }
  }

  void _showMessage(BuildContext context, String message) {
    if (mounted) {
      showSnackBar(context: context, content: message);
    }
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
              onPressed: createRoom,
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
