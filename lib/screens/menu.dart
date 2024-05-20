import 'package:farmind/components/menu_components.dart';
import 'package:farmind/components/navbar.dart';
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
              MenuComponents.weather,
              SizedBox(height: 15,),
              MenuComponents.sicaklik_nem,
              SizedBox(height: 15,),
              MenuComponents.humidity,
              SizedBox(height: 15,),
              MenuComponents.water_level,
              SizedBox(height: 15,),
              MenuComponents.watering,
              SizedBox(height: 15,),
              MenuComponents.plant_recognition,
              SizedBox(height: 15,),
              MenuComponents.notes,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}