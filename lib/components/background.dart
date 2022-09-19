import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

// ignore: must_be_immutable
class BackgroundChager extends StatelessWidget {
  dynamic widget;
  Color particleColor, randColorList;
  BackgroundChager(
      {super.key,
      required this.widget,
      required this.particleColor,
      required this.randColorList});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
        child: Stack(
      children: [
        CircularParticle(
          key: UniqueKey(),
          awayRadius: 9,
          numberOfParticles: 30,
          speedOfParticles: 1,
          height: screenHeight,
          width: screenWidth,
          onTapAnimation: true,
          particleColor: particleColor,
          awayAnimationDuration: const Duration(milliseconds: 600),
          maxParticleSize: 5,
          isRandSize: true,
          isRandomColor: true,
          randColorList: [randColorList],
          awayAnimationCurve: Curves.easeInOutBack,
          enableHover: false,
          connectDots: true,
        ),
        widget
      ],
    ));
  }
}
