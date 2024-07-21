import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vpn_apk/core/models/room_model.dart';
import 'package:vpn_apk/core/models/user_model.dart';
import 'package:vpn_apk/core/providers/room_model_notifier.dart';
import 'package:vpn_apk/core/utils/screen_size.dart';
import 'package:vpn_apk/core/utils/show_custom_snackbar.dart';
import 'package:vpn_apk/core/view/animations/page_navigation_animation.dart';
import 'package:vpn_apk/features/auth/repositories/auth_remote_repository.dart';
import 'package:vpn_apk/features/auth/view/widgets/auth_button.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/view/components/custom_text_form_field.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:vpn_apk/features/home/view/pages/dashboard_page.dart';

class JoinRoomWidget extends ConsumerStatefulWidget {
  const JoinRoomWidget({super.key});

  @override
  ConsumerState<JoinRoomWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends ConsumerState<JoinRoomWidget> {
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _roomPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    _roomPassController.dispose();
    super.dispose();
  }

  void joinRoom() async {
    UserModel? userModel =
        await ref.read(authViewmodelProvider.notifier).getUser();
    final res = await ref.read(authRemoteRepositoryProvider).joinRoom(
          roomId: _roomIdController.text,
          password: _roomPassController.text,
          userModel: userModel,
        );
    if (mounted) {
      final val = switch (res) {
        Left(value: final l) => _showMessage(context, l.message),
        Right(value: final r) => {
            if (r.success!)
              {
                _navigateToDashboard(r),
              }
            else
              {
                _showMessage(context, r.message!),
              }
          },
      };
    }
  }

  void _navigateToDashboard(RoomModel roomModel) {
    ref.read(codeStateProvider.notifier).state = roomModel.code ?? "";
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
                  "Joining room allows you to collaborate on room notepad. changes made are real time and seen instantly.",
              color: Pallate.textFadeColor,
              fontSize: FontSize.medium,
              fontWeight: FontWeights.semiBold,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextFormField(
              textEditingController: _roomIdController,
              hintText: "Room ID",
            ),
            SizedBox(
              height: ScreenSize.height(context) * 0.02,
            ),
            CustomTextFormField(
              textEditingController: _roomPassController,
              hintText: "Room Password",
            ),
            SizedBox(
              height: ScreenSize.height(context) * 0.05,
            ),
            AuthButton(
              onPressed: joinRoom,
              child: const CustomTextWidget(
                text: "JOIN ROOM",
                color: Pallate.whiteColor,
                fontWeight: FontWeights.hardBoldWeight,
                fontSize: FontSize.semiMedium,
              ),
            ),
            const SizedBox(
              height: 21,
            ),
          ],
        ),
      ),
    );
  }
}
