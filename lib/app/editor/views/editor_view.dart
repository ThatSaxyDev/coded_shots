import 'package:coded_shots/app/editor/views/panels/edit_panel.dart';
import 'package:coded_shots/app/editor/views/panels/main_panel.dart';
import 'package:coded_shots/shared/app_constants.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EditorView extends ConsumerWidget {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: b100,
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Row(
          children: [
            const EditPanel(),
            const MainPanel(),

            //! style
            Container(
              width: 270,
              height: height(context),
              decoration: const BoxDecoration(color: b200),
            )
          ],
        ),
      ),
    );
  }
}
