import 'package:clean_arcitecture_flutter_sample/core/widgets/app_background.dart';
import 'package:clean_arcitecture_flutter_sample/core/widgets/bottom_nav.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_weather/presentation/screens/weather_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final pageController = PageController(initialPage: 0);
  List<Widget> pageViewWidgets = [
    const WeatherScreen(),
    const BookMarkScreen()
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(
        pageController: pageController,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AppBackground.getBackGroundImage(),
              fit: BoxFit.cover),
        ),
        height: height,
        child: PageView(
          controller: pageController,
          children: pageViewWidgets,
        ),
      ),
    );
  }
}
