import 'package:farmind/components/air_humidity_chart.dart';
import 'package:flutter/material.dart';
import '../components/navbar.dart';

class AirHumidityDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Su Deposu Doluluk Oranı'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 250,
              child: AirHumidityChart(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}