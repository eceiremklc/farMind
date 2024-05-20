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
  bool isLoading = false;
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
          isLoading = true;
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
    );
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE d, MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Center(
            child: isLoading
                ? WeatherDetail(
              weather: weatherInfo,
              formattedDate: formattedDate,
              formattedTime: formattedTime,
              currentPosition: _currentPosition,
            )
                : errorMessage.isNotEmpty
                ? Text(errorMessage, style: TextStyle(color: Colors.red))
                : const CircularProgressIndicator(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

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
          const SizedBox(height: 10),
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
