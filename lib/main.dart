// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_flutter2/weather_display_view.dart';

void main() {
  runApp(MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: InputLocationView(),
    );
  }
}

class InputLocationView extends StatelessWidget {
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Set input',
              style: TextStyle(fontSize: 32),
            ),
            backgroundColor: Colors.white,
            border: null,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 32.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Icon(
                      CupertinoIcons.sun_max_fill,
                      size: 250,
                      color: CupertinoColors.systemYellow,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Latitude:'),
                  ),
                  CupertinoTextField(
                    controller: latController,
                    placeholder: 'XX.XXXX',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Longitude:'),
                  ),
                  CupertinoTextField(
                    controller: lonController,
                    placeholder: 'XX.XXXX',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      String lat = latController.text;
                      String lon = lonController.text;
                      // Navigate to weather display view after fetching weather data
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => WeatherDisplayView(
                            latitude: lat,
                            longitude: lon,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ),
                  ),
                  SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
