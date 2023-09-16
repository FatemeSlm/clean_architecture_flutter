import 'package:clean_arcitecture_flutter_sample/core/usecase/use_case.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/repository/weather_repository.dart';

class GetSuggestCityUseCase extends UseCase<List<Data>, String> {
  final WeatherRepository weatherRepository;

  GetSuggestCityUseCase(this.weatherRepository);

  @override
  Future<List<Data>> call(String params) {
    return weatherRepository.fetchSuggestData(params);
  }
}
