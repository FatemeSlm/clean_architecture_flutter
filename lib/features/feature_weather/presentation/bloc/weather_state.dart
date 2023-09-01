part of 'weather_bloc.dart';

class WeatherState {
  CwStatus cwStatus;

  WeatherState({required this.cwStatus});

  WeatherState copyWith({CwStatus? newCwStatus}) {
    return WeatherState(cwStatus: newCwStatus ?? cwStatus);
  }
}
