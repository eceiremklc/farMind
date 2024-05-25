import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/soil_humidity_chart.dart';

class SoilHumidityDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toprak Nemi Ölçümleri'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 250,
              child: SoilHumidityChart(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}