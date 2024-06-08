import 'package:farmind/components/menu_components.dart';
import 'package:farmind/components/navbar.dart';
import 'package:farmind/components/watering_switch.dart';
import 'package:farmind/screens/recognize_plant.dart';
import 'package:farmind/screens/soil_humidity_details.dart';
import 'package:farmind/screens/temperature_details.dart';
import 'package:farmind/screens/water_tank_details.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //MenuComponents.weather(context, WeatherScreen),
              //SizedBox(height: 25,),
              MenuComponents.sicaklik(context, TemperatureDetails()),
              SizedBox(height: 25,),
              MenuComponents.humidity(context, SoilHumidityDetails()),
              SizedBox(height: 25,),
              MenuComponents.waterLevel(context, WaterTankDetails()),
              SizedBox(height: 25,),
              MenuComponents.watering(context, WateringSwitch()),
              SizedBox(height: 25,),
              MenuComponents.recognizePlant(context, RecognizePlant()),
              SizedBox(height: 25,),
              //MenuComponents.notes,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}