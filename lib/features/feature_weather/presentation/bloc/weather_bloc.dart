import 'package:bloc/bloc.dart';
import 'package:clean_arcitecture_flutter_sample/core/resources/data_state.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/get_current_weather_usecase.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherBloc(this.getCurrentWeatherUseCase)
      : super(WeatherState(cwStatus: CwLoading())) {
    on<WeatherEvent>((event, emit) async {
      /// cw event
      if (event is LoadCWEEvent) {
        emit(state.copyWith(newCwStatus: CwLoading()));
        DataState dataState = await getCurrentWeatherUseCase(event.cityName);
        if (dataState is DataSuccess) {
          emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
        }
        if (dataState is DataFailed) {
          emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
        }
      }
    });
  }
}
