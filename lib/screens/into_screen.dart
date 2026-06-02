import 'package:flutter/material.dart';
import 'package:wheather_app/const.dart';
import 'package:wheather_app/elevated_style.dart';
import 'package:wheather_app/screens/location_page.dart';
import 'package:wheather_app/screens/wheather_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final TextEditingController _cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _navigateToWeather() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WheatherScreen(cityName: _cityController.text.trim()),
        ),
      );
    }
  }

  void _navigateToCurrentLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrentLocation()),
    );
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Weather Icon
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor.withValues(alpha: 0.15),
                      ),
                      child: Icon(
                        Icons.wb_sunny_rounded,
                        size: 90,
                        color: whiteColor,
                      ),
                    ),

                    SizedBox(height: 30),

                    /// App Title
                    Text(
                      "Wheather App",
                      style: textStyle.copyWith(fontSize: 34),
                    ),

                    SizedBox(height: 10),

                    /// Subtitle
                    Text('Check weather in your city', style: smalltextStyle),

                    SizedBox(height: 45),

                    /// Main Card
                    Container(
                      padding: EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: whiteColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: borderColor),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            /// TextField
                            TextFormField(
                              controller: _cityController,
                              style: TextStyle(
                                color: black87Color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter City Name',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: iconPurpleColor,
                                ),
                                filled: true,
                                fillColor: textFieldFillColor,
                                errorStyle: TextStyle(color: whiteColor),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter City Name';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 30),

                            /// Get Weather Button
                            SizedBox(
                              width: double.infinity,
                              child: CustomElevatedstyle(
                                text: 'Get Wheather',
                                onPressed: _navigateToWeather,
                              ),
                            ),

                            const SizedBox(height: 18),

                            /// Current Location Button
                            SizedBox(
                              width: double.infinity,
                              child: CustomElevatedstyle(
                                text: 'Get Current Location',
                                onPressed: _navigateToCurrentLocation,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
