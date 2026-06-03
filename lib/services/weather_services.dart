import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:wheather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WheatherServices {

  final String apiKey = 'f58d0cea314d2e20464f5225e778310c';
   final String baseUrl = 'https://api.openweathermap.org/data/2.5';

   Future<WheatherModel>getWeatherByCity(String cityName) async {

    try{
      final response=await http.get(
        Uri.parse('$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric')
      );

    
     if (response.statusCode == 200) {
      debugPrint('succes');
        return WheatherModel.fromJson(json.decode(response.body));
      
      } else {
         debugPrint(' no succes');
        throw Exception('Failed to load weather. Status code: ${response.statusCode}');
      }
      

    }
    catch (e) {
      throw Exception('Error fetching weather: $e');
    }
    }

    Future<WheatherModel>getWheatherByCordinate(double lat,double lon) async{
     
      try{
        
                  
         final response = await http.get(
        Uri.parse('$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
     
          if(response.statusCode==200){

              return WheatherModel.fromJson(json.decode(response.body));
      }
      else{
        throw Exception("Failed to load weather. Status code: ${response.statusCode}");
      }
      }
      catch (e){
        throw Exception('Error Fetching Weather$e');
      }
    
    }
}
