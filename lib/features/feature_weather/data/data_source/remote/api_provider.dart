import 'package:clean_arcitecture_flutter_sample/core/params/forecast_params.dart';
import 'package:clean_arcitecture_flutter_sample/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio _dio = Dio();
  var apiKey = Constants.apiKey;

  /// current weather api call
  Future<dynamic> callCurrentWeather(cityName) async {
    var response = await _dio.get('${Constants.baseUrl}/data/2.5/weather',
        queryParameters: {'q': cityName, 'appid': apiKey, 'units': 'metric'});

    if (kDebugMode) {
      print(response.data);
    }
    return response;
  }

  /// 7 days forecast api
  Future<dynamic> sendRequest7DaysForecast(ForecastParams params) async {
    var response = await _dio
        .get('${Constants.baseUrl}/data/2.5/onecall', queryParameters: {
      'lat': params.lat,
      'lon': params.lon,
      'exclude': 'minutely, hourly',
      'appid': apiKey,
      'units': 'metric'
    });
    return response;
  }

  /// city name suggest api
  Future<dynamic> sendRequestCitySuggestion(String prefix) async {
    var response = await _dio.get(
        "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
        queryParameters: {'limit': 7, 'offset': 2, 'namePrefix': prefix});

    return response;
  }
}
