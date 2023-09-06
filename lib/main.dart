import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:clean_arcitecture_flutter_sample/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/widgets/main_wrapper.dart';

void main() async {
  /// setup locator
  await setup();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<WeatherBloc>())
        ],
        child: const MainWrapper()),
  ));
}
