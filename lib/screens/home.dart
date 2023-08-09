// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:sky_wave/model/current_weather_model.dart';
import 'package:sky_wave/screens/daily_forecast.dart';
import '../model/weather_forecast_model.dart';
import '../widget/weather_card.dart';
import '/constants/text_styles.dart';
import '/constants/colors.dart';
import "/services/string_extension.dart";
import 'package:intl/intl.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  String currentDateTime = '';

  final List<Color> gradientColors = [
    const Color(0xFF1E3045),
    const Color(0xFF1F1E31),
  ];

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() {
    // String cDate = DateFormat("MMM, dd, yyyy").format(DateTime.now());
    String cTime = DateFormat("hh:mm a").format(DateTime.now());
    currentDateTime = "Today $cTime";
  }

  List<FlSpot> getSpots() {
    List<FlSpot> spots = [];
    for (int i = 0; i <= 10; i++) {
      spots.add(FlSpot(i.toDouble(), WeatherForecast.hourly[i]['temp'].toDouble()));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 50, left: 15, right: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(CurrentWeatherModel.getWeatherBG(
                      CurrentWeatherModel.condition)),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
                color: kDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: AssetImage('images/marker.png'),
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${CurrentWeatherModel.cityName}, ${CurrentWeatherModel.country}',
                            style: kLocationTextBoldStyle,
                          )
                        ],
                      ),
                      Text(
                        currentDateTime,
                        style: kMainTextRegularStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      McCountingText(
                        begin: 0,
                        end: CurrentWeatherModel.temperature.toDouble(),
                        style: kLargeTextStyle,
                        duration: Duration(seconds: 1),
                      ),
                      const Text(
                        '°C',
                        style: kSuperScriptsTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        CurrentWeatherModel.weatherDescription.capitalize(),
                        style: kSubTextRegularSizeStyle,
                      ),
                      Image(
                        image: AssetImage(
                            'images/${CurrentWeatherModel.weatherIcon}.png'),
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: AssetImage('images/cloud.png'),
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          McCountingText(
                            begin: 0,
                            end: CurrentWeatherModel.cloud.toDouble(),
                            style: kMainTextRegularStyle,
                            duration: Duration(seconds: 1),
                          ),
                          Text(
                            '%',
                            style: kMainTextRegularStyle,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('images/hygrometer.png'),
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          McCountingText(
                            begin: 0,
                            end: CurrentWeatherModel.humidity.toDouble(),
                            style: kMainTextRegularStyle,
                            duration: Duration(seconds: 1),
                          ),
                          Text(
                            '%',
                            style: kMainTextRegularStyle,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('images/windsock.png'),
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${CurrentWeatherModel.windSpeed} km/h',
                            style: kMainTextRegularStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: WeatherCard(
                          text: 'Sunrise',
                          largeText: CurrentWeatherModel.sunrise,
                          icon: 'sunrise',
                        ),
                      ),
                      Expanded(
                        child: WeatherCard(
                          text: 'Sunset',
                          largeText: CurrentWeatherModel.sunset,
                          icon: 'sunset',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Hourly Forecast',
                      style: kSubTextBoldStyle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 20),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('MMM d, yyyy\nhh:mm a')
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              WeatherForecast.hourly[index]
                                                      ['dt'] *
                                                  1000))
                                      .toString(),
                                  style: kSubTextRegularStyle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Image(
                                  image: AssetImage(
                                      'images/${WeatherForecast.hourly[index]['weather'][0]['icon']}.png'),
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    McCountingText(
                                      begin: 0,
                                      end: WeatherForecast.hourly[index]['temp']
                                          .toDouble(),
                                      style: kSmallSubTextBoldStyle,
                                      duration: Duration(seconds: 1),
                                    ),
                                    Text(
                                      '°C',
                                      style: kSmallSubTextBoldStyle,
                                    ),
                                  ],
                                ),
                                Text(
                                  '${WeatherForecast.hourly[index]['weather'][0]['main']}',
                                  style: kSubTextRegularStyle,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Daily Forecast',
                      style: kSubTextBoldStyle,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 20),
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat('EEEE\nMMMM, yyyy')
                                        .format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            WeatherForecast.daily[index]
                                            ['dt'] *
                                                1000))
                                        .toString(),
                                    style: kSubTextRegularStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10),
                                  Image(
                                    image: AssetImage(
                                        'images/${WeatherForecast.daily[index]['weather'][0]['icon']}.png'),
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      McCountingText(
                                        begin: 0,
                                        end: WeatherForecast.daily[index]['temp']['min']
                                            .toDouble(),
                                        style: kSmallSubTextBoldStyle,
                                        duration: Duration(seconds: 1),
                                      ),
                                      Text(
                                        ' / ',
                                        style: kSmallSubTextBoldStyle,
                                      ),
                                      McCountingText(
                                        begin: 0,
                                        end: WeatherForecast.daily[index]['temp']['max']
                                            .toDouble(),
                                        style: kSmallSubTextBoldStyle,
                                        duration: Duration(seconds: 1),
                                      ),
                                      Text(
                                        '°C',
                                        style: kSmallSubTextBoldStyle,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${WeatherForecast.daily[index]['weather'][0]['main']}',
                                    style: kSubTextRegularStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DailyForecastScreen(
                                  index: index,
                                );
                              },
                            ));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
