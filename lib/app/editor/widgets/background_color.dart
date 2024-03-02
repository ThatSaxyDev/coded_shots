import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/color_palette.dart';
import 'package:coded_shots/app/editor/widgets/pop_up.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BackgroundColor extends ConsumerStatefulWidget {
  const BackgroundColor({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BackgroundColorState();
}

class _BackgroundColorState extends ConsumerState<BackgroundColor> {
  bool showModal = false;
  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);
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
            color: b100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: PopUpOverlay(
            visible: showModal,
            modal: ColorPalette(
              close: () {
                setState(() => showModal = false);
              },
            ),
            onClose: () => setState(() => showModal = false),
            child: Center(
              child: Container(
                width: 145,
                height: 25,
                decoration: BoxDecoration(
                  gradient: editorState.backgroundGradient,
                  color: editorState.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ).tap(onTap: () {
                setState(() => showModal = true);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
