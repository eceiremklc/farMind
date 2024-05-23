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
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['name'] ?? 'Unknown',
      temperature: Temperature.fromJson(json['main']),
      humidity: json['main']['humidity'] ?? 0,
      wind: Wind.fromJson(json['wind']),
      maxTemperature: (json['main']['temp_max'] ?? 0.0).toDouble(),
      minTemperature: (json['main']['temp_min'] ?? 0.0).toDouble(),
      pressure: json['main']['pressure'] ?? 0,
      seaLevel: json['main']['sea_level'] ?? 0,
      weather: List<WeatherInfo>.from(
        (json['weather'] ?? []).map((weather) => WeatherInfo.fromJson(weather)),
      ),
    );
  }
}

class WeatherInfo {
  final String main;
  final String? icon;
  final String? description;

  WeatherInfo({required this.main, required this.icon, required this.description});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'] ?? 'Unknown',
      icon: json['icon'] ?? '01d',
      description: json['description'] ?? 'Unknown',
    );
  }
}

class Temperature {
  final double current;

  Temperature({required this.current});

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
