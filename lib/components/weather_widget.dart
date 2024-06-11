import 'dart:async';

import 'package:farmind/components/weather_data.dart';
import 'package:farmind/components/weather_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'weather_services.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final _weatherService = WeatherServices('YOURAPIKEY');
  late WeatherData weatherInfo;
  bool isLoading = true;
  String errorMessage = '';
  Position? _currentPosition;
  late Timer _timer;
  String formattedDate = '';
  String formattedTime = '';

  _fetchWeather() async {
    var permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final weather = await _weatherService.getWeatherByCoordinates(position.latitude, position.longitude);
        setState(() {
          weatherInfo = weather;
          _currentPosition = position;
          isLoading = false;
          errorMessage = '';
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Hava durumu bilgisi alınamadı: ${e.toString()}';
          isLoading = false;
        });
      }
    } else {
      setState(() {
        errorMessage = 'Konum izni reddedildi';
        isLoading = false;
      });
    }
  }

  void _updateDateTime() {
    var now = DateTime.now();
    setState(() {
      formattedDate = DateFormat('EEEE d, MMMM yyyy', 'tr').format(now);
      formattedTime = DateFormat('HH:mm', 'tr').format(now);
    });
  }

  @override
  void initState() {
    super.initState();
    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0.0),
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
      date: '',
      icon: '',
      main: '',
      description: '',
    );
    _fetchWeather();
    _updateDateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Center(
            child: isLoading
                ? SizedBox(
              width: 360,
              height: 310,
              child: Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            )
                : errorMessage.isNotEmpty
                ? SizedBox(
              width: 360,
              height: 310,
              child: Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
                : WeatherDetail(
              weather: weatherInfo,
              formattedDate: formattedDate,
              formattedTime: formattedTime,
              currentPosition: _currentPosition,
            ),
          ),
        ],
      ),
    );
  }
}