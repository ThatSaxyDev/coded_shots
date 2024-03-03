import 'package:flutter/services.dart';

class MyClipboard {
  /// copy receives a string text and saves to Clipboard
  /// returns void
  static Future<void> copy(String text) async {
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
      return;
    } else {
      throw ('Please enter a string');
    }
  }

  /// Paste retrieves the data from clipboard.
  static Future<String> paste() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    return data?.text?.toString() ?? "";
  }

  /// controlC receives a string text and saves to Clipboard
  /// returns boolean value
  static Future<bool> controlCee(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } else {
      return false;
    }
  }

  /// controlV retrieves the data from clipboard.
  /// same as paste
  /// But returns dynamic data
  static Future<dynamic> controlVee() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    return data;
  }
}
