import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_apk/core/models/user_model.dart';
import 'package:vpn_apk/core/providers/user_model_notifier.dart';
import 'package:vpn_apk/core/utils/image_utils.dart';
import 'package:vpn_apk/core/utils/show_custom_snackbar.dart';
import 'package:vpn_apk/core/view/animations/page_navigation_animation.dart';
import 'package:vpn_apk/features/auth/view/pages/auth_page.dart';
import 'package:vpn_apk/features/auth/view/widgets/auth_button.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/view/components/custom_text_form_field.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/features/auth/viewmodel/auth_viewmodel.dart';

class GetStartedWidget extends StatefulWidget {
  const GetStartedWidget({super.key});

  @override
  State<GetStartedWidget> createState() => _GetStartedWidgetState();
}

class _GetStartedWidgetState extends State<GetStartedWidget> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  Uint8List? _imageBytes;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _continue(
    WidgetRef ref,
  ) async {
    String? selectedImage = await ImageUtils.encodeImage(_imageBytes);

    UserModel userModel = UserModel(
      username: _userNameController.text,
      email: _userEmailController.text,
      image: selectedImage,
    );

    await ref.read(authViewmodelProvider.notifier).init();
    bool success =
        ref.read(authViewmodelProvider.notifier).setUser(userInfo: userModel);
    if (success) {
      ref.read(userModelNotifierProvider.notifier).addUser(userModel);
      Navigator.of(context).pushReplacement(
        PageNavigationAnimation(
          page: const AuthPage(),
        ),
      );
    } else {
      showSnackBar(context: context, content: "Something went wrong");
    }
  }

  Future<Uint8List?> pickImageWeb() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        return result.files.first.bytes;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                Uint8List? pickedBytes = await pickImageWeb();
                setState(() {
                  if (pickedBytes != null) {
                    _imageBytes = pickedBytes;
                  }
                });
              },
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Pallate.textFillColor,
                backgroundImage:
                    _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                child: _imageBytes != null
                    ? null
                    : const Icon(
                        Icons.photo_rounded,
                        color: Pallate.textFadeColor,
                        size: 50,
                      ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const CustomTextWidget(
              text: "Profile Photo",
              color: Pallate.textFadeColor,
              fontSize: FontSize.semiMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              textEditingController: _userNameController,
              hintText: "User Name",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              textEditingController: _userEmailController,
              hintText: "Email",
            ),
            const SizedBox(
              height: 40,
            ),
            Consumer(
              builder: (context, ref, child) {
                return AuthButton(
                  onPressed: () => _continue(ref),
                  child: const CustomTextWidget(
                    text: "CONTINUE",
                    color: Pallate.whiteColor,
                    fontWeight: FontWeights.hardBoldWeight,
                    fontSize: FontSize.semiMedium,
                  ),
                );
              },
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
