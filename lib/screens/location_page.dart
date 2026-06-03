import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheather_app/const.dart';
import 'package:wheather_app/custom_dialog.dart';
import 'package:wheather_app/services/location_services.dart';
import 'package:wheather_app/screens/weather_screen.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  final LocationServices _locationServices = LocationServices();

  bool isLoading = false;

  Future<void> _getWeatherLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool isEnabled = await _locationServices.isLocationServiceEnabled();

      if (!isEnabled) {
        if (mounted) {
          await _locationServices.showLocationServiceDialog(context);
        }
      }

      LocationPermission permission = await _locationServices.checkPermission();

      if (permission == LocationPermission.denied) {
        if (mounted) {
          _locationServices.showPermissionDialog(context);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          _locationServices.showPermissionDialog(context);
        }
      }

      Position position = await _locationServices.getCurrentLocation();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WheatherScreen(
              latitude: position.latitude,
              longitude: position.longitude,
              isFromLocation: true,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showCustomDialog(
          context: context,
          title: 'Error',
          content: 'Failed to get location: $e',
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK", style: TextStyle(color: buttonTextColor)),
            ),
          ],
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWeatherLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryGradientOne, primaryGradientTwo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: whiteColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: borderColor),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: whiteColor.withValues(alpha: 0.15),
                            ),
                            child: Icon(
                              Icons.my_location_rounded,
                              size: 70,
                              color: whiteColor,
                            ),
                          ),

                          SizedBox(height: 30),

                          CircularProgressIndicator(
                            color: whiteColor,
                            strokeWidth: 3,
                          ),

                          SizedBox(height: 28),

                          Text(
                            "Fetching Your Location",
                            style: locationTextStyle.copyWith(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 12),

                          Text(
                            "Please wait while we detect your current location and load the weather details.",
                            style: locationSmalltextStyle.copyWith(
                              fontSize: 15,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
