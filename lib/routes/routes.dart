import 'package:flutter/material.dart';
import 'package:weather_app/views/weather_details.dart';
import '../views/search_page.dart';

class RouteManager {
  static const String searchPage = '/';
  static const String weatherDetails = '/weatherDetails';

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case searchPage:
        return MaterialPageRoute(
          builder: (context) => const SearchPage(),
        );

      case weatherDetails:
        return MaterialPageRoute(
          builder: (context) => const WeatherDetails(
            city: '',
          ),
        );

      default:
        throw const FormatException(
            'Route not found! Please check  and make sure route exists');
    }
  }
}
