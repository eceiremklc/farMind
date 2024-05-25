// forecast_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'weather_services.dart';
import 'weather_data.dart';

class ForecastWidget extends StatefulWidget {
  @override
  _ForecastWidgetState createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget> {
  final _weatherService = WeatherServices('4389978ee584532a83ec2b5233bc4050');
  late List<WeatherData> forecastData;
  bool isLoading = true;
  String errorMessage = '';

  _fetchForecast() async {
    setState(() {
      isLoading = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final forecast = await _weatherService.get5DayForecastByCoordinates(position.latitude, position.longitude);

      // Tahminleri günlere göre filtreleme
      Set<String> dates = Set(); // Her bir günün tarihini saklamak için bir set
      List<WeatherData> filteredForecast = [];

      for (var weather in forecast) {
        String date = weather.date.substring(0, 10); // Yalnızca tarihi al
        if (!dates.contains(date)) {
          // Eğer bu tarih daha önce eklenmediyse, tahmini ekle ve sete ekle
          filteredForecast.add(weather);
          dates.add(date);
        }
        // Beş günlük tahmini aştıysak döngüden çık
        if (filteredForecast.length >= 5) break;
      }

      setState(() {
        forecastData = filteredForecast;
        isLoading = false;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        errorMessage = '5 günlük hava durumu bilgisi alınamadı: ${e.toString()}';
        isLoading = false;
      });
    }
  }



  @override
  void initState() {
    super.initState();
    forecastData = [];
    _fetchForecast();
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
                ? const CircularProgressIndicator(color: Colors.black)
                : errorMessage.isNotEmpty
                ? Text(errorMessage, style: const TextStyle(color: Colors.red))
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: forecastData.map((weather) {
                return ForecastCard(weather: weather);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ForecastCard extends StatelessWidget {
  final WeatherData weather;

  ForecastCard({required this.weather});

  // Verilen tarihteki günün Türkçe adını döndüren yardımcı fonksiyon
  String _getTurkishDayName(String date) {
    final weekdayNames = [
      'Pzt',
      'Salı',
      'Çrş',
      'Prş',
      'Cuma',
      'Cmt',
      'Paz',
    ];
    final dateTime = DateTime.parse(date);
    return weekdayNames[dateTime.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 130,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white.withOpacity(0.4),
      ),
      child: Column(
        children: [
          Text(
            _getTurkishDayName(weather.date), // Türkçe gün ismi alınıyor
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
          Image.network('http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
          Text('${weather.temperature}°C',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 13.5,
            ),
          ),
          // Null güvenliği ekleyerek description'ı kontrol edin
          SizedBox(height: 2,),
          Text('${weather.description ?? ''}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 9,
                fontFamily: 'Nunito',
              ),
          ),
        ],
      ),
    );
  }
}
