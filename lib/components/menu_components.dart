import 'package:flutter/material.dart';
class MenuComponents{
  static Container get weather => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: (){

      },
      icon: Icon(
          Icons.sunny,
          color: Colors.white,
      ),
      label: Text(
          'Hava Durumu',
          style: TextStyle(
          fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
      ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFBDD664)),
      ),
    ),
  );

  static Container get sicaklik_nem => Container(
    width: 340,
    height: 60,
    child: ElevatedButton(
      onPressed: (){

      },
      child: Text(
        'Sıcaklık ve Nem Ölçümleri',
        style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF8CC462)),
      ),
    ),
  );

  static Container get humidity => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: (){

      },
      icon: Icon(
        Icons.water_drop,
        color: Colors.white,
      ),
      label: Text(
        'Toprak Nemi Ölçümleri',
        style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF5CB063)),
      ),
    ),
  );

  static Container get water_level => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: (){

      },
      icon: Icon(
        Icons.water,
        color: Colors.white,
      ),
      label: Text(
        'Sulama Deposu',
        style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF229B64)),
      ),
    ),
  );

  static Container get watering => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: (){

      },
      icon: Icon(
        Icons.opacity,
        color: Colors.white,
      ),
      label: Text(
        'Sulama',
        style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF008564)),
      ),
    ),
  );

  static Container get notes => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: (){

      },
      icon: Icon(
        Icons.sticky_note_2_sharp,
        color: Colors.white,
      ),
      label: Text(
        'Notlar',
        style: TextStyle(
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF00594e)),
      ),
    ),
  );
}