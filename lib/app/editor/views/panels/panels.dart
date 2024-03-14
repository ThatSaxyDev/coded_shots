import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/background_color.dart';
import 'package:coded_shots/app/editor/widgets/font_fam_selector.dart';
import 'package:coded_shots/app/editor/widgets/fontweight_selector.dart';
import 'package:coded_shots/app/editor/widgets/padding_selector.dart';
import 'package:coded_shots/app/editor/widgets/pseudo_button_style_selector.dart';
import 'package:coded_shots/app/editor/widgets/radius_selector.dart';
import 'package:coded_shots/app/editor/widgets/shadow_selector.dart';
import 'package:coded_shots/app/editor/widgets/theme_card.dart';
import 'package:coded_shots/app/editor/widgets/visibility_selector.dart';
import 'package:coded_shots/app/editor/widgets/watermark_visibility.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Panel extends ConsumerWidget {
  final ScrollController? scrollController;
  const Panel({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Row(
            children: [
              const Icon(
                PhosphorIconsFill.penNib,
                size: 20,
                color: neutralWhite,
              ),
              const Gap(2),
              'CodedShots'.txt(size: 18, fontWeight: FontWeight.w700),
            ],
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

          const Gap(30),

          //! foreground edit
          'Foreground'.txt(
            size: 16,
            fontWeight: FontWeight.w500,
          ),
          const Gap(15),
          const ShadowSelector(),
          const Gap(10),
          const PseudoButttonWindowSelector(),
          const Gap(10),
          const FontWeightSelector(),
          const Gap(10),
          const WaterMarkVisibilitySelector(),
          const Gap(10),
          const FontFamSelector(),

          const Gap(30),

          //!
          '???'.txt(
            size: 16,
            fontWeight: FontWeight.w500,
          ),
          const Gap(15),
          SeparatedColumn(
            children: List.generate(
              themePresets.length,
              (index) => ThemeCard(
                themePreset: themePresets[index],
                index: index,
              ),
            ),
            separatorBuilder: () => const Gap(20),
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
