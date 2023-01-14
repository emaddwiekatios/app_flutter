
import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/Home.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:flutter/material.dart';

import '../Carts/Carts.dart';
class PreHome extends StatefulWidget {
  @override
  _PreHomeState createState() => _PreHomeState();
}

class _PreHomeState extends State<PreHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        Home(),
        Carts(),
        Carts(),
        Carts()

      ][ _currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
          BottomNavigationBarItem(
            backgroundColor: ColorManager.primary,
            icon: const Icon(Icons.home,color: Colors.black,),
            label: 'Home',
            tooltip: 'Home'
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.primary,
            icon: const  Icon(Icons.search,color: Colors.black,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.primary,
            icon: const Icon(Icons.search,color: Colors.black,),
            label: 'Search1',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.primary,
            icon: Icon(Icons.search,color: Colors.black,),
            label: 'Search2',
          ),
        ],
      ),
    );
  }
}
