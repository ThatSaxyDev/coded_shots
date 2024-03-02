import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/background_color.dart';
import 'package:coded_shots/app/editor/widgets/padding_selector.dart';
import 'package:coded_shots/app/editor/widgets/radius_selector.dart';
import 'package:coded_shots/app/editor/widgets/visibility_selector.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/app_constants.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditPanel extends ConsumerWidget {
  const EditPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    return Container(
      width: 270,
      height: height(context),
      decoration: const BoxDecoration(color: b200),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          'Coded Shots'.txt(
            size: 18,
            fontWeight: FontWeight.w700,
          ),
          const Gap(30),

          //! background edit
          'Background'.txt(
            size: 16,
            fontWeight: FontWeight.w500,
          ),
          const Gap(15),
          const PaddingSelector(),
          const Gap(10),
          const RadiusSelector(),
          const Gap(10),
          const VisibilitySelector(),
          if (editorState.visible) ...[
            const Gap(10),
            const BackgroundColor(),
          ],
        ],
      ),
    );
  }
}
