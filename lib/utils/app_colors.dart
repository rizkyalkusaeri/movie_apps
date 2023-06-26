import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor get primary => _primaryColor.toMaterialColor();
  static MaterialColor get secondary => _secondaryColor.toMaterialColor();
  static MaterialColor get inputField => _inputFieldColor.toMaterialColor();
  static MaterialColor get lightSecondary =>
      _lightSecondaryColor.toMaterialColor();
  static MaterialColor get gray => _grayColor.toMaterialColor();
  static MaterialColor get lightGray => _lightGrayColor.toMaterialColor();
  static MaterialColor get success => _successColor.toMaterialColor();
  static MaterialColor get fail => _failColor.toMaterialColor();
  static MaterialColor get stroke => _strokeColor.toMaterialColor();
  static MaterialColor get progress => _progressColor.toMaterialColor();

  static MaterialAccentColor get focusColor =>
      _focusColor.toMaterialAccentColor();
  static MaterialAccentColor get title => _titleColor.toMaterialAccentColor();
  static MaterialAccentColor get white => _whiteColor.toMaterialAccentColor();

  static const Color _primaryColor = Color(0xFF151515);
  static const Color _secondaryColor = Color(0xFF137dc5);
  static const Color _lightSecondaryColor = Color(0xFFcef0ff);
  static const Color _grayColor = Color(0xFF666565);
  static const Color _lightGrayColor = Color(0xFF7b7777);
  static const Color _titleColor = Color(0xFF212121);
  static const Color _whiteColor = Color(0xFFffffff);
  static const Color _focusColor = Color(0xFF12d088);
  static const Color _successColor = Color(0xFFd9ffe9);
  static const Color _failColor = Color(0xFFff1c37);
  static const Color _strokeColor = Color(0xFFf5f5f5);
  static const Color _inputFieldColor = Color(0xFFcccccc);
  static const Color _progressColor = Color(0xFFf2994a);
}

extension _Material on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );

  MaterialAccentColor toMaterialAccentColor() => MaterialAccentColor(
        value,
        _toSwatch(),
      );
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
