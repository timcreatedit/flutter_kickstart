import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

ColorScheme colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  background: TWColors.gray.shade100,
  onBackground: TWColors.gray.shade900,
  surface: TWColors.gray.shade200,
  onSurface: TWColors.gray.shade900,
  primary: TWColors.teal.shade500,
  onPrimary: TWColors.teal.shade900,
  secondary: TWColors.orange.shade500,
  onSecondary: TWColors.orange.shade900,
  primaryVariant: TWColors.teal.shade300,
  secondaryVariant: TWColors.orange.shade300,
  error: Colors.redAccent,
  onError: Color(0xFF200000),
);

ColorScheme colorSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  background: TWColors.gray.shade800,
  onBackground: TWColors.gray.shade100,
  surface: TWColors.gray.shade700,
  onSurface: TWColors.gray.shade100,
  primary: TWColors.teal.shade500,
  onPrimary: TWColors.teal.shade900,
  secondary: TWColors.orange.shade500,
  onSecondary: TWColors.orange.shade900,
  primaryVariant: TWColors.teal.shade300,
  secondaryVariant: TWColors.orange.shade300,
  error: Colors.redAccent,
  onError: Color(0xFF200000),
);
