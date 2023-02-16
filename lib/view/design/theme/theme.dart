import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

@riverpod
ThemeData theme(
  ThemeRef ref, {
  Brightness brightness = Brightness.light,
}) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
  );
}
