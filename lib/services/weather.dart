import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';

const String appid = 'bb74d7b8304587be7f7b420aae74ce2a';

class OpenWeatherMap {
  Future<dynamic> getCityWeather(String cityname) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': cityname,
      'appid': appid,
      'units': 'metric',
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedDate = convert.jsonDecode(response.body);
      return decodedDate;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<dynamic> getCurrentWeather() async {
    // latitude: ls.latitude, longitude: ls.longitude
    Location ls = Location();
    await ls.getCurrentLocation();
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': ls.latitude.toString(),
      'lon': ls.longitude.toString(),
      'appid': appid,
      'units': 'metric',
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedDate = convert.jsonDecode(response.body);
      return decodedDate;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
