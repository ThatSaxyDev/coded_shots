import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:coded_shots/utils/highlighter.dart';
import 'package:coded_shots/utils/parser.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! header
              editorState.psButtonStyle == PseudoButtonStyle.none
                  ? const Gap(20)
                  : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        height: 40,
                        width: 500,
                        child: SeparatedRow(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          separatorBuilder: () => const Gap(7),
                          children: List.generate(
                            3,
                            (index) => switch (editorState.psButtonStyle) {
                              PseudoButtonStyle.mac => CircleAvatar(
                                  radius: 7,
                                  backgroundColor: switch (index) {
                                    0 => const Color.fromRGBO(254, 98, 88, 1),
                                    1 => const Color.fromRGBO(251, 186, 64, 1),
                                    _ => const Color.fromRGBO(35, 194, 75, 1),
                                  },
                                ),
                              PseudoButtonStyle.win => switch (index) {
                                  0 => const Icon(
                                      PhosphorIconsBold.x,
                                      size: 14,
                                    ),
                                  1 => const Icon(
                                      PhosphorIconsBold.square,
                                      size: 14,
                                    ),
                                  _ => const Icon(
                                      PhosphorIconsBold.minus,
                                      size: 14,
                                    ),
                                },
                              PseudoButtonStyle.none => const SizedBox.shrink(),
                            },
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
                          style:
                              // GoogleFonts.firaCode(
                              // textStyle:
                              TextStyle(
                                  fontSize: 19,
                                  fontWeight:
                                      editorState.fontWeightPreset.value),
                          // ),
                          children: <TextSpan>[
                            DartSyntaxHighlighter(style).format(_exampleCode!)
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          if (editorState.waterMark)
            Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                children: [
                  const Icon(
                    PhosphorIconsBold.penNib,
                    size: 18,
                    color: grey400,
                  ),
                  const Gap(2),
                  'CodedShots'.txt(
                      size: 16, fontWeight: FontWeight.w700, color: grey400),
                ],
              ).fadeInFromBottom(
                delay: 0.ms,
                animatiomDuration: 300.ms,
              ),
            ),
        ],
      ),
    );
  }
}
