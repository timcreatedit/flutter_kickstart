import 'package:flutter/material.dart';

mixin ShowableDialogMixin<T> on Widget {
  Future<T?> show(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) => this,
    );
  }
}
