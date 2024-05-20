import 'package:flutter/material.dart';

class StartStyles {
  static TextStyle get start_title => TextStyle(
    color: Colors.white,
    fontFamily: 'Cooper',
    fontSize: 48,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 4,
        offset: Offset(0,4),
      )
    ],
  );

}