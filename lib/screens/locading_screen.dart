// ignore_for_file: use_build_context_synchronously
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:sky_wave/constants/colors.dart';
import '/model/current_weather_model.dart';
import '/screens/home.dart';
import '/model/weather_forecast_model.dart';
import '/services/location.dart';
import '/services/networking.dart';
import '/constants/weather_api.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  // initState() method is called when the widget is inserted into the widget tree for the first time.
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // Create an object from Location class and call getCurrentLocation() method
    Location location = Location();
    await location.getCurrentLocation();

    // Create an object from NetworkHelper class and call getData() method to get the weather data
    NetworkHelper networkHelper = NetworkHelper(
      url:
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric',
    );
    // https://api.openweathermap.org/data/3.0/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric

    var weatherData = await networkHelper.getData();

    if (weatherData != 0) {
      CurrentWeatherModel.cityName = weatherData['name'];
      CurrentWeatherModel.country = weatherData['sys']['country'];
      CurrentWeatherModel.temperature = weatherData['main']['temp'].toInt();
      CurrentWeatherModel.mainWeather = weatherData['weather'][0]['main'];
      CurrentWeatherModel.weatherDescription = weatherData['weather'][0]['description'];
      CurrentWeatherModel.windSpeed = weatherData['wind']['speed'];
      CurrentWeatherModel.weatherIcon = weatherData['weather'][0]['icon'];
      CurrentWeatherModel.humidity = weatherData['main']['humidity'];
      CurrentWeatherModel.pressure = weatherData['main']['pressure'];
      CurrentWeatherModel.cloud = weatherData['clouds']['all'];
      CurrentWeatherModel.feelsLike = weatherData['main']['feels_like'];
      CurrentWeatherModel.tempMin = weatherData['main']['temp_min'];
      CurrentWeatherModel.tempMax = weatherData['main']['temp_max'];
      CurrentWeatherModel.visibility = weatherData['visibility'];
      CurrentWeatherModel.sunrise = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise'] * 1000);
      CurrentWeatherModel.sunset = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset'] * 1000);
      CurrentWeatherModel.date = DateFormat("MMM d yyyy").format(DateTime.now());
      CurrentWeatherModel.condition = weatherData['weather'][0]['id'];

      // Create an object from NetworkHelper class and call getData() method to get the weather forecast data
      NetworkHelper networkHelperForecast = NetworkHelper(
          url:
          'https://api.openweathermap.org/data/3.0/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');
      var weatherDataForecast = await networkHelperForecast.getData();

      // Create an object from WeatherForecast class and pass the weather forecast data to it
      WeatherForecast.daily = weatherDataForecast['daily'];
      WeatherForecast.hourly = weatherDataForecast['hourly'];

      // Navigate to LocationScreen and pass the weather data to it
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const WeatherHome();
      }));

    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message:
          'Something went wrong. Please check your internet connection and try again.',

          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitFoldingCube(
        color: kDark,
        size: 100.0,
      )),
    );
  }
}
