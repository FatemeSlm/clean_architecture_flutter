part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class LoadCWEvent extends WeatherEvent {
  final String cityName;

  LoadCWEvent(this.cityName);
}

class LoadFWEvent extends WeatherEvent {
  final ForecastParams forecastParams;

  LoadFWEvent(this.forecastParams);
}
