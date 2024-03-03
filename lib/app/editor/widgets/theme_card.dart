import 'package:coded_shots/app/editor/notifiers/editor_state_notifier.dart';
import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:coded_shots/utils/highlighter.dart';
import 'package:coded_shots/utils/parser.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ThemeCard extends ConsumerStatefulWidget {
  final ThemePreset themePreset;
  final int index;
  const ThemeCard({
    super.key,
    required this.themePreset,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemeCardState();
}

class _ThemeCardState extends ConsumerState<ThemeCard> {
  String? codeText;
  int _hoveredIndex = -1;

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

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return AnimatedContainer(
      duration: 200.ms,
      height: 180,
      width: 400,
      // padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(
          width: widget.themePreset == editorState.themePreset ? 1 : 0,
          color: widget.themePreset == editorState.themePreset
              ? neutralWhite
              : Colors.transparent,
        ),
        color: editorState.visible
            ? editorState.backgroundColor
            : Colors.transparent,
        gradient: editorState.backgroundGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: AnimatedContainer(
                duration: 200.ms,
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.themePreset.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style:
                          // GoogleFonts.firaCode(
                          // textStyle:
                          TextStyle(
                              fontSize: 10,
                              fontFamily: editorState.fontFamilyPreset.value,
                              fontWeight: editorState.fontWeightPreset.value),
                      // ),
                      children: <TextSpan>[
                        DartSyntaxHighlighter(widget.themePreset.style)
                            .format(codeText!)
                      ],
                    ),
                  ).fadeInFromTop(
                    delay: 0.ms,
                    animatiomDuration: 200.ms,
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: 200.ms,
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: editorState.themePreset == widget.themePreset ||
                      _hoveredIndex == widget.index
                  ? Colors.transparent
                  : neutralBlack.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    ).tap(
      onTap: () {
        editorStateNotifier.changeThemePreset(
          newThemePreset: widget.themePreset,
        );
      },
      onHover: (isHovered) {
        setState(() {
          _hoveredIndex = isHovered ? widget.index : -1;
        });
      },
    );
  }
}
