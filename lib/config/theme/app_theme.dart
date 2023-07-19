import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF2862F5);

const List<Color> colorList = [
  _customColor,
  Colors.blue,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  }) : assert(
          selectedColor >= 0 && selectedColor <= colorList.length - 1,
          'Selected Color Must be between 0 and ${colorList.length - 1}',
        );

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
      );
}
