import 'dart:typed_data';
import 'package:collabpad/core/constants/text_styles.dart';
import 'package:collabpad/core/models/user_model.dart';
import 'package:collabpad/core/providers/user_model_notifier.dart';
import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/core/utils/image_utils.dart';
import 'package:collabpad/core/utils/show_custom_snackbar.dart';
import 'package:collabpad/core/view/animations/page_navigation_animation.dart';
import 'package:collabpad/core/view/components/custom_text_form_field.dart';
import 'package:collabpad/core/view/components/custom_text_widget.dart';
import 'package:collabpad/features/auth/view/pages/auth_page.dart';
import 'package:collabpad/features/auth/view/widgets/auth_button.dart';
import 'package:collabpad/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetStartedWidget extends ConsumerStatefulWidget {
  const GetStartedWidget({
    super.key,
    this.onUpdatePopScreen,
  });
  final bool? onUpdatePopScreen;

  @override
  ConsumerState<GetStartedWidget> createState() => _GetStartedWidgetState();
}

class _GetStartedWidgetState extends ConsumerState<GetStartedWidget> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  Uint8List? _imageBytes;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _update(
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

      if (widget.onUpdatePopScreen != null && widget.onUpdatePopScreen!) {
        Navigator.of(context).pop();
        showSnackBar(context: context, content: "User Info Updated");
        return;
      }

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
    UserModel? userModel = ref.watch(userModelNotifierProvider);
    if (userModel != null) {
      _imageBytes = ImageUtils.decodeImage(userModel.image!);
      _userNameController.text = userModel.username!;
      _userEmailController.text = userModel.email!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                splashColor: Pallate.transparentColor,
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _update(ref);
                      }
                    },
                    child: const CustomTextWidget(
                      text: "UPDATE",
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
      ),
    );
  }
}
