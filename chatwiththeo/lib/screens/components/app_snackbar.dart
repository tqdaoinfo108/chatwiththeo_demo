import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SnackbarHelper {
  const SnackbarHelper._();

  static final _key = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get key => _key;

  static void showSnackBar(String? message, ToastificationType type) =>
      toastification.show(
        title: Text(message ?? "", style: AppTheme.titleMedium.copyWith(color: Colors.black87)),
        type: type,
        autoCloseDuration: const Duration(seconds: 5),
      );
}
