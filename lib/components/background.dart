
import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class BackgroundChnger extends StatelessWidget {
  dynamic widget;
  BackgroundChnger({super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    dynamic dataNew = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png", width: 350, height: 300),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ]);
    return Center(
        child: Stack(
      children: [
        CircularParticle(
          key: UniqueKey(),
          awayRadius: 5,
          numberOfParticles: 250,
          speedOfParticles: 1,
          height: screenHeight,
          width: screenWidth,
          onTapAnimation: true,
          particleColor: Color.fromARGB(255, 137, 103, 45).withAlpha(150),
          awayAnimationDuration: const Duration(milliseconds: 600),
          maxParticleSize: 7,
          isRandSize: true,
          isRandomColor: true,
          randColorList: const [Color.fromARGB(255, 49, 127, 0)],
          awayAnimationCurve: Curves.easeInOutBack,
          enableHover: false,
          connectDots: true, //not recommended
        ),
        widget
        
        
      ],
    ));
  }
}
