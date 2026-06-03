class Weather {
  final String cityname;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final int sunrise;
  final int sunset;
// constructor of class
  Weather({
    required this.cityname,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.sunrise,
    required this.sunset,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityname: json['name'],
      temperature: json['main']['temp'] - 273.15,
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      description: json['weather'][0]['description'],
    );
  }
}
