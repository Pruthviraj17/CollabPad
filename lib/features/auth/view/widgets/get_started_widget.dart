import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_apk/core/utils/screen_size.dart';
import 'package:vpn_apk/core/view/animations/page_navigation_animation.dart';
import 'package:vpn_apk/features/auth/view/pages/auth_page.dart';
import 'package:vpn_apk/features/auth/view/widgets/auth_button.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/core/view/components/custom_text_form_field.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:flutter/material.dart';
import 'package:vpn_apk/features/auth/viewmodel/watch_auth_screen.dart';

class GetStartedWidget extends StatefulWidget {
  const GetStartedWidget({super.key});

  @override
  State<GetStartedWidget> createState() => _GetStartedWidgetState();
}

class _GetStartedWidgetState extends State<GetStartedWidget> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // open image picker
              },
              child: const CircleAvatar(
                radius: 80,
                backgroundColor: Pallate.textFillColor,
                child: Icon(
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
            AuthButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  PageNavigationAnimation(
                    page: const AuthPage(),
                  ),
                );
              },
              child: const CustomTextWidget(
                text: "CONTINUE",
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
