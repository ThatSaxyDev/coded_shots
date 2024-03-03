// START enum_preset
import 'package:coded_shots/shared/extensions/extensions.dart';

enum ShadowPresett {
  none(0),
  small(5),
  medium(12),
  large(25);

  const ShadowPresett(this.value);
  final double value;
}
// END

// START pro
final paste = true.notifier;
// END
