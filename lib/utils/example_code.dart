import 'package:coded_shots/app/editor/notifiers/editor_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// START enum_preset
enum ShadowPreset {
  none(0),
  small(5),
  medium(12),
  large(25);

  const ShadowPreset(this.value);
  final double value;
}
// END

// START pro
final editorNotifierProvider =
    NotifierProvider<EditorStateNotifier, EditorState>(() {
  return EditorStateNotifier();
});
// END
