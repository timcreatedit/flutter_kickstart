import 'package:flutter/material.dart';
import 'package:flutter_kickstart/ui/theme/color_scheme.dart';
import 'package:flutter_kickstart/ui/theme/text_theme.dart';

ThemeData getAppTheme(Brightness brightness) => ThemeData.from(
      useMaterial3: true,
      colorScheme: getAppColorScheme(brightness),
      textTheme: getTextTheme(brightness),
    );
