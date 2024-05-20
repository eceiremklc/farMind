import 'package:farmind/components/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'weather_services.dart';

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;
  final Position? currentPosition;

  const WeatherDetail({
    Key? key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
    required this.currentPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 230,
      decoration: BoxDecoration(
        color: const Color(0xFFBDD664),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            weather.name.isNotEmpty ? weather.name : "yükleniyor..",
            style: const TextStyle(
              fontSize: 25,
              color: Color(0xFF12492F),
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${weather.temperature.current.round()}°C",
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: "Nunito",
                  color: Color(0xFF12492F),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Nunito",
              color: Color(0xFF12492F),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            formattedTime,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Nunito",
              color: Color(0xFF12492F),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
