import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});
  String formatTime(int timestemp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestemp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 114, 190, 237),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // asset for weather
              Lottie.asset(
                weather.description.contains('rain')
                    ? 'assets/rain.json'
                    : weather.description.contains('clear')
                    ? 'assets/sunny.json'
                    : 'assets/cloudy.json',

                height: 150,
                width: 150,
              ),
              //it show the name that user give input in input field
              Text(
                weather.cityname,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 5),
              // it shows the temperatue of city that comes from api
              Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //it shows humidity of cityname that come from api
                  Text(
                    'Humidity: ${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 10),
                  // it shows windspeed
                  Text(
                    'Wind ${weather.windSpeed}m/s',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      //it shows icon widget
                      Icon(Icons.wb_sunny_outlined, color: Colors.orange),

                      Text(
                        'Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 10),
                      // it shows time in format 'hh/mm a'
                      Text(
                        formatTime(weather.sunrise),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(Icons.nights_stay_outlined, color: Colors.purple),
                      Text(
                        'Sunset',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formatTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
