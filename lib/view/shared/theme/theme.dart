library physio_theme;

import 'package:flutter/material.dart';

import 'src/colors.dart';
import 'src/text_styles.dart';

export 'src/colors.dart';
export 'src/spacing.dart';
export 'src/text_styles.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: colorSchemeLight,
  textTheme: textThemeLight,
  primaryColor: colorSchemeLight.primary,
  accentColor: colorSchemeLight.secondary,
);

ThemeData darkTheme = ThemeData(
  colorScheme: colorSchemeDark,
  textTheme: textThemeDark,
  primaryColor: colorSchemeDark.primary,
  accentColor: colorSchemeDark.secondary,
);
