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
              SizedBox(height: 25,),
              MenuComponents.sicaklik_nem,
              SizedBox(height: 25,),
              MenuComponents.humidity,
              SizedBox(height: 25,),
              MenuComponents.water_level,
              SizedBox(height: 25,),
              MenuComponents.watering,
              SizedBox(height: 25,),
              MenuComponents.notes,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}