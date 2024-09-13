import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/styles/app_style.dart';
import 'package:weather_app/styles/colors.dart';
import 'weather_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String city = '';

  TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String time =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    String date =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors().primary, AppColors().white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: city == ''
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        'Weather App',
                        style: GoogleFonts.lato(
                          color: AppColors().darkGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 35, // Set a large font size for prominence
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildInfoCard('Date: $date', context),
                            _buildInfoCard('Time: $time', context),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Curious about the weather in another city? Enter a city name below to find out!',
                            style: TextStyling.bodyMedium(context)!.copyWith(
                              color: AppColors().white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: _buildCitySearch(),
                    ),
                  ],
                ),
              )
            : ChangeNotifierProvider(
                create: (context) => WeatherData(),
                builder: (context, child) {
                  return WeatherDetails(city: city);
                },
              ),
      ),
    );
  }

  Widget _buildInfoCard(String text, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 2.5,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyling.bodyMedium(context)!.copyWith(
                color: AppColors().primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCitySearch() {
    return Column(
      children: [
        // Search TextField
        TextField(
          controller: cityController,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            city = value;
          },
          textAlign: TextAlign.left, // Align left for a cleaner look
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors()
                .white
                .withOpacity(0.9), // Slightly less transparency for maturity
            prefixIcon: Icon(Icons.search_outlined, color: AppColors().primary),
            hintText:
                'Enter city name', // Changed labelText to hintText for cleaner UI
            hintStyle: TextStyling.bodyMedium(context)!.copyWith(
              color: AppColors().primary.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 20), // Add padding
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ), // Rounded edges for a polished look
              borderSide: BorderSide(
                color:
                    AppColors().primary.withOpacity(0.5), // Border with opacity
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors().primary, // Solid border on focus
              ),
            ),
          ),
          style: TextStyling.bodyMedium(context)!.copyWith(
            color: AppColors().primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        // Search Button
        ElevatedButton(
          onPressed: _searchCity,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors().primary,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Rounded button for consistency
            ),
            elevation: 3, // Add elevation for a subtle depth effect
          ),
          child: Text(
            'SEARCH',
            style: TextStyling.bodyMedium(context)!.copyWith(
              color: AppColors().white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _searchCity() {
    setState(() {
      city = cityController.text;
    });
  }
}
