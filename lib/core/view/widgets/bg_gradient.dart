import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/features/auth/viewmodel/color_pallate_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BgGradientWidget extends ConsumerWidget {
  const BgGradientWidget({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Pallate? colorPallate = ref.watch(colorPallateNotifierProvider);
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorPallate!.selectedBackGrounfGradient1,
            colorPallate.selectedBackGrounfGradient2,
            colorPallate.selectedBackGrounfGradient3,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: child,
    );
  }
}
