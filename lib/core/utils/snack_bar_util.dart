import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';

class SnackBarUtil {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: context.textStyle14.copyWith(color: Colors.white)),
      backgroundColor: Colors.red,
    ));
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: context.textStyle14.copyWith(color: Colors.white)),
      backgroundColor: Colors.green,
    ));
  }
}
