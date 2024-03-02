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

class ShadowSelector extends ConsumerStatefulWidget {
  const ShadowSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShadowSelectorState();
}

class _ShadowSelectorState extends ConsumerState<ShadowSelector>
    with SingleTickerProviderStateMixin {
  bool showModal = false;
  int _hoveredIndex = -1;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 300), // Adjust the duration as needed
    );
    _animation = Tween<double>(
      begin: 0,
      end: 0.5, // Angle in radians for 180 degrees
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: 'Shadow'.txt(size: 12, color: grey400),
        ),
        PopUpOverlay(
          visible: showModal,
          follower: Alignment.topCenter,
          target: Alignment.bottomCenter,
          modal: Material(
            elevation: 8,
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              // height: 400,
              width: 150,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              decoration: BoxDecoration(
                color: b100,
                border: Border.all(width: 1, color: grey600),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SeparatedColumn(
                mainAxisSize: MainAxisSize.min,
                separatorBuilder: () => const Gap(5),
                children: List.generate(
                  ShadowPreset.values.length,
                  (index) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: editorState.shadow == ShadowPreset.values[index] ||
                              _hoveredIndex == index
                          ? b200
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShadowPreset.values[index].name.toCapitalized().txt(
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ),
                        editorState.shadow == ShadowPreset.values[index]
                            ? const Icon(
                                PhosphorIconsBold.check,
                                size: 20,
                                color: neutralWhite,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ).tap(
                    onTap: () {
                      editorStateNotifier.changeShadow(
                          newShadow: ShadowPreset.values[index]);
                      setState(() => showModal = false);
                      if (showModal) {
                        _controller.forward();
                      } else {
                        _controller.reverse();
                      }
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
          onClose: () {
            setState(() => showModal = false);
            if (showModal) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
          child: Container(
            width: 150,
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: b100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                editorState.shadow.name.toCapitalized().txt(),
                RotationTransition(
                  turns: _animation,
                  child: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 24,
                    color: neutralWhite,
                  ),
                )
              ],
            ),
          ).tap(onTap: () {
            setState(() => showModal = true);

            if (showModal) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          }),
        ),
      ],
    );
  }
}
