import 'package:clean_arch_app/Feature_Post/presentation/pages/Add/Pageview_item.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/onbording/View_Onboarding/onbording.dart';
import 'package:clean_arch_app/core/resource/Construct.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';

class testing extends StatefulWidget {
  const testing({super.key});

  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
  PageController? _pageController;
  int counter = 0;
  @override
  void initstate() {
    _pageController = PageController(initialPage: counter);
    super.initState();
  }

  @override
  void dispose() {
    // _pageController!.dispose();
    super.dispose();
  }

  final List<int> _pages = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.cyanAccent,
          child: Stack(
            children: [
              Positioned(
                  top: getHeight(context) / 30,
                  left: getWidth(context) / 70,
                  right: getWidth(context) / 70,
                  child: Container(
                    color: Colors.cyan[300],
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(Icons.menu),
                          Spacer(),
                          Text('Header'),
                          Spacer(),
                          Icon(Icons.details)
                        ],
                      ),
                    )),
                  )),
              Positioned(
                  top: (getHeight(context) / 10),
                  left: getWidth(context) / 70,
                  right: getWidth(context) / 70,
                  child: Container(
                    color: Colors.cyan,
                    height: getHeight(context) / 1.23,
                    width: getWidth(context),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PageViewItem(AssetManager.onBoarding1,
                            'emad${_pages[index]}', 'fdfdff');
                      },
                      onPageChanged: ((value) {
                        counter = counter + value;
                        _pageController!.animateToPage(counter,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOutCirc);
                      }),
                    ),
                  )),
              Positioned(
                  bottom: 50,
                  left: getWidth(context) / 70,
                  right: getWidth(context) / 70,
                  child: Container(
                      color: Colors.cyan,
                      height: getHeight(context) / 30,
                      width: getWidth(context),
                      child: defaltElevationButton(
                        nameButton: 'next',
                        heightButton: 50,
                        onTabButton: () {
                          print('iiiiiiiiiiiiiiii');
                          setState(() {
                            counter = counter + 1;
                          });
                          print(counter);
                          // if (counter < 500) {
                          //   setState(() {
                          //     counter = counter + 1;
                          //   });
                          //   print(counter);
                          // }
                        },
                        parBackGroundColor: Colors.red,
                        parBorderRadius: 4,
                        parFontSize: 20,
                        parBorderWidth: 1,
                        parForegroundColor: Colors.blue,
                        widthButton: 200,
                      )))
            ],
          )),
    );
  }

  void nextpage() {
    _pageController!.animateToPage(counter,
        duration: Duration(milliseconds: 400), curve: Curves.easeInBack);
  }
}
