import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/entities/forecast_days_entiry.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FwStatus extends Equatable {}

class FwLoading extends FwStatus {
  @override
  List<Object?> get props => [];
}

class FwCompleted extends FwStatus {
  final ForecastDaysEntity forecastDaysEntity;

  FwCompleted(this.forecastDaysEntity);

  @override
  List<Object?> get props => [forecastDaysEntity];
}

class FwError extends FwStatus {
  final String message;

  FwError(this.message);

  @override
  List<Object?> get props => [message];
}
