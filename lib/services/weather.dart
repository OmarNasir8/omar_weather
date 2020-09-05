import 'package:climaweather/services/location.dart';
import 'package:climaweather/services/networking.dart';

const apiKey = '33f889d86a9ba326dbcb635fd02df754';

class WeatherModel {
  double latitude;
  double longitude;

  Future<dynamic> getCityWeather(String cityName) async {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = new NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();
    latitude = location.lat;
    longitude = location.long;

    NetworkHelper networkHelper = new NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for 👕';
    } else if (temp > 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Ayo its cold as hell';
    }
  }
}
