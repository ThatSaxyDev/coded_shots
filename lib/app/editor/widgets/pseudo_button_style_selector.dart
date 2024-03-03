import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/pop_up.dart';
import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PseudoButttonWindowSelector extends ConsumerStatefulWidget {
  const PseudoButttonWindowSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PseudoButttonWindowSelectorState();
}

class _PseudoButttonWindowSelectorState
    extends ConsumerState<PseudoButttonWindowSelector> {
  bool showModal = false;
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: 'Window'.txt(size: 12, color: grey400),
        ),
        Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            color: b100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: PopUpOverlay(
            follower: Alignment.topCenter,
            target: Alignment.bottomCenter,
            visible: showModal,
            modal: Material(
              elevation: 8,
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                // height: 400,
                width: 150,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                  color: b100,
                  border: Border.all(width: 1, color: grey600),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SeparatedColumn(
                  mainAxisSize: MainAxisSize.min,
                  separatorBuilder: () => const Gap(5),
                  children: List.generate(
                    PseudoButtonStyle.values.length,
                    (index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: editorState.psButtonStyle ==
                                    PseudoButtonStyle.values[index] ||
                                _hoveredIndex == index
                            ? b200
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: switch (index) {
                        0 => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PseudoButtonStyle.values[index].name
                                  .toCapitalized()
                                  .txt(
                                    size: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ],
                          ),
                        1 => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SeparatedRow(
                              separatorBuilder: () => const Gap(7),
                              children: List.generate(
                                3,
                                (index) => CircleAvatar(
                                  radius: 7,
                                  backgroundColor: switch (index) {
                                    0 => const Color.fromRGBO(254, 98, 88, 1),
                                    1 => const Color.fromRGBO(251, 186, 64, 1),
                                    _ => const Color.fromRGBO(35, 194, 75, 1),
                                  },
                                ),
                              ),
                            ),
                          ),
                        _ => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SeparatedRow(
                              separatorBuilder: () => const Gap(7),
                              children: List.generate(
                                3,
                                (index) => switch (index) {
                                  0 => const Icon(
                                      PhosphorIconsBold.x,
                                      size: 14,
                                      color: neutralWhite,
                                    ),
                                  1 => const Icon(
                                      PhosphorIconsBold.square,
                                      size: 14,
                                      color: neutralWhite,
                                    ),
                                  _ => const Icon(
                                      PhosphorIconsBold.minus,
                                      size: 14,
                                      color: neutralWhite,
                                    ),
                                },
                              ),
                            ),
                          ),
                      },
                    ).tap(
                      onTap: () {
                        editorStateNotifier.changePseudoButtons(
                            newStyle: PseudoButtonStyle.values[index]);
                        setState(() => showModal = false);
                      },
                      onHover: (isHovered) {
                        setState(() {
                          _hoveredIndex = isHovered ? index : -1;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            onClose: () => setState(() => showModal = false),
            child: Center(
              child: editorState.psButtonStyle == PseudoButtonStyle.none
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: 'None'.txt().alignCenterLeft(),
                    )
                  : SeparatedRow(
                      mainAxisAlignment: MainAxisAlignment.center,
                      separatorBuilder: () => const Gap(7),
                      children: List.generate(
                        3,
                        (index) => switch (editorState.psButtonStyle) {
                          PseudoButtonStyle.mac => CircleAvatar(
                              radius: 7,
                              backgroundColor: switch (index) {
                                0 => const Color.fromRGBO(254, 98, 88, 1),
                                1 => const Color.fromRGBO(251, 186, 64, 1),
                                _ => const Color.fromRGBO(35, 194, 75, 1),
                              },
                            ),
                          PseudoButtonStyle.win => switch (index) {
                              0 => const Icon(
                                  PhosphorIconsBold.x,
                                  size: 14,
                                  color: neutralWhite,
                                ),
                              1 => const Icon(
                                  PhosphorIconsBold.square,
                                  size: 14,
                                  color: neutralWhite,
                                ),
                              _ => const Icon(
                                  PhosphorIconsBold.minus,
                                  size: 14,
                                  color: neutralWhite,
                                ),
                            },
                          PseudoButtonStyle.none => const SizedBox.shrink(),
                        },
                      ),
                    ),
            ).tap(onTap: () {
              setState(() => showModal = true);
            }),
          ),
        ),
      ],
    );
  }
}

// class PsMacButtons extends ConsumerWidget {
//   const PsMacButtons({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return const Placeholder();
//   }
// }
