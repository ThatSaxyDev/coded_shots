import 'package:coded_shots/app/editor/notifiers/editor_state_notifier.dart';
import 'package:coded_shots/theme/palette.dart';
import 'package:coded_shots/utils/highlighter.dart';
import 'package:flutter/material.dart';

List<double> paddings = [8, 16, 32, 64];

List<double> radiuses = [0, 8, 16, 24];

List<Color> backgroundColors = const [
  Color(0xFF000000),
  Color(0xFF1a1a1a),
  Color(0xFF1e222f),
  Color(0xFF213043),
  Color(0xFF383c4a),
  Color(0xFF999999),
  Color(0xFFA2B1D2),
  Color(0xFFFFFFFF),
  Color(0xFFda4d4d),
  Color(0xFFe97171),
  Color(0xFFFF88AA),
  Color(0xFFfdad5d),
  Color(0xFFe3db2a),
  Color(0xFFFFEE66),
  Color(0xFFffcc99),
  Color(0xFF7e3bdf),
  Color(0xFF8663ed),
  Color(0xFFBD93F9),
  Color(0xFFd4b8ff),
  Color(0xFF79a1ff),
  Color(0xFF4455BB),
  Color(0xFF1e88df),
  Color(0xFF1b55d9),
  Color(0xFF1a3f95),
  Color(0xFF1c933f),
  Color(0xFF64e7a3),
  Color(0xFF21d5b8),
  Color(0xFF06535d),
];

List<ThemePreset> themePresets = [
  ThemePreset(
    style: SyntaxHighlighterStyle.lightThemeStyle(),
    color: const Color(0xFFFFFFFF),
    buttonColor: neutralBlack,
  ),
  ThemePreset(
    style: SyntaxHighlighterStyle.darkThemeStyle(),
    color: const Color(0xFF213043),
    buttonColor: neutralWhite,
  ),
  ThemePreset(
    style: SyntaxHighlighterStyle.darkThemeStyle(),
    color: const Color(0xFF000000),
    buttonColor: neutralWhite,
  ),
  ThemePreset(
    style: SyntaxHighlighterStyle.lightThemeStyle(),
    color: const Color(0xFFA2B1D2),
    buttonColor: neutralBlack,
  ),
  ThemePreset(
    style: SyntaxHighlighterStyle.darkThemeStyle(),
    color: const Color(0xFF1a3f95),
    buttonColor: neutralWhite,
  ),
  ThemePreset(
    style: SyntaxHighlighterStyle.lightThemeStyle(),
    color: const Color(0xFF64e7a3),
    buttonColor: neutralBlack,
  ),
  ThemePreset(
    style: SyntaxHighlighterStyle.lightThemeStyle(),
    color: const Color(0xFFFF88AA),
    buttonColor: neutralBlack,
  ),
];

enum ShadowPreset {
  none(0),
  small(5),
  medium(12),
  large(25);

  const ShadowPreset(this.value);
  final double value;
}

enum PseudoButtonStyle { none, mac, win }

enum FontWeightPreset {
  regular(FontWeight.w400),
  medium(FontWeight.w500),
  bold(FontWeight.w600);

  const FontWeightPreset(this.value);
  final FontWeight value;
}

enum FontFamilyPreset {
  jetBrains('JetBrainsMono'),
  sourceCode('SourceCodePro'),
  overPass('OverpassMono'),
  space('SpaceMono'),
  anon('AnonymousPro');

  const FontFamilyPreset(this.value);
  final String value;
}

List<LinearGradient> backgroundGradients = [
  // Gradient 1
  LinearGradient(
    colors: [
      backgroundColors[0],
      backgroundColors[5],
      backgroundColors[10],
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Gradient 2
  LinearGradient(
    colors: [
      backgroundColors[2],
      backgroundColors[15],
      backgroundColors[20],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Gradient 3
  LinearGradient(
    colors: [
      backgroundColors[7],
      backgroundColors[12],
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Gradient 4
  LinearGradient(
    colors: [
      backgroundColors[17],
      backgroundColors[22],
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ),
  // Gradient 5
  LinearGradient(
    colors: [
      backgroundColors[3],
      backgroundColors[8],
      backgroundColors[19],
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
  // Gradient 6
  LinearGradient(
    colors: [
      backgroundColors[6],
      backgroundColors[11],
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  ),
  // Gradient 7
  LinearGradient(
    colors: [
      backgroundColors[13],
      backgroundColors[18],
      backgroundColors[23],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Gradient 8
  LinearGradient(
    colors: [
      backgroundColors[1],
      backgroundColors[14],
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  // Gradient 9
  LinearGradient(
    colors: [
      backgroundColors[4],
      backgroundColors[9],
      backgroundColors[24],
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ),
  // Gradient 10
  LinearGradient(
    colors: [
      backgroundColors[16],
      backgroundColors[21],
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Gradient 11
  LinearGradient(
    colors: [
      backgroundColors[25],
      backgroundColors[0],
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Gradient 12
  LinearGradient(
    colors: [
      backgroundColors[10],
      backgroundColors[20],
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ),
  // Gradient 13
  LinearGradient(
    colors: [
      backgroundColors[5],
      backgroundColors[15],
      backgroundColors[22],
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
  // Gradient 14
  LinearGradient(
    colors: [
      backgroundColors[2],
      backgroundColors[7],
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  ),
  // Gradient 15
  LinearGradient(
    colors: [
      backgroundColors[12],
      backgroundColors[17],
      backgroundColors[23],
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ),
  // Gradient 16
  LinearGradient(
    colors: [
      backgroundColors[3],
      backgroundColors[8],
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Gradient 17
  LinearGradient(
    colors: [
      backgroundColors[18],
      backgroundColors[25],
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  // Gradient 18
  LinearGradient(
    colors: [
      backgroundColors[11],
      backgroundColors[21],
      backgroundColors[4],
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Gradient 19
  LinearGradient(
    colors: [
      backgroundColors[1],
      backgroundColors[9],
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  ),
  // Gradient 20
  LinearGradient(
    colors: [
      backgroundColors[19],
      backgroundColors[13],
      backgroundColors[6],
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
  // Gradient 21
  LinearGradient(
    colors: [
      backgroundColors[14],
      backgroundColors[24],
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ),
  // Gradient 22
  LinearGradient(
    colors: [
      backgroundColors[16],
      backgroundColors[20],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  // Gradient 23
  LinearGradient(
    colors: [
      backgroundColors[0],
      backgroundColors[10],
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  ),
  // Gradient 24
  LinearGradient(
    colors: [
      backgroundColors[7],
      backgroundColors[22],
      backgroundColors[3],
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  ),
  // Gradient 25
  LinearGradient(
    colors: [
      backgroundColors[5],
      backgroundColors[15],
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  // Gradient 26
  LinearGradient(
    colors: [
      backgroundColors[8],
      backgroundColors[17],
      backgroundColors[18],
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  ),
  // Gradient 27
  LinearGradient(
    colors: [
      backgroundColors[25],
      backgroundColors[21],
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  // Gradient 28
  LinearGradient(
    colors: [
      backgroundColors[9],
      backgroundColors[12],
    ],
    begin: Alignment.topRight,
    end: Alignment.centerRight,
  ),
];
