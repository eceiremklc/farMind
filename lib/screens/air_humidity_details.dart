import 'package:farmind/components/air_humidity_chart.dart';
import 'package:farmind/styles/detail_styles.dart';
import 'package:flutter/material.dart';
import '../components/navbar.dart';

class AirHumidityDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFECE9),
      appBar: AppBar(
        title: Text(
            'Hava Nemi Ölçümleri',
          style: DetailStyles.header,
        ),
        backgroundColor: const Color(0xFFEFECE9),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFFDFE4DD),
                borderRadius: BorderRadius.circular(25),
              ),
              child: AirHumidityChart(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}