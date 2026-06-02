

import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:wheather_app/custom_dialog.dart';
import 'package:wheather_app/screens/into_screen.dart';

class LocationServices {
 


  Future<bool>isLocationServiceEnabled() async{
    return await Geolocator.isLocationServiceEnabled();
  }
 Future<LocationPermission> checkPermission() async{
    return await Geolocator.checkPermission();
 }
 Future<LocationPermission> requestPermission() async{
  return await Geolocator.requestPermission();
 }
 Future<Position>getCurrentLocation() async{
        
  return await Geolocator.getCurrentPosition(
    
    desiredAccuracy:LocationAccuracy.high,
    
  );
 }
 
 Future<void> showLocationServiceDialog(BuildContext context) async {
  if(!context.mounted) return;
  final Completer complete=Completer<bool>();

  return  await showCustomDialog (
    context: context,
    title: 'Location Service Disabled',
    content:
        'Please enable location services to get weather for your current location.',
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () async {
        await   Geolocator.openLocationSettings();
         complete.complete(true);
          if(context.mounted){
            Navigator.of(context).pop();
          }
        },
        child: const Text('Open Settings'),

      ),
    ],
  );
}

Future<void>showPermissionDialog(BuildContext context) async{
  return showCustomDialog(context: context,
  
   title:'Location Permission Required',
  content:'Please grant location permission to get weather for your current location',
  
  actions:[
    TextButton(onPressed:(){
       Navigator.of(context).pop();
    }, child: Text('Cancel'),
  ),
  TextButton(onPressed:() async{
    LocationPermission permission = await Geolocator.requestPermission();
    if(context.mounted){
     if(permission==LocationPermission.whileInUse||permission==LocationPermission.always){
    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
     
     }
     
    }
    
      
  },   child: const Text('Request Permission'),)
  
  ],
);


}
}