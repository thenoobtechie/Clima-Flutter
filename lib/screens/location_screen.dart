import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  var locationData;

  LocationScreen(this.locationData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature;
  var city, weather, weatherIcon, weatherMsg;
  WeatherModel weatherModel;

  @override
  void initState() {
    super.initState();

    var locationData = widget.locationData;
    weatherModel = WeatherModel();
    updateUI(locationData);
  }

  void updateUI(dynamic locationData) {
    setState(() {
      if (locationData == null) {
        temperature = 0.0;
        city = "Error";
        weather = 0;
        weatherMsg = "Unable to fetch data";
        return;
      }

      double temp = locationData['main']['temp'];
      temperature = temp;
      city = locationData["name"];
      weather = locationData['weather'][0]['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      dynamic locData = await weatherModel.getLocationWeather();
                      updateUI(locData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));

                      if (cityName != null) {
                        dynamic locData = await weatherModel
                            .getLocationWeatherByCity(cityName: cityName);
                        updateUI(locData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${temperature.toInt()}°c",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherModel.getWeatherIcon(weather),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherModel.getMessage(temperature.toInt())} in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
