import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/shared/widgets/custom_flex.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class VisibilitySelector extends ConsumerWidget {
  const VisibilitySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: 'Visible'.txt(size: 12, color: grey400),
        ),
        Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            color: b100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: AnimatedAlign(
                  alignment: switch (editorState.visible) {
                    true => Alignment.centerLeft,
                    false => Alignment.centerRight,
                  },
                  duration: 300.ms,
                  child: Container(
                    width: 75,
                    height: 30,
                    decoration: BoxDecoration(
                      color: neutralWhite.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Center(
                child: CustomizableRow(
                  flexValues: const [1, 1],
                  children: [
                    Center(child: 'Yes'.txt()).tap(
                      onTap: () {
                        editorStateNotifier.toggleVisibility();
                      },
                    ),
                    Center(child: 'No'.txt()).tap(
                      onTap: () {
                        editorStateNotifier.toggleVisibility();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
