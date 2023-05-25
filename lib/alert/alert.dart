import 'package:flutter/material.dart';

class AlertScreen {
  static final snackBarKey = GlobalKey<ScaffoldMessengerState>();
  static alert(String text) {
    final snackBar = SnackBar(
        shape: const StadiumBorder(),
        content: Text(text, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 100));
    snackBarKey.currentState!.showSnackBar(snackBar);
  }
}
