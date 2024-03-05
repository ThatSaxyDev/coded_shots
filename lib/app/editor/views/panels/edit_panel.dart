import 'package:coded_shots/app/editor/views/panels/panels.dart';
import 'package:coded_shots/shared/app_constants.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class EditPanel extends ConsumerStatefulWidget {
  const EditPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPanelState();
}

class _EditPanelState extends ConsumerState<EditPanel> {
  // Controllers
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: height(context),
      decoration: const BoxDecoration(color: b200),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: kIsWeb
          ? WebSmoothScroll(
              controller: _scrollController,
              child: Panel(
                scrollController: _scrollController,
              ),
            )
          : Panel(
              scrollController: _scrollController,
            ),
    );
  }
}
