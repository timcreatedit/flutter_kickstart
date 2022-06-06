import 'package:flutter/material.dart';

TextTheme getTextTheme(Brightness brightness) => brightness == Brightness.light
    ? Typography.material2021().black
    : Typography.material2021().black;
