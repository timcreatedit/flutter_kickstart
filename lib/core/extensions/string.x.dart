extension StringX on String {
  String? get ifNotEmpty => isNotEmpty ? this : null;
}
