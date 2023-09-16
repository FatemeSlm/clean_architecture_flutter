part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  final CwStatus cwStatus;
  final FwStatus fwStatus;

  const WeatherState({required this.cwStatus, required this.fwStatus});

  WeatherState copyWith({CwStatus? newCwStatus, FwStatus? newFwStatus}) {
    return WeatherState(
        cwStatus: newCwStatus ?? cwStatus,
        fwStatus: newFwStatus ?? fwStatus);
  }

  @override
  List<Object?> get props => [cwStatus, fwStatus];
}
