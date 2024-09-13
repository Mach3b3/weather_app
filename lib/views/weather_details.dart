import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/styles/app_style.dart'; // Your custom app styling
import 'package:weather_app/styles/colors.dart'; // Your custom app colors
import 'package:weather_app/widgets/back_button.dart'; // Custom back button widget

class WeatherDetails extends StatefulWidget {
  final String city;

  const WeatherDetails({
    super.key,
    required this.city,
  });

  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  final AppColors _appColors = AppColors(); // App colors instance

  @override
  void initState() {
    super.initState();
    context.read<WeatherData>().fetchWeatherData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_appColors.primary, _appColors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back Button
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: MyBackButton(),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: _appColors.primary,
                  onRefresh: () async {
                    await context
                        .read<WeatherData>()
                        .fetchWeatherData(widget.city);
                  },
                  child: Consumer<WeatherData>(
                      builder: (context, weatherData, child) {
                    if (weatherData.map.isEmpty && !weatherData.error) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: _appColors.primary,
                          semanticsLabel: "Loading weather data...",
                        ),
                      );
                    } else if (weatherData.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'An error occurred: ${weatherData.errorMessage}',
                              style: TextStyling.bodyLarge(context)!.copyWith(
                                color: _appColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<WeatherData>()
                                    .fetchWeatherData(widget.city);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _appColors.primary,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final weather = weatherData.map['weather'][0];
                      final main = weatherData.map['main'];
                      final sys = weatherData.map['sys'];
                      final wind = weatherData.map['wind'];

                      DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
                          sys['sunrise'] * 1000);
                      DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
                          sys['sunset'] * 1000);
                      int pressure = main['pressure'];
                      double windSpeed = (wind['speed'] as num).toDouble();
                      double tempFeelsLike =
                          (main['feels_like'] as num).toDouble();
                      double humidity = (main['humidity'] as num).toDouble();
                      String description = weather['description'];
                      String mainWeather = weather['main'];

                      return Column(
                        children: [
                          // Cached Network Image with consistent styling
                          CachedNetworkImage(
                            imageUrl:
                                'https://openweathermap.org/img/wn/${weather['icon']}@2x.png',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: _appColors.primary,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, color: _appColors.errorColor),
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          // Temperature Text with theme styling
                          Text(
                            '${main['temp']}°C',
                            style: TextStyling.headlineLarge(context)!.copyWith(
                              color: _appColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // City Name Text
                          Text(
                            widget.city,
                            style: TextStyling.bodyLarge(context)!.copyWith(
                              color: _appColors.darkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Weather Details Grid with consistent card styling
                          Expanded(
                            child: GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              padding: const EdgeInsets.all(16.0),
                              children: [
                                _buildDetailCard(
                                    'Main', mainWeather, Icons.info, context),
                                _buildDetailCard('Description', description,
                                    Icons.description, context),
                                _buildDetailCard(
                                    'Feels Like',
                                    '${tempFeelsLike.toStringAsFixed(1)}°C',
                                    Icons.thermostat,
                                    context),
                                _buildDetailCard(
                                    'Humidity',
                                    '${humidity.toStringAsFixed(0)}%',
                                    Icons.water_drop,
                                    context),
                                _buildDetailCard(
                                    'Sunrise',
                                    '${sunrise.hour}:${sunrise.minute}',
                                    Icons.wb_sunny,
                                    context),
                                _buildDetailCard(
                                    'Sunset',
                                    '${sunset.hour}:${sunset.minute}',
                                    Icons.nightlight_round,
                                    context),
                                _buildDetailCard(
                                    'Wind Speed',
                                    '${windSpeed.toStringAsFixed(1)} km/h',
                                    Icons.air,
                                    context),
                                _buildDetailCard('Pressure', '$pressure hPa',
                                    Icons.speed, context),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
      String title, String value, IconData icon, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: _appColors.background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: _appColors.primary),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyling.bodyLarge(context)!.copyWith(
                color: _appColors.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyling.bodyMedium(context)!.copyWith(
                color: _appColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
