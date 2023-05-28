import 'package:flutter/material.dart';

class CustomInputTheme {
  InputDecorationTheme call() {
    return const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white38),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}
