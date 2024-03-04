import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showBanner({
  required BuildContext context,
  required String theMessage,
  required NotificationType theType,
}) {
  Flushbar(
    message: theMessage,
    messageSize: 15,
    duration: const Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    borderRadius: BorderRadius.circular(7),
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.linearToEaseOut,
    messageColor: Colors.white,
    icon: Icon(
      theType == NotificationType.failure
          ? PhosphorIcons.warning(PhosphorIconsStyle.bold)
          : theType == NotificationType.success
              ? PhosphorIcons.checks(PhosphorIconsStyle.bold)
              : PhosphorIcons.warningCircle(PhosphorIconsStyle.bold),
      color: Colors.white,
    ),
    backgroundColor: theType == NotificationType.failure
        ? const Color.fromRGBO(254, 98, 88, 1)
        : theType == NotificationType.success
            ? const Color.fromRGBO(35, 194, 75, 1)
            : const Color.fromRGBO(251, 186, 64, 1),
  ).show(context);
}

//! ENUM FOR NOTIFICATION TYPE
enum NotificationType { success, failure, info }
