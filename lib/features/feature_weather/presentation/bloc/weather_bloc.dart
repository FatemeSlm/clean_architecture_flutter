import 'package:bloc/bloc.dart';
import 'package:clean_arcitecture_flutter_sample/core/params/forecast_params.dart';
import 'package:clean_arcitecture_flutter_sample/core/resources/data_state.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/get_current_weather_usecase.dart';
import '../../domain/usecases/get_forecast_weather_usecase.dart';
import 'fw_status.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase getForecastWeatherUseCase;

  WeatherBloc(this.getCurrentWeatherUseCase, this.getForecastWeatherUseCase)
      : super(WeatherState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
    on<WeatherEvent>((event, emit) async {
      /// cw event
      if (event is LoadCWEvent) {
        emit(state.copyWith(newCwStatus: CwLoading()));
        DataState dataState = await getCurrentWeatherUseCase(event.cityName);
        if (dataState is DataSuccess) {
          emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
        }
        if (dataState is DataFailed) {
          emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
        }
        /// fw event
      } else if (event is LoadFWEvent) {
        emit(state.copyWith(newFwStatus: FwLoading()));
        DataState dataState =
            await getForecastWeatherUseCase(event.forecastParams);
        if (dataState is DataSuccess) {
          emit(state.copyWith(newFwStatus: FwCompleted(dataState.data)));
        }
        if (dataState is DataFailed) {
          emit(state.copyWith(newFwStatus: FwError(dataState.error!)));
        }
      }
    });
  }
}
