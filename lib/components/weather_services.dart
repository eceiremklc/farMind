import 'dart:convert';
import 'package:farmind/components/weather_data.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices(this.apiKey);

  Future<WeatherData> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$apiUrl?q=$cityName&appid=$apiKey&units=metric&lang=tr'),
    );


    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return WeatherData.fromJson(json);
    } else {
      throw Exception('Hava durumu verisi yüklenirken bir hata oluştu. Status Code: ${response.statusCode}');
    }
  }

  Future<WeatherData> getWeatherByCoordinates(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=tr'),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return WeatherData.fromJson(json);
    } else {
      throw Exception('Hava durumu verisi yüklenirken bir hata oluştu. Status Code: ${response.statusCode}');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
