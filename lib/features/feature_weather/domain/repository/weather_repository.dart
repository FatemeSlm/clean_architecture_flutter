import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/entities/current_city_entity.dart';
import '../../../../core/resources/data_state.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);
}
