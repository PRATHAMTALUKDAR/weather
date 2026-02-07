class Weather{
  double temp;
  String cityName;
  String condition;

  Weather({required this.temp , required this.cityName , required this.condition});

  factory Weather.fromJson(Map<String , dynamic> json){
    return Weather(temp: json['main']['temp'].toDouble(), 
    cityName: json['name'], 
    condition: json['weather'][0]['main']);
  }
}