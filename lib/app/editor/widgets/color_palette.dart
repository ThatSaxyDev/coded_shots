import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/shared/widgets/custom_flex.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ColorPalette extends ConsumerStatefulWidget {
  final void Function()? close;
  const ColorPalette({
    super.key,
    this.close,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends ConsumerState<ColorPalette> {
  final PageController pageController = PageController();
  int view = 0;

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return Material(
      elevation: 8,
      color: Colors.transparent,
      child: Container(
        height: 400,
        width: 300,
        padding: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: b100,
          border: Border.all(width: 1, color: grey600),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Color'.txt(
                    size: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const Icon(
                    PhosphorIconsBold.x,
                    color: neutralWhite,
                    size: 20,
                  ).tap(onTap: () {
                    widget.close!();
                  }),
                ],
              ),
            ),
            const Gap(20),
            Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: b200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: AnimatedAlign(
                      alignment: switch (view) {
                        0 => Alignment.centerLeft,
                        _ => Alignment.centerRight,
                      },
                      duration: 300.ms,
                      child: Container(
                        width: 130,
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
                        Center(child: 'Color'.txt()).tap(
                          onTap: () {
                            pageController.animateToPage(
                              0,
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                            );
                            setState(() => view = 0);
                          },
                        ),
                        Center(child: 'Gradient'.txt()).tap(
                          onTap: () {
                            pageController.animateToPage(
                              1,
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                            );
                            setState(() => view = 1);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //! colors
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Wrap(
                      runAlignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.spaceEvenly,
                      children: List.generate(
                        backgroundColors.length,
                        (index) => SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: CircleAvatar(
                              radius: 18.5,
                              backgroundColor: backgroundColors[index] ==
                                      editorState.backgroundColor
                                  ? neutralWhite
                                  : Colors.transparent,
                              child: CircleAvatar(
                                radius: 17,
                                backgroundColor: backgroundColors[index],
                              ).tap(onTap: () {
                                editorStateNotifier.changeColor(
                                    newColor: backgroundColors[index]);
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: 'Coming soon'.txt(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
