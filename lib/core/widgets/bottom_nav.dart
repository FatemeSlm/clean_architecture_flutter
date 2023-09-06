import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final PageController pageController;

  const BottomNav({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  pageController.animateTo(0,
                      duration: const Duration(microseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.home)),
            IconButton(
                onPressed: () {
                  pageController.animateTo(1,
                      duration: const Duration(microseconds: 300),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.bookmark))
          ],
        ),
      ),
    );
  }
}
