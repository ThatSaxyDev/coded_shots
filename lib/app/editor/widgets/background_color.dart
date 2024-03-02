import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/shared/widgets/custom_flex.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BackgroundColor extends ConsumerWidget {
  const BackgroundColor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: 'Color'.txt(size: 12, color: grey400),
        ),
        Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            color: b200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Container(
              width: 145,
              height: 25,
              decoration: BoxDecoration(
                color: editorState.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ).tap(onTap: () {
              editorStateNotifier.changeColorRandom();
            }),
          ),
        ),
      ],
    );
  }
}
