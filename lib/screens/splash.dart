import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../components/background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BackgroundChager(
        particleColor: const Color.fromARGB(255, 128, 128, 128).withAlpha(150),
        randColorList: const Color.fromARGB(255, 105, 105, 105),
        widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Lottie.asset("assets/images/splash.json",
                      width: 350, height: 300)),
              AnimatedTextKit(animatedTexts: [
                TyperAnimatedText('Welcome To The',
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        backgroundColor: Colors.lightGreen)),
                TyperAnimatedText('INDUCED OFFICIAL',
                    textStyle: const TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.lightGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ], onTap: null),
            ]),
      ),
    );
  }
}
