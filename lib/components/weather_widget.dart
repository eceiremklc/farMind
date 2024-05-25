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
  final _weatherService = WeatherServices('4389978ee584532a83ec2b5233bc4050');
  late WeatherData weatherInfo;
  bool isLoading = true;
  String errorMessage = '';
  Position? _currentPosition;

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
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE d, MMMM yyyy', 'tr').format(now);
    var formattedTime = DateFormat('HH:mm', 'tr').format(now);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Center(
            child: isLoading
                ? CircularProgressIndicator(color: Colors.black)
                : errorMessage.isNotEmpty
                ? Text(errorMessage, style: TextStyle(color: Colors.red))
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
