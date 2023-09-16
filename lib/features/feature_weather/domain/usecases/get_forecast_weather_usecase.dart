import '../../../../core/params/forecast_params.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/forecast_days_entiry.dart';
import '../repository/weather_repository.dart';

class GetForecastWeatherUseCase
    extends UseCase<DataState<ForecastDaysEntity>, ForecastParams> {
  final WeatherRepository _weatherRepository;

  GetForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams params) {
    return _weatherRepository.fetchForecastWeatherData(params);
  }
}
