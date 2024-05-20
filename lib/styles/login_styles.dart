import 'package:flutter/material.dart';

class LoginStyles {
  static TextStyle get login_title => TextStyle(
    color: const Color(0xFF12492F),
    fontFamily: 'Nunito',
    fontSize: 40,
    fontWeight: FontWeight.w900,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 4,
        offset: Offset(0,4),
      )
    ],
  );

  static TextStyle get button_text => TextStyle(
    color: const Color(0xFFEFECE9),
    fontFamily: 'Nunito',
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static ButtonStyle get login_button => ButtonStyle(
    backgroundColor:  MaterialStateProperty.all<Color>(const Color(0xFF12492F)),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (Set<MaterialState> states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        );
      },
    ),
  );

  static TextStyle get tb_style => TextStyle(
    color: const Color(0xFF12492F),
    fontFamily: 'Nunito',
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );
}