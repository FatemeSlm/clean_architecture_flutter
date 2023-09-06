import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/repository/weather_repository_impl.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  /// repositories
  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));

  /// use cases
  locator.registerSingleton<GetCurrentWeatherUseCase>(GetCurrentWeatherUseCase(locator()));

  /// blocs
  locator.registerSingleton<WeatherBloc>(WeatherBloc(locator()));
}
