import 'package:flutter/material.dart';

class WateringSwitch extends StatefulWidget {
  @override
  _WateringSwitchState createState() => _WateringSwitchState();
}

class _WateringSwitchState extends State<WateringSwitch> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Örneği'),
      ),
      body: Center(
        child: Switch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
          materialTapTargetSize: MaterialTapTargetSize.padded, // Dokunma alanı boyutunu artırır
          thumbColor: MaterialStateProperty.all<Color>(Colors.white), // Yuvarlak parçacığın rengi
          trackColor: MaterialStateProperty.all<Color>(Colors.grey[300]!), // Switch'in arkasındaki iz rengi
          activeTrackColor: Colors.blue, // Açık durumda switch'in rengi
          activeColor: Colors.blueAccent, // Açık durumda switch'in yuvarlak parçacığının rengi
        ),
      ),
    );
  }
}