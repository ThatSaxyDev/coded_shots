import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/utils/highlighter.dart';
import 'package:coded_shots/utils/parser.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeView extends ConsumerStatefulWidget {
  const CodeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CodeViewState();
}

class _CodeViewState extends ConsumerState<CodeView> {
  String? _exampleCode;

  @override
  void didChangeDependencies() {
    try {
      getExampleCode('pro', DefaultAssetBundle.of(context))
          .then<void>((String code) {
        if (mounted) {
          setState(() {
            _exampleCode = code;
          });
        }
      });
    } catch (e) {
      "Error laoding assets $e".log();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();

    if (_exampleCode == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return AnimatedContainer(
      duration: 300.ms,
      // height: double.infinity,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: switch (editorState.shadow) {
          ShadowPreset.none => [],
          _ => [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: editorState.shadow.value,
                blurRadius: editorState.shadow.value,
                offset: const Offset(0, 3),
              ),
            ],
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! header
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 40,
              width: 500,
              child: SeparatedRow(
                mainAxisAlignment: MainAxisAlignment.start,
                separatorBuilder: () => const Gap(7),
                children: List.generate(
                  3,
                  (index) => CircleAvatar(
                    radius: 7,
                    backgroundColor: switch (index) {
                      0 => Colors.red,
                      1 => Colors.yellow,
                      _ => Colors.green,
                    },
                  ),
                ),
              ),
            ).alignCenterLeft(),
          ),

          _exampleCode == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(top: 15, bottom: 30),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: GoogleFonts.firaCode(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      children: <TextSpan>[
                        DartSyntaxHighlighter(style).format(_exampleCode!)
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
