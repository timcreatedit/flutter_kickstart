import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_kickstart/view/design/spacing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef LoadingBuilder = Widget Function();
typedef ErrorBuilder = Widget Function(Object error, StackTrace? stackTrace);

extension AsyncValueBuilderX<T> on AsyncValue<T> {
  /// Builds a widget for this async value with sensible default widgets for
  /// loading and error states, as well as a [data] callback for whatever is
  /// built when this AsyncValue is loaded.
  ///
  /// If [debugPrintErrors] is true (default), errors are printed to the console.
  Widget build({
    required Widget Function(T data) data,
    LoadingBuilder? loading,
    ErrorBuilder? error,
    bool debugPrintErrors = true,
    bool skipLoadingOnRefresh = true,
    bool skipLoadingOnReload = true,
  }) =>
      when(
        skipLoadingOnRefresh: skipLoadingOnRefresh,
        skipLoadingOnReload: skipLoadingOnReload,
        data: data,
        error: error ??
            (e, s) => AsyncErrorWidget(
                  error: e,
                  stackTrace: s,
                  debugPrintErrors: debugPrintErrors,
                ),
        loading: loading ?? () => const AsyncLoadingWidget(),
      );

  /// Builds a sliver for this async value with sensible default widgets for
  /// loading and error states, as well as a [data] callback for whatever is
  /// built when this AsyncValue is loaded.
  ///
  /// If [debugPrintErrors] is true (default), errors are printed to the console.
  Widget buildSliver({
    required Widget Function(T data) data,
    LoadingBuilder? loading,
    ErrorBuilder? error,
    bool debugPrintErrors = true,
    bool skipLoadingOnRefresh = true,
    bool skipLoadingOnReload = true,
  }) =>
      when(
        data: data,
        skipLoadingOnRefresh: skipLoadingOnRefresh,
        skipLoadingOnReload: skipLoadingOnReload,
        error: error ??
            (e, s) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: AsyncErrorWidget(
                    error: e,
                    stackTrace: s,
                    debugPrintErrors: debugPrintErrors,
                  ),
                ),
        loading: loading ??
            () => const SliverFillRemaining(
                  child: AsyncLoadingWidget(),
                ),
      );
}

class AsyncLoadingWidget extends StatelessWidget {
  const AsyncLoadingWidget({
    super.key,
    this.progress,
    this.description,
  });

  final double? progress;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacers.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(
              value: progress,
            ),
            const VSpace.xs(),
            if (description != null)
              DefaultTextStyle(
                style: theme.textTheme.labelMedium ??
                    DefaultTextStyle.of(context).style,
                textAlign: TextAlign.center,
                child: description!,
              ),
          ],
        ),
      ),
    );
  }
}

class AsyncErrorWidget extends HookConsumerWidget {
  const AsyncErrorWidget({
    super.key,
    this.error,
    this.stackTrace,
    this.debugPrintErrors = true,
    this.text,
  });

  final String? text;

  final Object? error;
  final StackTrace? stackTrace;

  final bool debugPrintErrors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        if (debugPrintErrors && (error != null || stackTrace != null)) {
          debugPrint("Error caught by AsyncErrorWidget:");
          debugPrint(error.toString());
          if (stackTrace != null) {
            debugPrintStack(stackTrace: stackTrace);
          }
        }
        return null;
      },
      [debugPrintErrors],
    );
    return text == null
        ? const Center(
            child: Icon(Icons.error_rounded),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_rounded),
                const VSpace.s(),
                Text(text!),
              ],
            ),
          );
  }
}
