import 'package:clean_arch_app/Feature_Post/presentation/pages/Add/Pageview_item.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/Construct.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/material.dart';

class AddPages extends StatefulWidget {
  const AddPages({super.key});

  @override
  State<AddPages> createState() => _AddPagesState();
}

class _AddPagesState extends State<AddPages> {
  PageController _pageController = PageController();
  int currentpage = 0;

  List<Colors> listname = [Colors.black12, "yyy", "jjjj", 'jkjkj'];
  @override
  void initState() {
    _pageController = PageController(initialPage: currentpage);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //  color: Colors.amber,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Center(child: Text("emad$index"));
              },
              // onPageChanged: (value) {
              //   setState(() {
              //     //  _pageController = PageController(initialPage: value);
              //   });
              //},
            ),
          ),
          // Positioned(
          //   left: getWidth(context) / 1,
          //   top: getWidth(context) * (5 / 100),
          //   child: Container(height: 200, width: 254, color: Colors.black45),

          //   // IconButton(
          //   //   icon: Icon(Icons.menu),
          //   //   onPressed: () {
          //   //     Navigator.pop(context);
          //   //   },
          //   // )
          // ),

          Positioned(
            left: getWidth(context) / 2,
            bottom: getWidth(context) * (5 / 100),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      nextpage();
                    },
                    child: Text('Next')),
                ElevatedButton(
                    onPressed: () {
                      backpage();
                    },
                    child: Text('back')),
              ],
            ),
          )
        ],
      ),
    );
  }

  void nextpage() {
    print(currentpage);
    if (currentpage < 3) {
      currentpage = currentpage + 1;
      _pageController.animateToPage(
          duration: const Duration(microseconds: 100),
          curve: Curves.bounceIn,
          currentpage);
    }
  }

  void backpage() {
    print(currentpage);
    if (currentpage <= 3 && currentpage >= 0) {
      currentpage = currentpage - 1;
      _pageController.animateToPage(
          duration: const Duration(microseconds: 100),
          curve: Curves.bounceIn,
          currentpage);
    }
  }
}
