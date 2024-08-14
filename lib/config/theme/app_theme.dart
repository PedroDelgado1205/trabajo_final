import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];
class AppTheme {
  final int selectedColor;

  AppTheme(
    {this.selectedColor = 5}
    ):assert( selectedColor >= 0, 'Selected color must be greater then 0' ),  
      assert( selectedColor < colorList.length, 
        'Selected color must be less or equal than ${ colorList.length - 1 }');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: colorList[ selectedColor ],
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Color(0xFF919191)),
          bodyMedium: TextStyle(color: Colors.cyan),
          bodySmall: TextStyle(color: Color.fromRGBO(0, 113, 128, 1)),
        ),
      );
}
