import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/temperature_chart.dart';
import '../styles/detail_styles.dart';

class TemperatureDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFECE9),
      appBar: AppBar(
        title: Text(
          'Sıcaklık Ölçümleri',
          style: DetailStyles.header,
        ),
        backgroundColor: const Color(0xFFEFECE9),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFDFE4DD),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TemperatureChart(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
