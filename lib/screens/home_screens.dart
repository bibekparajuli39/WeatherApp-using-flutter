import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  bool _isloading = false;
  final TextEditingController _controller = TextEditingController();
  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isloading = true;
    });
    try {
      final weather = await _weatherServices.fetchWeather(_controller.text);
      setState(() {
        _weather = weather;
        _isloading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("error fetching weather data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Weather App"),
                SizedBox(height: 25),
                // take a text from user and aslo show hint text so user understand
                TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter a city",
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 125, 122, 122),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    _getWeather();
                  },
                  child: Text("Get a weather"),
                ),
                if (_isloading)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
