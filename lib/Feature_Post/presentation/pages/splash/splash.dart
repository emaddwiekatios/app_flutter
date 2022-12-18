import 'dart:async';

import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/RoutesManager.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

Timer? _timer;

starttimer(BuildContext context) {
  _timer = Timer(const Duration(seconds: 5), () {
    Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);
  });
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    starttimer(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: get_width(context),
        height: get_height(context),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetManager.splashLogo))),
      )),
    );
  }
}
