import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class EditPad extends StatefulWidget {
  const EditPad({
    super.key,
  });

  @override
  State<EditPad> createState() => _EditPadState();
}

class _EditPadState extends State<EditPad> {
  final _codeFieldController = CodeController(
    text: "// Write here ",
    namedSectionParser: const BracketsStartEndNamedSectionParser(),
  );

  @override
  void dispose() {
    _codeFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 80),
        child: CodeTheme(
          data: CodeThemeData(
            styles: monokaiSublimeTheme,
          ),
          child: SingleChildScrollView(
            child: CodeField(
              controller: _codeFieldController,
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
          ),
        ),
      ),
    );
  }
}
