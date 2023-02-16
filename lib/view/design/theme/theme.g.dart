// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$themeHash() => r'6ca21a8b4349cadfe27bff60b2e0729a3ed053c7';

/// See also [theme].
class ThemeProvider extends AutoDisposeProvider<ThemeData> {
  ThemeProvider({
    this.brightness = Brightness.light,
  }) : super(
          (ref) => theme(
            ref,
            brightness: brightness,
          ),
          from: themeProvider,
          name: r'themeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$themeHash,
        );

  final Brightness brightness;

  @override
  bool operator ==(Object other) {
    return other is ThemeProvider && other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ThemeRef = AutoDisposeProviderRef<ThemeData>;

/// See also [theme].
final themeProvider = ThemeFamily();

class ThemeFamily extends Family<ThemeData> {
  ThemeFamily();

  ThemeProvider call({
    Brightness brightness = Brightness.light,
  }) {
    return ThemeProvider(
      brightness: brightness,
    );
  }

  @override
  AutoDisposeProvider<ThemeData> getProviderOverride(
    covariant ThemeProvider provider,
  ) {
    return call(
      brightness: provider.brightness,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'themeProvider';
}
