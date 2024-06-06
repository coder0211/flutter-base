import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextStyle {
  AppTextStyle._();

  TextStyle size12(Color? color) => TextStyle(
        fontFamily: _FontFamily.primary.toString(),
        fontSize: _TextSize.size12,
        color: color ?? AppColors.black,
      ).normal;

  TextStyle size14(Color? color) => TextStyle(
        fontFamily: _FontFamily.primary.toString(),
        fontSize: _TextSize.size14,
        color: color ?? AppColors.black,
      ).normal;
}

class _TextSize {
  _TextSize._();

  static const double size12 = 12;
  static const double size14 = 14;
}

enum _FontFamily {
  primary;

  @override
  String toString() {
    if (this == _FontFamily.primary) {
      return "roboto";
    }
    return "";
  }
}

// extensions
extension AppTextStyleExtension on TextStyle {
  // font weight
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w300);

  // font style
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  // ...
}
