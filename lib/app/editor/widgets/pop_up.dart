import 'package:coded_shots/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

class PopUpOverlay extends StatelessWidget {
  const PopUpOverlay({
    Key? key,
    required this.visible,
    required this.onClose,
    required this.modal,
    required this.child,
    this.follower = Alignment.topLeft,
    this.target = Alignment.topRight,
  }) : super(key: key);

  final Widget child;
  final Widget modal;
  final bool visible;
  final VoidCallback onClose;
  final Alignment follower;
  final Alignment target;

  @override
  Widget build(BuildContext context) {
    return Barrier(
      visible: visible,
      onClose: onClose,
      child: PortalTarget(
        anchor: Aligned(
          follower: follower,
          target: target,
        ),
        visible: visible,
        closeDuration: kThemeAnimationDuration,
        portalFollower: TweenAnimationBuilder<double>(
          duration: kThemeAnimationDuration,
          curve: Curves.easeOut,
          tween: Tween(begin: 0, end: visible ? 1 : 0),
          builder: (context, progress, child) {
            return Transform(
              transform: Matrix4.translationValues(0, (1 - progress) * 50, 0),
              child: Opacity(
                opacity: progress,
                child: child,
              ),
            );
          },
          child: modal,
        ),
        child: child,
      ),
    );
  }
}

class Barrier extends StatelessWidget {
  const Barrier({
    Key? key,
    required this.onClose,
    required this.visible,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onClose;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: visible,
      closeDuration: kThemeAnimationDuration,
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClose,
        child: TweenAnimationBuilder<Color>(
          duration: kThemeAnimationDuration,
          tween: ColorTween(
              begin: Colors.transparent,
              end: switch (visible) {
                true => neutralBlack.withOpacity(0.15),
                false => Colors.transparent,
              }),
          builder: (context, color, child) {
            return ColoredBox(color: color);
          },
        ),
      ),
      child: child,
    );
  }
}

/// Non-nullable version of ColorTween.
class ColorTween extends Tween<Color> {
  ColorTween({required Color begin, required Color end})
      : super(begin: begin, end: end);

  @override
  Color lerp(double t) => Color.lerp(begin, end, t)!;
}
