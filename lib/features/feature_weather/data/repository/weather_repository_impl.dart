import 'package:clean_arcitecture_flutter_sample/core/params/forecast_params.dart';
import 'package:clean_arcitecture_flutter_sample/core/resources/data_state.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/models/current_city_model.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/entities/forecast_days_entiry.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/entities/suggest_city_entity.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final ApiProvider apiProvider;

  WeatherRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      Response response = await apiProvider.callCurrentWeather(cityName);

      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityEntity);
      } else {
        return const DataFailed('something went wrong. try again...');
      }
    } catch (exp) {
      return DataFailed(exp.toString());
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params) async {
    try {
      Response response = await apiProvider.sendRequest7DaysForecast(params);

      if (response.statusCode == 200) {
        ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return const DataFailed('something went wrong. try again...');
      }
    } catch (exp) {
      return DataFailed(exp.toString());
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(String cityName) async {
    Response response = await apiProvider.sendRequestCitySuggestion(cityName);

    SuggestCityEntity suggestCityEntity =
        SuggestCityModel.fromJson(response.data);
    return suggestCityEntity.data!;
  }
}
