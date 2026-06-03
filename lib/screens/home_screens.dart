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
  // fetch a data from api based on user input
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
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("error fetching weather data"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Search for a city/country",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
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
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 45, 52, 236),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _getWeather();
                  },
                  child: Text(
                    "Get a weather",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                if (_isloading)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                      color: const Color.fromARGB(255, 255, 0, 0),
                    ),
                  ),
                if (_weather != null)
                  WeatherCard(weather: _weather!)
                else
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      " ${_controller.text.isEmpty ? 'Enter a city name' : 'No weather data available'}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
