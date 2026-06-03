
import 'package:flutter/material.dart';
import 'package:wheather_app/const.dart';
import 'package:intl/intl.dart';

import 'package:wheather_app/elevated_style.dart';
import 'package:wheather_app/humidity_column.dart';
import 'package:wheather_app/models/weather_model.dart';
import 'package:wheather_app/services/weather_services.dart';

class WheatherScreen extends StatefulWidget {
  final String? cityName;
  final double? latitude;
  final double? longitude;
  final bool isFromLocation;

  const WheatherScreen({
    super.key,
    this.cityName,
    this.latitude,
    this.longitude,
    this.isFromLocation = false,
  });

  @override
  State<WheatherScreen> createState() => _WheatherScreenState();
}

class _WheatherScreenState extends State<WheatherScreen> {
  final WheatherServices _weatherServices = WheatherServices();

  late Future<WheatherModel> _weatherData;

  @override
  void initState() {
    super.initState();

    if (widget.isFromLocation &&
        widget.latitude != null &&
        widget.longitude != null) {
      _weatherData = _weatherServices.getWheatherByCordinate(
        widget.latitude!,
        widget.longitude!,
      );
    } else if (widget.cityName != null && widget.cityName!.isNotEmpty) {
      _weatherData = _weatherServices.getWeatherByCity(widget.cityName!);
    } else {
      _weatherData = Future.error('No Location Data Provide');
    }
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
          child: FutureBuilder<WheatherModel>(
            future: _weatherData,
            builder: (context, snapshot) {
              // Loading State
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: whiteColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: borderColor),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(color: whiteColor),

                        const SizedBox(height: 25),

                        Text(
                          "Loading Weather...",
                          style: textStyle.copyWith(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Error State
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: whiteColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: borderColor),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 80,
                            color: whiteColor,
                          ),

                          SizedBox(height: 25),

                          Text(
                            'Error : Please Enter Correct Place',
                            style: smalltextStyle.copyWith(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            child: CustomElevatedstyle(
                              text: 'Go Back',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // Success State
              if (snapshot.hasData) {
                final weather = snapshot.data!;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: whiteColor,
                            ),
                          ),

                          Expanded(
                            child: Text(
                              'Weather Details',
                              textAlign: TextAlign.center,
                              style: textStyle.copyWith(fontSize: 24),
                            ),
                          ),

                          SizedBox(width: 48),
                        ],
                      ),

                      SizedBox(height: 20),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Main Weather Card
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: whiteColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      weather.cityName,
                                      style: textStyle.copyWith(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                    SizedBox(height: 10),

                                    Text(
                                      DateFormat(
                                        'EEEE, MMMM d, y',
                                      ).format(DateTime.now()),
                                      style: smalltextStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),

                                    SizedBox(height: 25),

                                    // Weather Icon
                                    Container(
                                      padding: EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: whiteColor.withValues(
                                          alpha: 0.15,
                                        ),
                                      ),
                                      child: Image.network(
                                        weather.iconUrl,
                                        height: 110,
                                        width: 110,
                                      ),
                                    ),

                                    SizedBox(height: 20),

                                    // Temperature
                                    Text(
                                      "${weather.temperature.round()}°C",
                                      style: tempStyle.copyWith(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Text(
                                      weather.description.toUpperCase(),
                                      style: descStyle.copyWith(
                                        letterSpacing: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),

                              // Weather Details Card
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: whiteColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HomeColomn(
                                      label: 'Humidity',
                                      icon: Icons.water_drop_rounded,
                                      value: '${weather.humidity}%',
                                    ),

                                    Container(
                                      height: 70,
                                      width: 1,
                                      color: white70Color,
                                    ),

                                    HomeColomn(
                                      label: 'Wind Speed',
                                      icon: Icons.air_rounded,
                                      value: '${weather.windSpeed} m/s',
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 40),

                              // Button
                              SizedBox(
                                width: double.infinity,
                                child: CustomElevatedstyle(
                                  text: 'Search Another City',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),

                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Center(
                child: Text(
                  'No data available',
                  style: TextStyle(color: whiteColor),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
