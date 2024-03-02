// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coded_shots/data/editor_presets.dart';

class EditorStateNotifier extends Notifier<EditorState> {
  @override
  EditorState build() => EditorState(
        padding: 8,
        radius: 0,
        visible: true,
        backgroundColor: const Color(0xFF7e3bdf),
        shadow: ShadowPreset.none,
      );

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
}

class EditorState {
  final double padding;
  final double radius;
  final bool visible;
  final Color backgroundColor;
  Gradient? backgroundGradient;
  final ShadowPreset shadow;

  EditorState({
    required this.padding,
    required this.radius,
    required this.visible,
    required this.backgroundColor,
    this.backgroundGradient,
    required this.shadow,
  });

  EditorState copyWith({
    double? padding,
    double? radius,
    bool? visible,
    Color? backgroundColor,
    Gradient? backgroundGradient,
    ShadowPreset? shadow,
  }) {
    return EditorState(
      padding: padding ?? this.padding,
      radius: radius ?? this.radius,
      visible: visible ?? this.visible,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      shadow: shadow ?? this.shadow,
    );
  }
}

Gradient defaultGradient = const LinearGradient(
  colors: [
    Colors.purpleAccent,
    Colors.pink,
  ],
);
