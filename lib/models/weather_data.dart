import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class WeatherData with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';
  String _city = '';
  List<Weather>? weather;

  Main? main;
  int? visibility;
  Wind? wind;
  int? dt;
  Sys? sys;
  String? name;

  WeatherData({
    this.weather,
    this.main,
    this.visibility,
    this.wind,
    this.sys,
    this.name,
  });

  WeatherData.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      var list = <Weather>[];
      weather = list;
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }

    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;

    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;

    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (weather != null) {
      data['weather'] = weather?.map((v) => v.toJson()).toList();
    }

    if (main != null) {
      data['main'] = main?.toJson();
    }

    if (wind != null) {
      data['wind'] = wind?.toJson();
    }

    if (sys != null) {
      data['sys'] = sys?.toJson();
    }
    data['name'] = name;

    return data;
  }

  String get city => _city;

  set city(String city) {
    _city = city;
    notifyListeners();
  }

  fetchWeatherData(String city) async {
    _city = city;
    String api =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=1e1e8e941d029b4288db7eb57ebe0039';
    final response = await get(Uri.parse(api));

    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = {};
      }
    } else {
      _error = true;
      _errorMessage = 'Error occured: Please check you internet connection!';
      _map = {};
    }
    notifyListeners();
  }

  Map<String, dynamic> get map => _map;
  String get errorMessage => _errorMessage;
  bool get error => _error;
}

class Weather {
  String? description;
  String? icon;

  Weather({this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Main {
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;

  Main({this.temp, this.feelsLike, this.pressure, this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}

class Wind {
  double? speed;

  Wind({this.speed});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    return data;
  }
}

class Sys {
  int? sunrise;
  int? sunset;

  Sys({this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
