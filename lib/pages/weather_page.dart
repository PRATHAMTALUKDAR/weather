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



  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null){
      return 'assets/sunny.json';
    }
    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'haze':
        return 'assets/windy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  Color bgcolor(String? weather){
    switch(weather){
      case 'clouds':
        return Colors.blueGrey;
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'haze':
        return Colors.blueGrey;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_sharp,size: 50,),
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Text(_weather?.cityName ?? "Loading city...",    //city
              style: TextStyle(fontSize: 35,),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:80.0),
              child: Lottie.asset(getWeatherAnimation(_weather?.condition)),
            ),
            Padding(
              padding: const EdgeInsets.only(top:70.0),
              child:Text(_weather == null ? "--°" : "${_weather!.temp.round()}°",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Text('${_weather?.condition}',            //condition
              style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
      backgroundColor: bgcolor(_weather?.condition),
    );
  }
}