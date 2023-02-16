import 'package:flutter/material.dart';
import 'package:flutter_kickstart/core/hooks/use_l10n.hook.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
      ),
    );
  }
}
