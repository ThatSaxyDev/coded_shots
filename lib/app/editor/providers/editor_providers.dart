import 'package:coded_shots/app/editor/notifiers/editor_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editorNotifierProvider =
    NotifierProvider<EditorStateNotifier, EditorState>(() {
  return EditorStateNotifier();
});
