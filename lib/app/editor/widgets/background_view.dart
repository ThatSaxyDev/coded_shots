import 'package:coded_shots/app/editor/providers/editor_providers.dart';
import 'package:coded_shots/app/editor/widgets/code_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class BackgroundView extends ConsumerWidget {
  const BackgroundView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorNotifierProvider);
    final editorStateNotifier = ref.read(editorNotifierProvider.notifier);
    return SingleChildScrollView(
      controller: null,
      physics: const BouncingScrollPhysics(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        controller: null,
        child: WidgetsToImage(
          controller: editorStateNotifier.widgetToImageController,
          child:
              // editorState.exportBytes != null
              //     ? SizedBox(
              //             height: MediaQuery.of(context).size.height * .2,
              //             width: MediaQuery.of(context).size.width * .9,
              //             child: Image.memory(editorState.exportBytes!))
              //         .tap(onTap: () {
              //         editorStateNotifier.exportImage();
              //       })
              //     :
              AnimatedContainer(
            duration: 300.ms,
            // height: 400,
            // width: 400,
            padding: EdgeInsets.all(editorState.padding),
            // margin: EdgeInsets.only(
            //   top: 50,
            //   bottom: 50,
            //   left: 270.rW(context) - 50,
            // ),
            decoration: BoxDecoration(
              color: editorState.visible
                  ? editorState.backgroundColor
                  : Colors.transparent,
              gradient: editorState.backgroundGradient,
              borderRadius: BorderRadius.circular(editorState.radius),
            ),
            child: const Center(child: CodeView()),
          ),
        ),
      ),
    );
  }
}
