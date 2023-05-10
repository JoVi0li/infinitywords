import 'package:flutter/material.dart';

class CustomTextTheme {
  TextTheme call() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'IBMPlexMono',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        fontSize: 36,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'IBMPlexMono',
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 20,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'IBMPlexMono',
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontFamily: 'IBMPlexMono',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }
}
