import 'package:flutter/services.dart';

extension BrightnessX on Brightness {
  Brightness get inverse =>
      this == Brightness.light ? Brightness.dark : Brightness.light;

  SystemUiOverlayStyle get matchingOverlayStyle => this == Brightness.light
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;

  SystemUiOverlayStyle get inverseOverlayStyle => inverse.matchingOverlayStyle;
}
