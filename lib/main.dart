import 'package:flutter/material.dart';
import 'package:sky_wave/screens/locading_screen.dart';

void main() {
  runApp(const Weather());
}

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sky Wave',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

