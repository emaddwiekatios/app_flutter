/*import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/view_login.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Onbording/View_Onboarding/onbording.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/splash/splash.dart';
import 'package:flutter/material.dart';

import '../../Feature_Post/presentation/pages/GetxManagement/GetxMangment.dart';
import '../../Feature_Post/presentation/pages/Home/Home.dart';
import '../../Feature_Post/presentation/pages/LayoutBuilder/LayoutBuilder.dart';
import 'StringManager.dart';

class RoutesManager {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  // static const String onBoarding2Route = "/onBoarding2";
  static const String loginRoute = "/login";
  static const String homeRoute = "/home";
  static const String layoutbuilderRoute = "/layoutBuilder";
  static const String getxbuilder = "/GetxManagement";
  // static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesManager.splashRoute:
        return MaterialPageRoute(builder: (_) => const Splash());
      case RoutesManager.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case RoutesManager.loginRoute:
        return MaterialPageRoute(builder: (_) => const login());

      case RoutesManager.homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case RoutesManager.layoutbuilderRoute:
        return MaterialPageRoute(builder: (_) => const GetLayoutBuilder());
      case RoutesManager.getxbuilder:
        return MaterialPageRoute(builder: (_) => GetxManagement());
      // case RoutesManager.storeDetailsRoute:
      //   return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                // title: Text("No Route Found"),
                title: Text(StringManager.noRouteFound),
              ),
              // body: Center(child: Text("No Route Found")),
              body: const Center(child: Text(StringManager.noRouteFound)),
            ));
  }
}
*/