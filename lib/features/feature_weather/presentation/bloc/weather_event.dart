part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class LoadCWEEvent extends WeatherEvent {
  final String cityName;

  LoadCWEEvent(this.cityName);
}
