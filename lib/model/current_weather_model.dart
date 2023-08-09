class CurrentWeatherModel {

  static late final String cityName;
  static late final String country;
  static late final int temperature;
  static late final String mainWeather;
  static late final String weatherDescription;
  static late final double windSpeed;
  static late final String weatherIcon;
  static late final int humidity;
  static late final int pressure;
  static late final int cloud;
  static late final double feelsLike;
  static late final double tempMin;
  static late final double tempMax;
  static late final int visibility;
  static late final DateTime sunrise;
  static late final DateTime sunset;
  static late final String date;
  static late final String time;
  static late final int condition;

  static String getWeatherBG (int condition) {
    if (condition < 300) {
      return 'images/thunderstorm.jpg';
    } else if (condition < 400) {
      return 'images/drizzle.jpg';
    } else if (condition < 600) {
      return 'images/rain.jpg';
    } else if (condition < 700) {
      return 'images/snow.jpg';
    } else if (condition < 800) {
      return 'images/atmosphere.jpg';
    } else if (condition == 800) {
      return 'images/clear.jpg';
    } else if (condition <= 804) {
      return 'images/overcast_cloud.jpg';
    } else {
      return 'images/unknown.jpg';
    }
  }

}