import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather_model.dart';

class WeatherServices {
  //apikey where data is in it
  final String apikey = '23b9375efae0a796d7fb1bb64519deff';
  Future<Weather> fetchWeather(String cityname) async {
    //url link that cityname and apikey will be take from user
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey',
    );
    //making http get request
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load');
    }
  }
}
