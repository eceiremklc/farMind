import 'package:farmind/components/air_humidity.dart';
import 'package:farmind/components/humidity_card.dart';
import 'package:farmind/components/temperature_card.dart';
import 'package:farmind/components/water_tank.dart';
import 'package:farmind/components/watering_card.dart';
import 'package:farmind/components/watering_switch.dart';
import 'package:farmind/components/weather_services.dart';
import 'package:farmind/components/weather_widget.dart';
import 'package:flutter/material.dart';

import '../components/navbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FFF0),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WeatherWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HumidityCard(),
                      WaterTank(),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TemperatureCard(),
                      AirHumidity(),
                    ],
                  ),
                  SizedBox(height: 8),
                  WateringCard(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Navbar(),
          ),
        ],
      ),
    );
  }
}
