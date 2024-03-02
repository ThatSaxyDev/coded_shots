import 'dart:math';

import 'package:coded_shots/data/editor_presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditorStateNotifier extends Notifier<EditorState> {
  @override
  EditorState build() => EditorState(
        padding: 8,
        radius: 0,
        visible: true,
        backgroundColor: Colors.purple,
        backgroundGradient: defaultGradient,
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
    state = state.copyWith(backgroundColor: newColor);
  }

  void changeColorRandom() {
    Random random = Random();
    Color randomColor =
        backgroundColors[random.nextInt(backgroundColors.length)];
    state = state.copyWith(backgroundColor: randomColor);
  }
}

class EditorState {
  final double padding;
  final double radius;
  final bool visible;
  final Color backgroundColor;
  final Gradient backgroundGradient;

  const EditorState({
    required this.padding,
    required this.radius,
    required this.visible,
    required this.backgroundColor,
    required this.backgroundGradient,
  });

  EditorState copyWith({
    double? padding,
    double? radius,
    bool? visible,
    Color? backgroundColor,
    Gradient? backgroundGradient,
  }) {
    return EditorState(
      padding: padding ?? this.padding,
      radius: radius ?? this.radius,
      visible: visible ?? this.visible,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }
}

Gradient defaultGradient = const LinearGradient(
  colors: [
    Colors.purpleAccent,
    Colors.pink,
  ],
);
