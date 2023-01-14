import 'dart:async';

import 'package:clean_arch_app/Feature_Post/presentation/pages/Onbording/View_Onboarding/onbording.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';

import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}



Timer? _timer;

starttimer(BuildContext context) {
  _timer = Timer(const Duration(seconds: 5),
      // () => Navigator.pushReplacement(
      // context,
      // MaterialPageRoute(
      //   builder: (context) => const OnBoarding(),
      // ))

          () {
   // Navigator?.pushReplacement(context, MaterialPageRoute(builder: (_)=>const OnBoarding(),),);
    //Get.to(()=>OnBoarding());
   //Navigator.pushNamed(context, '/Onboarding');
     Navigator.pushReplacementNamed(context, '/Onboarding');
    // Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);
  }

  );
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    starttimer(context);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: getWidth(context),
        height: getHeight(context),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetManager.splashLogo))),
      )),
    );
  }
}
