import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static showToastMessage({
    required String message,
    ToastGravity? position = ToastGravity.BOTTOM,
  }) {
    if (message.isNotEmpty) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: position,
        backgroundColor: const Color(0xFF656565),
      );
    }
  }
}
