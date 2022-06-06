import 'package:flutter/material.dart';

ColorScheme getAppColorScheme(Brightness brightness) => ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: Colors.green,
    );
