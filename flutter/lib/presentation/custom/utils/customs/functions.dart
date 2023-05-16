import 'package:flutter/material.dart';
import 'package:firebase_auth_demo/general/text.dart';

class CustomFunctions {
  static void showCustomSnackBar(
    Color? color, {
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CustomText(
            content,
            color: Colors.white,
            size: 14,
            weight: FontWeight.w400,
          ),
        ),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
