import 'package:flutter_kickstart/src/localization/localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

L10n useL10n() {
  return L10n.of(useContext());
}
