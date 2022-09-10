import 'dart:convert';

import 'package:http/http.dart' as http;

import '../climat-class-model/response-model.dart';
import '../packages/geo-locator.dart';


class DataService {
  Future<Weather> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'key': 'b581a4489ac94de5b8b142809220709',
      'q': city,
      'days'  : '7',
      'aqi' : 'no',
      'alerts' : 'no'
    };

    final uri = Uri.https(
        'api.weatherapi.com', '/v1/forecast.json', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return Weather.fromJson(json);
  }

  Future<Weather> getLocationWeather() async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    dynamic pos;
    pos = await determinePosition();
    print('here $pos');
    final queryParameters = {
      'key': 'b581a4489ac94de5b8b142809220709',
      'q': '${pos}',
      'days'  : '7',
      'aqi' : 'no',
      'alerts' : 'no'
    };

    final uri = Uri.https(
        'api.weatherapi.com', '/v1/forecast.json', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    dynamic FavCity = json['location']['name'];
    print(FavCity);

    return Weather.fromJson(json);
  }

}