import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_apk/core/theme/theme.dart';
import 'package:vpn_apk/features/auth/view/pages/flash_screen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // final container = ProviderContainer();
  // await container.read(authViewmodelProvider.notifier).init();
  // await container.read(authViewmodelProvider.notifier).getData();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //       apiKey: dotenv.get("API_KEY"),
  //       appId: dotenv.get("APP_ID"),
  //       messagingSenderId: dotenv.get("MESSAGING_SENDER_ID"),
  //       projectId: dotenv.get("PROJECT_ID"),
  //     ),
  //   );
  // } else {
  //   Firebase.initializeApp();
  // }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CollabPad',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        home: const FlashScreenPage());
  }
}
