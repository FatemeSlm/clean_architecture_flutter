import 'package:clean_arcitecture_flutter_sample/core/params/forecast_params.dart';
import 'package:clean_arcitecture_flutter_sample/core/widgets/app_background.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/domain/usecases/get_suggest_city_usecase.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/date_converter.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../../../locator.dart';
import '../../data/models/forecast_days_model.dart';
import '../../domain/entities/forecast_days_entiry.dart';
import '../widgets/day_weather_view.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = 'Tehran';
  final pageController = PageController(initialPage: 0);
  TextEditingController textEditingController = TextEditingController();
  GetSuggestCityUseCase getSuggestCityUseCase =
      GetSuggestCityUseCase(locator());

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(LoadCWEvent(cityName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              onSubmitted: (String prefix) {
                textEditingController.text = prefix;
                BlocProvider.of<WeatherBloc>(context).add(LoadCWEvent(prefix));
              },
              controller: textEditingController,
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                hintText: "Enter a City...",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            suggestionsCallback: (String pattern) {
              return getSuggestCityUseCase(pattern);
            },
            itemBuilder: (BuildContext context, Data itemData) {
              return ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(itemData.name!),
                subtitle: Text('${itemData.region!}, ${itemData.country!}'),
              );
            },
            onSuggestionSelected: (Data suggestion) {
              textEditingController.text = suggestion.name!;
              BlocProvider.of<WeatherBloc>(context)
                  .add(LoadCWEvent(suggestion.name!));
            },
          ),
        ),

        /// main ui
        BlocBuilder<WeatherBloc, WeatherState>(
          buildWhen: (previous, current) {
            if (previous.cwStatus == current.cwStatus) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state.cwStatus is CwLoading) {
              return const Expanded(child: DotLoadingWidget());
            }
            if (state.cwStatus is CwCompleted) {
              final currentCityEntity =
                  (state.cwStatus as CwCompleted).currentCityEntity;

              /// call fw event
              BlocProvider.of<WeatherBloc>(context).add(LoadFWEvent(
                  ForecastParams(currentCityEntity.coord!.lat!,
                      currentCityEntity.coord!.lon!)));

              /// change Times to Hour --5:55 AM/PM----
              final sunrise = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunrise, currentCityEntity.timezone);
              final sunset = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunset, currentCityEntity.timezone);

              return Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: SizedBox(
                      width: width,
                      height: 400,
                      child: PageView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        allowImplicitScrolling: true,
                        controller: pageController,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Text(
                                    currentCityEntity.name!,
                                    style: const TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    currentCityEntity.weather![0].description!,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: AppBackground.setIconForMain(
                                      currentCityEntity
                                          .weather![0].description!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    '${currentCityEntity.main!.temp!.round()}\u00B0',
                                    style: const TextStyle(
                                        fontSize: 50, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// max temp
                                      Column(
                                        children: [
                                          const Text(
                                            'max',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${currentCityEntity.main!.tempMax!.round()}\u00B0',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),

                                      /// divider
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          color: Colors.grey,
                                          width: 2,
                                          height: 40,
                                        ),
                                      ),

                                      /// temp min
                                      Column(
                                        children: [
                                          const Text(
                                            'min',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${currentCityEntity.main!.tempMin!.round()}\u00B0',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container(
                              color: Colors.amber,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                      effect: const ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          spacing: 5,
                          activeDotColor: Colors.white),
                      onDotClicked: (index) =>
                          pageController.animateToPage(index,
                              duration: const Duration(
                                microseconds: 500,
                              ),
                              curve: Curves.bounceOut),
                    ),
                  ),

                  /// divider
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      color: Colors.white24,
                      height: 2,
                      width: double.infinity,
                    ),
                  ),

                  /// forecast weather 7 days
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Center(
                          child: BlocBuilder<WeatherBloc, WeatherState>(
                            builder: (BuildContext context, state) {
                              /// show Loading State for Fw
                              if (state.fwStatus is FwLoading) {
                                return const DotLoadingWidget();
                              }

                              /// show Completed State for Fw
                              if (state.fwStatus is FwCompleted) {
                                /// casting
                                final FwCompleted fwCompleted =
                                    state.fwStatus as FwCompleted;
                                final ForecastDaysEntity forecastDaysEntity =
                                    fwCompleted.forecastDaysEntity;
                                final List<Daily> mainDaily =
                                    forecastDaysEntity.daily!;

                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 8,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    return DaysWeatherView(
                                      daily: mainDaily[index],
                                    );
                                  },
                                );
                              }

                              /// show Error State for Fw
                              if (state.fwStatus is FwError) {
                                final FwError fwError =
                                    state.fwStatus as FwError;
                                return Center(
                                  child: Text(
                                    fwError.message,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }

                              /// show Default State for Fw
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// divider
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      color: Colors.white24,
                      height: 2,
                      width: double.infinity,
                    ),
                  ),
                ],
              ));
            }
            if (state.cwStatus is CwError) {
              final CwError cwError = state.cwStatus as CwError;
              return Center(
                child: Text(
                  cwError.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox();
          },
        )
      ],
    ));
  }
}
