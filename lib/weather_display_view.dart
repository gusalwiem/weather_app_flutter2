//53b6222b974d4277240d894c4b77f998

// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WeatherDisplayView extends StatefulWidget {
  final String latitude;
  final String longitude;

  WeatherDisplayView({required this.latitude, required this.longitude});

  @override
  _WeatherDisplayViewState createState() => _WeatherDisplayViewState();
}

class _WeatherDisplayViewState extends State<WeatherDisplayView> {
  String city = 'City Loading...';
  String description = 'Loading...';
  double temp = 0.0;
  double tempMin = 0.0;
  double tempMax = 0.0;
  String icon = 'sparkles';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      final String apiKey =
          '53b6222b974d4277240d894c4b77f998'; // Replace 'YOUR_API_KEY' with your API key
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${widget.latitude}&lon=${widget.longitude}&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));
      final decodedResponse = json.decode(response.body);

      setState(() {
        city = decodedResponse['name'];
        description = _capitalizeDescription(
            decodedResponse['weather'][0]['description']);
        temp = decodedResponse['main']['temp'];
        tempMin = decodedResponse['main']['temp_min'];
        tempMax = decodedResponse['main']['temp_max'];
        icon = decodedResponse['weather'][0]['icon'];
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  String _capitalizeDescription(String description) {
    List<String> words = description.split(' ');
    List<String> capitalizedWords =
        words.map((word) => word.capitalize()).toList();
    return capitalizedWords.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 157, 206, 241),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 157, 206, 241),
        border: null,
        middle: Text(''),
        previousPageTitle: 'Set input',
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$city',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  _getIconData(),
                  size: 250,
                  color: _getIconColor(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                '${temp.round()}°C',
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '$description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, //AUTHOR changed this back
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Min',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                        Text(
                          '${tempMin.round()}°C',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Max',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                        Text(
                          '${tempMax.round()}°C',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData() {
    switch (icon) {
      case '01d':
        return CupertinoIcons.sun_max_fill;
      case '01n':
        return CupertinoIcons.moon_zzz_fill;
      case '02d':
        return CupertinoIcons.cloud_sun_fill;
      case '02n':
        return CupertinoIcons.cloud_moon_fill;
      case '03d':
      case '03n':
        return CupertinoIcons.cloud_fill;
      case '04d':
      case '04n':
        return CupertinoIcons.smoke_fill;
      case '09d':
      case '09n':
        return CupertinoIcons.cloud_rain_fill;
      case '10d':
        return CupertinoIcons.cloud_sun_rain_fill;
      case '10n':
        return CupertinoIcons.cloud_moon_rain_fill;
      case '11d':
      case '11n':
        return CupertinoIcons.cloud_bolt_fill;
      case '13d':
      case '13n':
        return CupertinoIcons.cloud_snow_fill;
      case '50d':
      case '50n':
        return CupertinoIcons.wind;
      default:
        return CupertinoIcons.sparkles;
    }
  }

  Color _getIconColor() {
    switch (icon) {
      case '01d':
      case 'sparkles':
        return CupertinoColors.systemYellow;
      case '01n':
        return CupertinoColors.systemGrey;
      default:
        return CupertinoColors.white;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
