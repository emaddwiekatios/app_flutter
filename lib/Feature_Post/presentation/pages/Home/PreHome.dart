
import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/Home.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/ValueManger.dart';
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
      bottomNavigationBar:
      SizedBox(height:FontManagerSize.s50, child:BottomNavigationBar(


          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items:  [
            BottomNavigationBarItem(


              activeIcon:  const Icon(Icons.home,color: Colors.white,size: AppSize.s14,),
              backgroundColor: ColorManager.primary,
              icon: const Icon(Icons.home,color: Colors.black,size: AppSize.s18,),
              label: 'Home',

              tooltip: 'Home'
            ),
            BottomNavigationBarItem(
              activeIcon:  const Icon(Icons.shopping_cart,color: Colors.white,size: AppSize.s14,),

              backgroundColor: ColorManager.primary,
              icon: const  Icon(Icons.shopping_cart,color: Colors.black,size: AppSize.s18,),
              label: 'Carts',
            ),
            BottomNavigationBarItem( activeIcon:  const Icon(Icons.favorite_border,color: Colors.white,size: AppSize.s14,),

              backgroundColor: ColorManager.primary,
              icon: const Icon(Icons.favorite_border,color: Colors.black,size: AppSize.s18,),
              label: 'Favorite',
            ),
            BottomNavigationBarItem( activeIcon:  const Icon(Icons.search,color: Colors.white,size: AppSize.s14,),

              backgroundColor: ColorManager.primary,
              icon: Icon(Icons.search,color: Colors.black,size: AppSize.s18,),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
