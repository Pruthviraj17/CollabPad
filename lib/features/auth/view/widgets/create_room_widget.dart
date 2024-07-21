import 'package:collabpad/core/constants/text_styles.dart';
import 'package:collabpad/core/models/room_model.dart';
import 'package:collabpad/core/models/user_model.dart';
import 'package:collabpad/core/providers/room_model_notifier.dart';
import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/core/utils/show_custom_snackbar.dart';
import 'package:collabpad/core/view/animations/page_navigation_animation.dart';
import 'package:collabpad/core/view/components/custom_text_form_field.dart';
import 'package:collabpad/core/view/components/custom_text_widget.dart';
import 'package:collabpad/features/auth/repositories/auth_remote_repository.dart';
import 'package:collabpad/features/auth/view/widgets/auth_button.dart';
import 'package:collabpad/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:collabpad/features/home/view/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class CreateRoomWidget extends ConsumerStatefulWidget {
  const CreateRoomWidget({super.key});

  @override
  ConsumerState<CreateRoomWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends ConsumerState<CreateRoomWidget> {
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _roomPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    _roomPassController.dispose();
    super.dispose();
  }

  Future<void> createRoom() async {
    UserModel? userModel =
        await ref.read(authViewmodelProvider.notifier).getUser();
    final res = await ref.read(authRemoteRepositoryProvider).createRoom(
          roomName: _roomNameController.text,
          password: _roomPassController.text,
          userModel: userModel,
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
        child: Form(
          key: formKey,
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
                isPassword: true,
              ),
              const SizedBox(
                height: 40,
              ),
              AuthButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    createRoom();
                  }
                },
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
      ),
    );
  }
}
