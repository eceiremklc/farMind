import 'package:flutter/material.dart';

class SignUpStyles {
  static TextStyle get kayit_text => TextStyle(
    fontFamily: 'Nunito',
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: const Color(0xFFEFECE9),
  );

  static ButtonStyle get kayit_button => ButtonStyle(
    backgroundColor:  MaterialStateProperty.all<Color>(const Color(0xFF12492F)),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (Set<MaterialState> states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        );
      },
    ),
  );

  static TextStyle get t_button => TextStyle(
    fontFamily: 'Nunito',
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: const Color(0xFF12492F),
  );
}