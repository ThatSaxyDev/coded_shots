import 'package:coded_shots/app/editor/widgets/background_view.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class MainPanel extends ConsumerStatefulWidget {
  const MainPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPanelState();
}

class _MainPanelState extends ConsumerState<MainPanel> {
  // Controllers
  // late ScrollController _vertScrollController;
  // late ScrollController _horScrollController;

  // @override
  // void initState() {
  //   // initialize scroll controllers
  //   _vertScrollController = ScrollController();
  //   _horScrollController = ScrollController();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          // height: height(context),
          // width: 200,
          decoration: const BoxDecoration(color: b100),
          child:
              //  kIsWeb
              //     ? WebSmoothScroll(
              //         controller: _vertScrollController,
              //         child: WebSmoothScroll(
              //           controller: _horScrollController,
              //           child: BackgroundView(
              //             vertScrollController: _vertScrollController,
              //             horScrollController: _horScrollController,
              //           ),
              //         ))
              //     :
              const BackgroundView()),
    );
  }
}
