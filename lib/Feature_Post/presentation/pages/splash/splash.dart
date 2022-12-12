

import 'dart:async';

import 'package:clean_arch_app/Feature_Post/presentation/pages/Onbording/View_Onboarding/onbording.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/RoutesManager.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}
Timer? _timer;

starttimer(BuildContext context)
{
  _timer=Timer(  const  Duration(seconds: 5), () {
    Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute); });
}



class _splashState extends State<splash> {
  @override
  void initState() {
    starttimer(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Container(
        width: get_width(context),
        height: get_height(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetManager.splashLogo)
          )
        ),
      )),
    );
  }


}
