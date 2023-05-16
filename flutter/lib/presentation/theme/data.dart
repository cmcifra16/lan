import 'package:flutter/material.dart';

class CustomThemeData {
  static ThemeData themeData() {
    return ThemeData(
      brightness: Brightness.light,
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
    );
  }
}
