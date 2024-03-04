// ignore_for_file: use_build_context_synchronously

import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/views/panels/edit_panel.dart';
import 'package:coded_shots/app/editor/views/panels/main_panel.dart';
import 'package:coded_shots/shared/app_constants.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditorView extends ConsumerWidget {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: b100,
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Stack(
          children: [
            Row(
              children: [
                const EditPanel(),
                SizedBox(
                  width: 270.rW(context) - 50,
                ),
                const MainPanel(),

                //! style
                // Container(
                //   width: 270,
                //   height: height(context),
                //   decoration: const BoxDecoration(color: b200),
                // )
              ],
            ),
            Positioned(
              top: 30,
              right: 50,
              child: AnimatedContainer(
                duration: 200.ms,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: editorState.backgroundColor,
                  gradient: editorState.backgroundGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIconsBold.downloadSimple,
                      size: 18,
                      color: editorState.backgroundColor == neutralWhite
                          ? neutralBlack
                          : neutralWhite,
                    ),
                    const Gap(7),
                    'Export'.txt(
                      size: 16,
                      fontWeight: FontWeight.w500,
                      color: editorState.backgroundColor == neutralWhite
                          ? neutralBlack
                          : neutralWhite,
                    ),
                  ],
                ),
              ).tap(
                onTap: () async {
                  final bytess = await editorStateNotifier
                      .widgetToImageController
                      .capture();
                  // setState(() {
                  //   bytes = bytess;
                  // });
                  editorStateNotifier.exportImageByBytes(
                    exportBytes: bytess!,
                    context: context,
                  );
                },
              ),
            ),
            const Positioned(
              bottom: 10,
              right: 10,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Developed with 💙 by ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: neutralWhite),
                    ),
                    TextSpan(
                      text: 'Kiishi',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: neutralWhite),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
