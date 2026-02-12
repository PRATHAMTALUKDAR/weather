import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("56b4e6ae8721b51ff92ac86dfe2df709");
  Weather? _weather;

  _fetchWeather() async {
  print("START fetchWeather");

  try {
    String cityName = await _weatherService.getCurrentCity();
    print("City detected: $cityName");

    final weather = await _weatherService.getWeather(cityName);
    print("Weather API success");

    setState(() {
      _weather = weather;
    });
    } catch (e) {
      print("ERROR in fetchWeather: $e");
    }
  }

  bool isDay(){
    int hour = DateTime.now().hour;
    if(hour >= 6 && hour <= 18){
      return true;
    }
    return false;
  }

  String getWeatherAnimation(String? mainCondition) {
    bool ifDay = isDay();
    if(mainCondition == null){
      return 'assets/sunny.json';
    }
    switch(mainCondition.toLowerCase()){
      case 'clouds':
        if(ifDay){
          return 'assets/windy.json';
        }
        else{
          return 'assets/night_cloudy.json';
        }
      case 'mist':
          if(ifDay){
          return 'assets/windy.json';
        }
        else{
          return 'assets/night_cloudy.json';
        }
      case 'smoke':
          if(ifDay){
          return 'assets/windy.json';
        }
        else{
          return 'assets/night_cloudy.json';
        }
      case 'dust':
          if(ifDay){
          return 'assets/windy.json';
        }
        else{
          return 'assets/night_cloudy.json';
        }
      case 'haze':
          if(ifDay){
          return 'assets/windy.json';
        }
        else{
          return 'assets/night_cloudy.json';
        }
      case 'rain':
          if(ifDay){
            return 'assets/rain.json';
          }
          else{
            return 'assets/night_rainy.json';
          }
      case 'drizzle':
          if(ifDay){
            return 'assets/rain.json';
          }
          else{
            return 'assets/night_rainy.json';
          }
      case 'shower rain':
          if(ifDay){
            return 'assets/rain.json';
          }
          else{
            return 'assets/night_rainy.json';
          }
      case 'thunderstorm':
          if(ifDay){
            return 'assets/storm.json';
          }
          else{
            return 'assets/night_rainy.json';
          }
      case 'clear':
          if(ifDay){
            return 'assets/sunny.json';
          }
          else{
            return 'assets/night_clear.json';
          }
      default:
          if(ifDay){
            return 'assets/sunny.json';
          }
          else{
            return 'assets/night_clear.json';
          }
    }
  }

  Color bgcolor(String? weather){
    if(weather==null){
        return const Color.fromARGB(255, 150, 150, 150);
    }
    switch(weather.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'haze':
        return const Color.fromARGB(255, 150, 150, 150);
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return Colors.blueGrey;
      case 'thunderstorm':
        return Colors.blueGrey;
      case 'clear':
        return const Color.fromARGB(255, 87, 202, 255);
      default:
        return const Color.fromARGB(255, 87, 202, 255);
    }
  }
  @override
  void initState(){
    super.initState();

    _fetchWeather();
  }

  BoxDecoration getWeatherGradient(String? condition) {
  switch (condition?.toLowerCase()) {
    case 'clear':
      return const BoxDecoration(
        gradient: LinearGradient(
          colors: [ Color.fromARGB(255, 38, 175, 255),Color.fromARGB(255, 210, 210, 210),],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
      return const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 61, 65, 75), Color.fromARGB(255, 153, 153, 153)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

    case 'rain':
    case 'drizzle':
      return const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 57, 57, 57), Color.fromARGB(255, 98, 98, 98)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

    case 'thunderstorm':
      return const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF232526), Color(0xFF414345)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

    default:
      return const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF56CCF2), Color.fromARGB(255, 196, 196, 196)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
    }
  }


  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: getWeatherGradient(_weather?.condition),
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_sharp,size: 50,),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Text(_weather?.cityName ?? " ",    //city
                style: TextStyle(fontSize: 35,),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:80.0),
                child: Lottie.asset(getWeatherAnimation(_weather?.condition)),
              ),
              Padding(
                padding: const EdgeInsets.only(top:70.0),
                child:Text(_weather == null ? " " : "${_weather!.temp.round()}°",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: Text(_weather?.condition == null ? " " :'${_weather?.condition}',            //condition
                style: TextStyle(fontSize: 35,fontWeight: FontWeight.w400),),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: bgcolor(_weather?.condition),
    );
  }
}