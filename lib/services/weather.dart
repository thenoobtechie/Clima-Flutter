import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';

import 'location.dart';
import 'networking.dart';

const String apiKey = 'df0acee9e82aba21c26e36bbd7fa94f2';

class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    LocationData location = await getLocation();
    var networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    var jsonData = await networkHelper.getData();

    return jsonData;
  }

  Future getLocation() async {
    LocationData location = LocationData();
    await location.getCurrentLocation();
    return location;
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
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
