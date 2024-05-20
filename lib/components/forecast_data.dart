import 'package:flutter/material.dart';
import 'weather_services.dart';

class ForecastData {
  final String day;
  final double maxTemp;
  final double minTemp;
  final String weatherDescription;

  ForecastData({
    required this.day,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherDescription,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      day: json['dt_txt'].split(' ')[0], // tarihi "2024-05-21" formatına dönüştür
      maxTemp: json['main']['temp_max'].toDouble(),
      minTemp: json['main']['temp_min'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
    );
  }
}
