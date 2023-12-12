import 'package:clean_arch_app/Feature_Post/presentation/pages/Favarite/Favarite.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/Home.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/ValueManger.dart';
import '../Carts/Carts.dart';
import 'TypeMain.dart';
import 'TypesReport/TypeSummary.dart';

class PreTypeMain extends StatefulWidget {
  const PreTypeMain({super.key});

  @override
  _PreTypeMainState createState() => _PreTypeMainState();
}

class _PreTypeMainState extends State<PreTypeMain> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: [
        TypeMainNew(),
        TypeSummary(),
        TypeMainNew(),
        TypeMainNew()
      ][_currentIndex],
      bottomNavigationBar: SizedBox(
        height: getHeight(context) / FontManagerSize.s17,
        child: BottomNavigationBar(
          selectedFontSize: AppSize.s10,
          unselectedFontSize: AppSize.s10,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: AppSize.s14,
                ),
                backgroundColor: ColorManager.primary,
                icon: const Icon(
                  Icons.home,
                  color: Colors.black,
                  size: AppSize.s18,
                ),
                label: 'Home',
                tooltip: 'Home'),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: AppSize.s14,
              ),
              backgroundColor: ColorManager.primary,
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
                size: AppSize.s18,
              ),
              label: 'Summary',
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: AppSize.s14,
              ),
              backgroundColor: ColorManager.primary,
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
                size: AppSize.s18,
              ),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.search,
                color: Colors.white,
                size: AppSize.s14,
              ),
              backgroundColor: ColorManager.primary,
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: AppSize.s18,
              ),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
