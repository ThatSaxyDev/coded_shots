// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:coded_shots/utils/banner.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'package:coded_shots/data/editor_presets.dart';
import 'package:coded_shots/shared/extensions/extensions.dart';
import 'package:coded_shots/utils/highlighter.dart';

class EditorStateNotifier extends Notifier<EditorState> {
  @override
  EditorState build() => EditorState(
        padding: 8,
        radius: 0,
        visible: true,
        backgroundColor: const Color(0xFF7e3bdf),
        shadow: ShadowPreset.none,
        psButtonStyle: PseudoButtonStyle.mac,
        fontWeightPreset: FontWeightPreset.regular,
        waterMark: true,
        fontFamilyPreset: FontFamilyPreset.jetBrains,
        themePreset: themePresets[0],
      );

  WidgetsToImageController widgetToImageController = WidgetsToImageController();

  void changePadding({required double newPadding}) {
    state = state.copyWith(padding: newPadding);
  }

  void changeRadius({required double newRadius}) {
    state = state.copyWith(radius: newRadius);
  }

  void toggleVisibility() {
    state = state.copyWith(visible: !state.visible);
  }

  void changeColor({required Color newColor}) {
    state = state.copyWith(
      backgroundColor: newColor,
    );
    state.backgroundGradient = null;
  }

  void changeGradient({required Gradient newGradient}) {
    state = state.copyWith(backgroundGradient: newGradient);
  }

  void changeColorRandom() {
    Random random = Random();
    Color randomColor =
        backgroundColors[random.nextInt(backgroundColors.length)];
    state = state.copyWith(backgroundColor: randomColor);
  }

  void changeShadow({required ShadowPreset newShadow}) {
    state = state.copyWith(shadow: newShadow);
  }

  void changePseudoButtons({required PseudoButtonStyle newStyle}) {
    state = state.copyWith(psButtonStyle: newStyle);
  }

  void changeFontWeight({required FontWeightPreset newFontWeight}) {
    state = state.copyWith(fontWeightPreset: newFontWeight);
  }

  void toggleWaterMark() {
    state = state.copyWith(waterMark: !state.waterMark);
  }

  void changeFontFamily({required FontFamilyPreset newFontFam}) {
    state = state.copyWith(fontFamilyPreset: newFontFam);
  }

  void changeThemePreset({required ThemePreset newThemePreset}) {
    state = state.copyWith(themePreset: newThemePreset);
  }

  // void setExportBytes({required Uint8List exportBytes}) {
  //   state = state.copyWith(exportBytes: exportBytes);
  //   // exportImage();
  // }

  // void exportImage() async {
  //   // final directory = (await getApplicationDocumentsDirectory()).path;
  //   // directory.log();
  //   // if (state.exportBytes == null) {
  //   //   'no image bytes'.log();
  //   //   return;
  //   // }

  //   // File imageFile = File('$directory/codedshots_${DateTime.now()}.png');
  //   // imageFile.writeAsBytes(state.exportBytes!);

  //   // state = state.copyWith(
  //   //   imageFile: imageFile,
  //   // );

  //   // state.imageFile!.path.log();

  //   String path = await FileSaver.instance.saveFile(
  //     name: 'codedshots_${DateTime.now()}',
  //     bytes: state.exportBytes!,
  //     ext: 'png',
  //     mimeType: MimeType.png,
  //   );

  //   path.log();
  // }

  void exportImageByBytes({
    required Uint8List exportBytes,
    required BuildContext context,
  }) async {
    // final directory = (await getApplicationDocumentsDirectory()).path;
    // directory.log();
    // if (state.exportBytes == null) {
    //   'no image bytes'.log();
    //   return;
    // }

    // File imageFile = File('$directory/codedshots_${DateTime.now()}.png');
    // imageFile.writeAsBytes(state.exportBytes!);

    // state = state.copyWith(
    //   imageFile: imageFile,
    // );

    // state.imageFile!.path.log();

    String path = await FileSaver.instance.saveFile(
      name: 'codedshots_${DateTime.now()}',
      bytes: exportBytes,
      ext: 'png',
      mimeType: MimeType.png,
    );
    path.log();
    showBanner(
        context: context,
        theMessage: 'Code snippet saved to downloads',
        theType: NotificationType.success);
  }

  // void removeExportBytes() {
  //   state.exportBytes = null;
  //   state = state.copyWith();
  // }
}

class EditorState {
  final double padding;
  final double radius;
  final bool visible;
  final Color backgroundColor;
  Gradient? backgroundGradient;
  final ShadowPreset shadow;
  final PseudoButtonStyle psButtonStyle;
  final FontWeightPreset fontWeightPreset;
  final bool waterMark;
  final FontFamilyPreset fontFamilyPreset;
  final ThemePreset themePreset;
  Uint8List? exportBytes;
  File? imageFile;

  EditorState({
    required this.padding,
    required this.radius,
    required this.visible,
    required this.backgroundColor,
    this.backgroundGradient,
    required this.shadow,
    required this.psButtonStyle,
    required this.fontWeightPreset,
    required this.waterMark,
    required this.fontFamilyPreset,
    required this.themePreset,
    this.exportBytes,
    this.imageFile,
  });

  EditorState copyWith({
    double? padding,
    double? radius,
    bool? visible,
    Color? backgroundColor,
    Gradient? backgroundGradient,
    ShadowPreset? shadow,
    PseudoButtonStyle? psButtonStyle,
    FontWeightPreset? fontWeightPreset,
    bool? waterMark,
    FontFamilyPreset? fontFamilyPreset,
    ThemePreset? themePreset,
    Uint8List? exportBytes,
    File? imageFile,
  }) {
    return EditorState(
      padding: padding ?? this.padding,
      radius: radius ?? this.radius,
      visible: visible ?? this.visible,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      shadow: shadow ?? this.shadow,
      psButtonStyle: psButtonStyle ?? this.psButtonStyle,
      fontWeightPreset: fontWeightPreset ?? this.fontWeightPreset,
      waterMark: waterMark ?? this.waterMark,
      fontFamilyPreset: fontFamilyPreset ?? this.fontFamilyPreset,
      themePreset: themePreset ?? this.themePreset,
      exportBytes: exportBytes ?? this.exportBytes,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}

class ThemePreset {
  final SyntaxHighlighterStyle style;
  final Color color;
  final Color buttonColor;

  ThemePreset({
    required this.style,
    required this.color,
    required this.buttonColor,
  });

  ThemePreset copyWith({
    SyntaxHighlighterStyle? style,
    Color? color,
    Color? buttonColor,
  }) {
    return ThemePreset(
      style: style ?? this.style,
      color: color ?? this.color,
      buttonColor: buttonColor ?? this.buttonColor,
    );
  }
}
