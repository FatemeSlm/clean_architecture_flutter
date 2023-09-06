import 'package:clean_arcitecture_flutter_sample/core/widgets/app_background.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/widgets/dot_loading_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = 'Tehran';
  final pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<WeatherBloc>(context).add(LoadCWEEvent(cityName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Column(
      children: [
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state.cwStatus is CwLoading) {
              return const Expanded(child: DotLoadingWidget());
            }
            if (state.cwStatus is CwCompleted) {
              final currentCityEntity =
                  (state.cwStatus as CwCompleted).currentCityEntity;
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
                  )
                ],
              ));
            }
            if (state.cwStatus is CwError) {}
            return const SizedBox();
          },
        )
      ],
    ));
  }
}
