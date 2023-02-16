import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  bool get isLoadingInitial => isLoading && !hasValue && !hasError;

  T? get latestValueOrNull => whenOrNull(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        data: (v) => v,
      );

  T latestOr(T def) => latestValueOrNull ?? def;
}
