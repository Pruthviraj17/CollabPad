import 'package:collabpad/core/models/user_model.dart';
import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/core/view/widgets/frosted_glass_widget.dart';
import 'package:collabpad/features/auth/view/widgets/get_started_widget.dart';
import 'package:flutter/material.dart';

Future<void> showUserDetails(BuildContext context, UserModel? userModel) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Pallate.transparentColor,
          content: FrostedGlassWidget(
            width: 800,
            child: GetStartedWidget(
              onUpdatePopScreen: true,
            ),
          ),
        );
      });
}
