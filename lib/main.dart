import 'package:collabpad/core/models/user_model.dart';
import 'package:collabpad/core/providers/user_model_notifier.dart';
import 'package:collabpad/core/theme/theme.dart';
import 'package:collabpad/features/auth/view/pages/flash_screen_page.dart';
import 'package:collabpad/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:collabpad/features/auth/viewmodel/color_pallate_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).init();
  container.read(colorPallateNotifierProvider.notifier).init();
  Color? color =
      await container.read(authViewmodelProvider.notifier).getThemeColor();
  if (color != null) {
    container.read(colorPallateNotifierProvider.notifier).changeBgColors(color);
  }

  UserModel? userModel =
      await container.read(authViewmodelProvider.notifier).getUser();

  if (userModel != null) {
    container.read(userModelNotifierProvider.notifier).addUser(userModel);
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(
        userModel: userModel,
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
    this.userModel,
  });

  final UserModel? userModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userModel = ref.read(userModelNotifierProvider);
    return MaterialApp(
      title: 'CollabPad',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home:
          // GetStartedPage()
          FlashScreenPage(
        isGetStartedScreen: userModel == null,
      ),
    );
  }
}
