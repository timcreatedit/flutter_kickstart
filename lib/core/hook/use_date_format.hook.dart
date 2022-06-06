import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

DateFormat useDateFormat(String pattern) {
  final use24h = MediaQuery.of(useContext()).alwaysUse24HourFormat;
  final locale = Localizations.localeOf(useContext());
  return useMemoized(
        () => DateFormat(
      use24h ? pattern.replaceAll("j", "H") : pattern,
      locale.toLanguageTag(),
    ),
    [pattern, locale, use24h],
  );
}