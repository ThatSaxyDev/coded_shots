import 'dart:typed_data';

import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/code_view.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class MainPanel extends ConsumerStatefulWidget {
  const MainPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPanelState();
}

class _MainPanelState extends ConsumerState<MainPanel> {
  // WidgetsToImageController to access widget
  WidgetsToImageController controller = WidgetsToImageController();
  // to save image bytes of widget
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorNotifierProvider);
    // final editorStateNotifier = ref.read(editorNotifierProvider.notifier);

    return Expanded(
      child: Container(
        // height: height(context),
        // width: 200,
        decoration: const BoxDecoration(color: b100),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: WidgetsToImage(
              controller: controller,
              child: bytes != null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * .9,
                      child: Image.memory(bytes!))
                  : AnimatedContainer(
                      duration: 300.ms,
                      // height: 400,
                      // width: 400,
                      padding: EdgeInsets.all(editorState.padding),
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 50,
                        left: 270.rW(context) - 50,
                      ),
                      decoration: BoxDecoration(
                        color: editorState.visible
                            ? editorState.backgroundColor
                            : Colors.transparent,
                        gradient: editorState.backgroundGradient,
                        borderRadius: BorderRadius.circular(editorState.radius),
                      ),
                      child: const Center(child: CodeView()),
                    ).tap(
                      onTap: () async {
                        final bytess = await controller.capture();
                        setState(() {
                          bytes = bytess;
                        });
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
