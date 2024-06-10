import 'package:flutter/material.dart';
import 'package:farmind/screens/temperature_details.dart';

class MenuComponents {
  static Container air_humidity(BuildContext context, Widget targetScreen) => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      icon: Icon(
        Icons.water_drop_outlined,
        color: Colors.white,
      ),
      label: Text(
        'Hava Nemi Ölçümleri',
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFBDD664)),
      ),
    ),
  );

  static Container sicaklik(BuildContext context, Widget targetScreen) => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      icon: Icon(
        Icons.sunny,
        color: Colors.white,
      ),
      label: Text(
        'Hava Sıcaklığı Ölçümleri',
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF8CC462)),
      ),
    ),
  );

  static Container recognizePlant(BuildContext context, Widget targetScreen) => Container(
    width: 340,
    height: 60,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Text(
        'Bitkinizi Tanıyın',
        style: TextStyle(
          fontFamily: "Nunito",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF006a50)),
      ),
    ),
  );

  static Container humidity(BuildContext context, Widget targetScreen) => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
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
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF5CB063)),
      ),
    ),
  );

  static Container waterLevel(BuildContext context, Widget targetScreen) => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
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
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF229B64)),
      ),
    ),
  );

  static Container watering(BuildContext context, Widget targetScreen) => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
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
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF008564)),
      ),
    ),
  );

  static Container notes(BuildContext context, Widget targetScreen) => Container(
    width: 340,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
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
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF00594e)),
      ),
    ),
  );
}
