import 'package:flutter/material.dart';

class Customicons extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget? icon;
  final bool obscureText;

  const Customicons({
    Key? key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
