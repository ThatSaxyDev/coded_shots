import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/pop_up.dart';
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
      getExampleCode('enum_preset', DefaultAssetBundle.of(context))
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
    final SyntaxHighlighterStyle style =
        SyntaxHighlighterStyle.lightThemeStyle();
    // final SyntaxHighlighterStyle style =
    //     Theme.of(context).brightness == Brightness.dark
    //         ? SyntaxHighlighterStyle.darkThemeStyle()
    //         : SyntaxHighlighterStyle.lightThemeStyle();

    if (codeText == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return PopUpOverlay(
      visible: showModal,
      follower: Alignment.topCenter,
      target: Alignment.bottomCenter,
      modal: Material(
        elevation: 8,
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          // height: 400,
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: b100,
            border: Border.all(width: 1, color: grey600),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: onHover ? b200 : Colors.transparent,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  PhosphorIconsBold.penNib,
                  size: 18,
                  color: grey400,
                ),
                const Gap(2),
                'Paste'.txt(size: 16),
              ],
            ),
          ).tap(
            onTap: () {
              setState(() => showModal = false);
              setCodeText();
            },
            onHover: (isHovered) {
              setState(() {
                onHover = isHovered;
              });
            },
          ),
        ),
      ),
      onClose: () {
        setState(() => showModal = false);
      },
      child: AnimatedContainer(
        duration: 300.ms,
        // height: double.infinity,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: grey100,
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
                                      1 =>
                                        const Color.fromRGBO(251, 186, 64, 1),
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
                                PseudoButtonStyle.none =>
                                  const SizedBox.shrink(),
                              },
                            ),
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
                                    fontWeight:
                                        editorState.fontWeightPreset.value),
                            // ),
                            children: <TextSpan>[
                              DartSyntaxHighlighter(style).format(codeText!)
                            ],
                          ),
                        ).fadeInFromTop(
                          delay: 0.ms,
                          animatiomDuration: 200.ms,
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
                  animatiomDuration: 200.ms,
                ),
              ),
          ],
        ),
      ).tap(
        onTap: () {
          // setState(() => showModal = false);
        },
        onHover: (isHovered) {
          setState(() {
            showModal = true;
          });
        },
      ),
    );
  }
}
