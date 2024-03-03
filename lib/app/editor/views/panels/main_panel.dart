import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/code_view.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class MainPanel extends ConsumerWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    // final editorStateNotifier = ref.read(editorNotifierProvider.notifier);

    return Expanded(
      child: Container(
        // height: height(context),
        // width: 200,
        decoration: const BoxDecoration(color: b100),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AnimatedContainer(
              duration: 300.ms,
              // height: 400,
              // width: 400,
              padding: EdgeInsets.all(editorState.padding),
              margin: EdgeInsets.only(
                top: 50,
                bottom: 50,
                left: 270.rW(context) - 50,
              ),
              decoration: BoxDecoration(
                color: editorState.visible
                    ? editorState.backgroundColor
                    : Colors.transparent,
                gradient: editorState.backgroundGradient,
                borderRadius: BorderRadius.circular(editorState.radius),
              ),
              child: const Center(child: CodeView()),
            ),
          ),
        ),
      ),
    );
  }
}
