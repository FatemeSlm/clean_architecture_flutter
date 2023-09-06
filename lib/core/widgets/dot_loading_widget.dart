import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DotLoadingWidget extends StatelessWidget {
  const DotLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.halfTriangleDot(
        color: Colors.white, size: 50);
  }
}
