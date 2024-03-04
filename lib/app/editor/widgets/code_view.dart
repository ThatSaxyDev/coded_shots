import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:coded_shots/utils/highlighter.dart';
import 'package:coded_shots/utils/my_clipboard.dart';
import 'package:coded_shots/utils/parser.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CodeView extends ConsumerStatefulWidget {
  const CodeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CodeViewState();
}

class _CodeViewState extends ConsumerState<CodeView> {
  String? codeText;
  bool showModal = false;
  bool onModalHover = false;
  bool onHover = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      getExampleCode('pro', DefaultAssetBundle.of(context))
          .then<void>((String code) {
        if (mounted) {
          setState(() {
            codeText = code;
          });
        }
      });
    } catch (e) {
      "Error loading assets $e".log();
    }
  }

  void setCodeText() {
    MyClipboard.paste().then((value) {
      setState(() {
        codeText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);

    if (codeText == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return AnimatedContainer(
      duration: 300.ms,
      // height: double.infinity,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: editorState.themePreset.color,
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
                        child: Row(
                          children: [
                            SeparatedRow(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              separatorBuilder: () => const Gap(7),
                              children: List.generate(
                                3,
                                (index) => switch (editorState.psButtonStyle) {
                                  PseudoButtonStyle.mac => CircleAvatar(
                                      radius: 7,
                                      backgroundColor: switch (index) {
                                        0 =>
                                          const Color.fromRGBO(254, 98, 88, 1),
                                        1 =>
                                          const Color.fromRGBO(251, 186, 64, 1),
                                        _ =>
                                          const Color.fromRGBO(35, 194, 75, 1),
                                      },
                                    ),
                                  PseudoButtonStyle.win => switch (index) {
                                      0 => Icon(
                                          PhosphorIconsBold.x,
                                          size: 14,
                                          color: editorState
                                              .themePreset.buttonColor,
                                        ),
                                      1 => Icon(
                                          PhosphorIconsBold.square,
                                          size: 14,
                                          color: editorState
                                              .themePreset.buttonColor,
                                        ),
                                      _ => Icon(
                                          PhosphorIconsBold.minus,
                                          size: 14,
                                          color: editorState
                                              .themePreset.buttonColor,
                                        ),
                                    },
                                  PseudoButtonStyle.none =>
                                    const SizedBox.shrink(),
                                },
                              ),
                            ),
                          ],
                        ),
                      ).alignCenterLeft(),
                    ),

              codeText == null
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30)
                          .copyWith(top: 15, bottom: 40),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style:
                              // GoogleFonts.firaCode(
                              // textStyle:
                              TextStyle(
                                  fontSize: 19,
                                  fontFamily:
                                      editorState.fontFamilyPreset.value,
                                  fontWeight:
                                      editorState.fontWeightPreset.value),
                          // ),
                          children: <TextSpan>[
                            DartSyntaxHighlighter(editorState.themePreset.style)
                                .format(codeText!)
                          ],
                        ),
                      ).fadeInFromTop(
                        delay: 0.ms,
                        animatiomDuration: 200.ms,
                      ),
                    ),
            ],
          ),
          if (onHover)
            Positioned(
                right: 4,
                top: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(
                    color: neutralBlack.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: 'Click to paste'.txt(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: neutralWhite,
                  ),
                ).tap(
                  onTap: () {
                    setCodeText();
                  },
                )).fadeInFromTop(
              delay: 0.ms,
              animatiomDuration: 100.ms,
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
                    size: 16,
                    fontWeight: FontWeight.w700,
                    color: grey400,
                  ),
                ],
              ).fadeInFromBottom(
                delay: 0.ms,
                animatiomDuration: 200.ms,
              ),
            ),
        ],
      ),
    ).tap(
      onTap: () {
        setCodeText();
      },
      onHover: (isHovered) {
        setState(() {
          onHover = isHovered;
        });
      },
    );
  }
}
