import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/shared/widgets/custom_flex.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class RadiusSelector extends ConsumerWidget {
  const RadiusSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: 'Radius'.txt(size: 12, color: grey400),
        ),
        Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            color: b200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: AnimatedAlign(
                  alignment: switch (editorState.radius) {
                    0 => Alignment.centerLeft,
                    8 => const Alignment(-0.35, 0),
                    16 => const Alignment(0.35, 0),
                    24 => Alignment.centerRight,
                    _ => Alignment.centerLeft,
                  },
                  duration: 300.ms,
                  child: Container(
                    width: 30,
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
                  flexValues: const [1, 1, 1, 1],
                  children: List.generate(
                    radiuses.length,
                    (index) =>
                        Center(child: radiuses[index].toStringAsFixed(0).txt())
                            .tap(
                      onTap: () {
                        editorStateNotifier.changeRadius(
                          newRadius: radiuses[index],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
