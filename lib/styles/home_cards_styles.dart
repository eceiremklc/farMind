import 'package:flutter/material.dart';

class HomeCardsStyles {
  static TextStyle get card_header => TextStyle(
        fontFamily: 'Nunito',
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF075571),
      );

  static TextStyle get card_data => TextStyle(
        fontFamily: 'Nunito',
        fontSize: 35,
        color: const Color(0xFF075571),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get card_time => TextStyle(
        fontFamily: 'Nunito',
        fontSize: 12,
        color: const Color(0xFF075571),
      );

  static TextStyle get last_watering_header => TextStyle(
        fontFamily: 'Nunito',
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static TextStyle get last_watering_time => TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle get weather_city => TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontFamily: "Nunito",
        fontWeight: FontWeight.w700,
      );

  static TextStyle get weather_value => TextStyle(
        fontSize: 40,
        fontFamily: "Nunito",
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get weather_time => TextStyle(
        fontSize: 12,
        fontFamily: "Nunito",
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get weather_description => TextStyle(
        fontSize: 12,
        fontFamily: "Nunito",
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  static BoxShadow get card_shadow => BoxShadow(
        color: Colors.grey.withOpacity(0.8),
        blurRadius: 4,
        offset: Offset(0, 2),
      );
}
