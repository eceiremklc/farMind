import 'package:flutter/material.dart';

class LoginComponents{

  static InputDecoration email() {
    return InputDecoration(
      hintText: 'E-mail',
      hintStyle: TextStyle(
        fontFamily: 'Nunito', // Hint metnin fontu
        fontSize: 20, // Hint metnin font boyutu
        fontWeight: FontWeight.normal, // Hint metnin font ağırlığı
        color: const Color(0xFF12492F), // Hint metnin rengi
      ),
      filled: true,
      fillColor: const Color(0xFFD1CEC5),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFFD1CEC5),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFFD1CEC5),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  static InputDecoration sifre() {
    return InputDecoration(
      hintText: 'Şifre',
      hintStyle: TextStyle(
        fontFamily: 'Nunito', // Hint metnin fontu
        fontSize: 20, // Hint metnin font boyutu
        fontWeight: FontWeight.normal, // Hint metnin font ağırlığı
        color: const Color(0xFF12492F), // Hint metnin rengi
      ),
      filled: true,
      fillColor: const Color(0xFFD1CEC5),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFFD1CEC5),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFFD1CEC5),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

}