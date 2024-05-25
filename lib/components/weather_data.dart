class WeatherData {
  final String name;
  final Temperature temperature;
  final int humidity;
  final Wind wind;
  final double maxTemperature;
  final double minTemperature;
  final int pressure;
  final int seaLevel;
  final List<WeatherInfo> weather;
  final String date;
  final String icon;
  final String main;
  final String description;

  WeatherData({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
    required this.seaLevel,
    required this.weather,
    required this.date,
    required this.icon,
    required this.main,
    required this.description,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['name'] ?? 'Unknown',
      date: json['dt_txt'] ?? '',
      temperature: Temperature.fromJson(json['main']),
      humidity: json['main']['humidity'] ?? 0,
      wind: Wind.fromJson(json['wind']),
      maxTemperature: (json['main']['temp_max'] ?? 0.0).toDouble(),
      minTemperature: (json['main']['temp_min'] ?? 0.0).toDouble(),
      pressure: json['main']['pressure'] ?? 0,
      seaLevel: json['main']['sea_level'] ?? 0,
      icon: json['weather'][0]['icon'] ?? '01d',
      main: json['weather'][0]['main'] ?? 'Unknown',
      description: json['weather'][0]['description'] ?? 'Unknown',
      weather: List<WeatherInfo>.from(
        (json['weather'] ?? []).map((weather) => WeatherInfo.fromJson(weather)),
      ),
    );
  }
}

class WeatherInfo {
  final String? main;
  final String? icon;
  final String? date;
  final String? description;

  WeatherInfo({required this.main, required this.icon, required this.date, required this.description});

  @override
  String toString() {
    return main ?? 'Unknown';
  }

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'] ?? 'Unknown',
      icon: json['icon'] ?? '01d',
      date: json['dt_txt'] ?? '',
      description: json['desription'] ?? '',
    );
  }
}

class Temperature {
  final double current;

  Temperature({required this.current});

  @override
  String toString() {
    return '${current.round()}';
  }

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      current: (json['temp'] ?? 0.0).toDouble(),
    );
  }
}

class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] ?? 0.0).toDouble(),
    );
  }
}
