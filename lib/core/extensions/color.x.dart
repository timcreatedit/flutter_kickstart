import 'dart:ui';

import 'package:material_color_utilities/blend/blend.dart';
import 'package:material_color_utilities/hct/hct.dart';

extension ColorX on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  Hct toHct() => Hct.fromInt(value);

  Color harmonizeWith(Color other) {
    return Color(Blend.harmonize(value, other.value));
  }

  static Color lerpBlend(Color from, Color to, double value) {
    final hctFrom = Hct.fromInt(from.value);
    final hctTo = Hct.fromInt(to.value);
    final result = Hct.from(
      lerpDouble(hctFrom.hue, hctTo.hue, value)!,
      lerpDouble(hctFrom.chroma, hctTo.chroma, value)!,
      lerpDouble(hctFrom.tone, hctTo.tone, value)!,
    );
    return Color(result.toInt());
  }
}
