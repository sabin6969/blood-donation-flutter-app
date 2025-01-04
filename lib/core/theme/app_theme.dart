import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightModeTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Poppins",
    tabBarTheme: const TabBarTheme(
      indicatorColor: Colors.purple,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.only(
        bottom: 10,
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.red.shade400,
      titleTextStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  static ThemeData darkModeTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
