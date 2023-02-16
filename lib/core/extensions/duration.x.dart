extension DurationX on Duration {
  String toStringHHMMSS() =>
      _prefix + toString().replaceAll("-", "").split('.').first.padLeft(8, "0");

  String toStringMMSS() {
    final hhmmss = toStringHHMMSS();
    return "$_prefix${hhmmss.substring(hhmmss.length - 5)}";
  }

  String toStringMSS() {
    final mmss = toStringMMSS().replaceAll("-", "");
    final trimmed = mmss.startsWith("0") ? mmss.substring(1) : mmss;
    return _prefix + trimmed;
  }

  String get _prefix => isNegative ? "-" : "";
}
