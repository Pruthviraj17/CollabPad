import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/providers/room_model_notifier.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:vpn_apk/features/auth/repositories/auth_remote_repository.dart';

class EditPad extends ConsumerStatefulWidget {
  const EditPad({
    super.key,
  });

  @override
  ConsumerState<EditPad> createState() => _EditPadState();
}

final _codeFieldController = CodeController();

class _EditPadState extends ConsumerState<EditPad> {
  @override
  void initState() {
    _codeFieldController.popupController.enabled = false;
    ref.read(authRemoteRepositoryProvider).onCodeChange();
    ref.read(authRemoteRepositoryProvider).onCodeChangeStream.listen(
      (code) {
        // ref.read(codeStateProvider.notifier).state = code;
        _codeFieldController.text = code;
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _codeFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final code = ref.watch(codeStateProvider);
    // _codeFieldController.text = code;
    final roomModel = ref.watch(roomModelNotifierProvider);

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 80),
        child: CodeTheme(
          data: CodeThemeData(
            styles: monokaiSublimeTheme,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              return SingleChildScrollView(
                child: CodeField(
                  controller: _codeFieldController,
                  onChanged: (codeChange) async {
                    ref.read(authRemoteRepositoryProvider).emitCodeChange(
                          roomId: roomModel!.roomId!,
                          code: codeChange,
                        );
                  },
                  maxLines: null,
                  textSelectionTheme: const TextSelectionThemeData(
                    selectionColor: Pallate.textFadeColor,
                  ),
                  filledColor: Pallate.transparentColor,
                  filled: true,
                  background: Pallate.transparentColor,
                  cursorColor: Pallate.textFadeColor,
                  textStyle: const TextStyle(
                    fontSize: FontSize.semiMedium,
                    color: Pallate.whiteColor,
                    fontWeight: FontWeights.thinWeight,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
