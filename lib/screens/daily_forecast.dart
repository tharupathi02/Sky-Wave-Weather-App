import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:sky_wave/services/string_extension.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../model/weather_forecast_model.dart';
import '../widget/card_weather.dart';

class DailyForecastScreen extends StatefulWidget {

  const DailyForecastScreen({super.key, required this.index});
  final int index;

  @override
  State<DailyForecastScreen> createState() => _DailyForecastScreenState();
}

class _DailyForecastScreenState extends State<DailyForecastScreen> {

  late String weatherType;
  late String weatherIcon;
  late String minTemp;
  late String maxTemp;
  late String description;
  late String summary;
  late String sunrise;
  late String sunset;

  @override
  void initState() {
    super.initState();
    print('index: ${widget.index}');
    getDayWeatherData();
  }

  void getDayWeatherData() {
    for (int i = 0; i < WeatherForecast.daily.length; i++){
      if (i == widget.index) {
        weatherType = WeatherForecast.daily[i]['weather'][0]['main'];
        weatherIcon = WeatherForecast.daily[i]['weather'][0]['icon'];
        minTemp = WeatherForecast.daily[i]['temp']['min'].toString();
        maxTemp = WeatherForecast.daily[i]['temp']['max'].toString();
        description = WeatherForecast.daily[i]['weather'][0]['description'];
        summary = WeatherForecast.daily[i]['summary']; // daily[0].summary
        sunrise = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(WeatherForecast.daily[i]['sunrise'] * 1000)).toString();
        sunset = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(WeatherForecast.daily[i]['sunset'] * 1000)).toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/rain.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.4,
                  ),
                  color: kDark,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weatherType,
                          style: kSubTextRegularSizeStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image(
                          image: AssetImage(
                              'images/$weatherIcon.png'),
                          height: 50,
                          width: 50,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Min',
                            style: kSubTextRegularSizeStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Max',
                            style: kSubTextRegularSizeStyle,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: McCountingText(
                            begin: 0,
                            end: double.parse(minTemp),
                            style: kLargeTextStyle,
                            duration: const Duration(seconds: 1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.white,
                        ),
                        Expanded(
                          child: McCountingText(
                            begin: 0,
                            end: double.parse(maxTemp),
                            style: kLargeTextStyle,
                            duration: const Duration(seconds: 1),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          description.capitalize(),
                          style: kSubTextRegularSizeStyle,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          summary.capitalize(),
                          style: kSubTextRegularSizeStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: CardWeather(
                        text: 'Sunrise',
                        largeText: sunrise,
                        icon: 'sunrise',
                      ),
                  ),
                  Expanded(
                    child: CardWeather(
                      text: 'Sunset',
                      largeText: sunset,
                      icon: 'sunset',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}


