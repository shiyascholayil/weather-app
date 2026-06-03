class WheatherModel {
   final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final String iconCode;

  WheatherModel({
  required this.cityName,
  required this.temperature,
  required this.description,
  required this.humidity,
   required this.windSpeed,
    required this.iconCode,
 });

  factory WheatherModel.fromJson(Map<String,dynamic>json){
    return WheatherModel(cityName:json['name'], 
     temperature:json['main']['temp'].toDouble(), 
     description:json['weather'][0]['description'], 
     humidity:json['main']['humidity'], 
     windSpeed: json['wind']['speed'].toDouble(),
      iconCode: json['weather'][0]['icon'],
     
    );
    
  }
     String get iconUrl => 'https://openweathermap.org/img/wn/$iconCode@2x.png';

}