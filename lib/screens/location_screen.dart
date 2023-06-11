import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {

LocationScreen({this.locationWeather});

final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel waether = WeatherModel();

  late int temprature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.locationWeather);
  }

void updateUI(dynamic weatherData) {
  setState(() {
    if(weatherData == null) {
      temprature = 0;
      weatherIcon = 'Error';
      weatherMessage = 'Unable to get weather data';
      cityName = '';
      return;
    } 
    double temp = weatherData['main']['temp'];
    temprature = temp.toInt();
    int condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    weatherIcon = getWeatherIcon(condition);
    weatherMessage = getWeatherMessage(temprature);

  });
}


String getWeatherIcon(int condition) {
  if (condition < 300) {
      return '🌩️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍♂️';
    }
}

String getWeatherMessage(int temperature) {
  if (temperature > 25) {
      return 'It\'s 🍦 time';
    } else if (temperature > 20) {
      return 'Time for shorts and 👕';
    } else if (temperature < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
}


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
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
                  TextButton(
                    onPressed: () async {
                      var weatherData = await WeatherModel().getWeather(cityName);
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      ),
                    ),
                  Text(
                    cityName,
                    style: kButtonTextStyle,
                    ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the city screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
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
                      '$temprature',
                      style: kTempTextStyle,
                      ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  ' $weatherMessage in $cityName!',
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