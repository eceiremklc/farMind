import 'package:farmind/components/weather_data.dart';
import 'package:farmind/styles/home_cards_styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
    // Null güvenliği için kontrol ekliyoruz
    String iconCode =
        weather.weather.isNotEmpty ? weather.weather[0].icon ?? '01d' : '01d';
    String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';
    String cityName = weather.name.isNotEmpty ? weather.name : "yükleniyor..";
    String temperature = weather.temperature.current != null
        ? "${weather.temperature.current!.round()}°C"
        : "N/A";
    String description = weather.weather.isNotEmpty
        ? weather.weather[0].description ?? "Bilgi bulunamadı"
        : "Bilgi bulunamadı";

    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      width: 358,
      height: 260,
      decoration: BoxDecoration(
        color: const Color(0xFF33BEC3),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          HomeCardsStyles.card_shadow,
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              cityName,
              style: HomeCardsStyles.weather_city,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 43,),
                Text(temperature, style: HomeCardsStyles.weather_value),
                SizedBox(width: 44),
                Column(
                  children: [
                    Image.network(
                      iconUrl,
                      width: 70,
                      height: 70,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, color: Colors.red, size: 50);
                      },
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        '$description',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: HomeCardsStyles.weather_description,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: HomeCardsStyles.weather_time,
                ),
                SizedBox(width: 30,),
                Text(
                  formattedTime,
                  style: HomeCardsStyles.weather_time,
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
