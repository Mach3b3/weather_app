import 'package:flutter/material.dart';
import 'package:weather_app/routes/routes.dart';
import 'package:weather_app/styles/app_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().theme,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.searchPage,
      onGenerateRoute: RouteManager.routes,
    );
  }
}
