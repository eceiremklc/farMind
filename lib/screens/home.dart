import 'package:farmind/components/humidity_card.dart';
import 'package:farmind/components/temperature_card.dart';
import 'package:farmind/components/weather_services.dart';
import 'package:farmind/components/weather_widget.dart';
import 'package:flutter/material.dart';

import '../components/navbar.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WeatherWidget(),
             SizedBox(height: 9),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 HumidityCard(),
                 SizedBox(width: 20,),
                 TemperatureCard()
               ],
             )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}