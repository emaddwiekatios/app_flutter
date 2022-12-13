import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/resource/StringManager.dart';
import 'Home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// const CURVE_HEIGHT = 160.0;
// const AVATAR_RADIUS = CURVE_HEIGHT * 0.28;
// const AVATAR_DIAMETER = AVATAR_RADIUS * 2;
Color colorOne = Colors.amber;
Color colorTwo = ColorManager.primary;
Color colorThree = ColorManager.primary;

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: GetDrower(context),
      key: scaffoldKey,

      body: GestureDetector(
        onTap: () {

          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: <Widget>[
            //header shape
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Container(
            //     height: MediaQuery
            //         .of(context)
            //         .size
            //         .height / 4,
            //     width: MediaQuery
            //         .of(context)
            //         .size
            //         .width,
            //     decoration: BoxDecoration(
            //       //borderRadius: BorderRadius.circular(200),
            //       //  color: Colors.amber,
            //     ),
            //     child: CustomPaint(
            //       child: Container(
            //         height: 400.0,
            //       ),
            //       painter: _MyPainter(),
            //     ),
            //   ),
            // ),
            /*
            Positioned(
              top: 125,
              left: -150,
              child: Container(
                height: 450, //MediaQuery.of(context).size.height / 4,
                width: 450, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250),
                  color: Colors.amber,
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 115,
              child: Container(
                height: 350, //MediaQuery.of(context).size.height / 4,
                width: 350, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.amber),
              ),
            ),
            */
            //a
            // Positioned(
            //   bottom: -125,
            //   left: -150,
            //   child: Container(
            //     height: 250, //MediaQuery.of(context).size.height / 4,
            //     width: 250, //MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(250),
            //       color: ColorManager.primary,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: -100,
            //   right: -115,
            //   child: Container(
            //     height: 250, //MediaQuery.of(context).size.height / 4,
            //     width: 250, //MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(200),
            //         color: ColorManager.primary),
            //   ),
            // ),
            //menu
            Positioned(
              top: AppSize.s4,
              left: -AppSize.s4,
              child: IconButton(
                icon:  Icon(Icons.menu,color: ColorManager.grey2,),
                onPressed: () {
                  //print('inside button');
                   scaffoldKey.currentState!.openDrawer();

                //  Navigator.pushReplacementNamed(context, "/ProductsMain");
                },
              ),
            ),
            Positioned(
              top: AppSize.s4,
              right: -AppSize.s4,
              child: Row(
                children: [
                  IconButton(
                    icon:  Icon(Icons.notification_add_sharp,color: ColorManager.grey2,),
                    onPressed: () {
                      Navigator.pop(context);
                      //  Navigator.popAndPushNamed(context, "/SignIn");

                      //Navigator.pushReplacementNamed(context, "/SignIn");
                    },
                  ),
                  IconButton(
                    icon:  Icon(Icons.shopping_cart_outlined,color: ColorManager.grey2,),
                    onPressed: () {
                      //print('inside button');
                      // FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      //  Navigator.popAndPushNamed(context, "/SignIn");

                      //Navigator.pushReplacementNamed(context, "/SignIn");
                    },
                  ),
                ],
              ),
            ),
            //body
            Positioned(
              top: get_height(context) / FontManagerSize.s14,
              right: 0,
              bottom: 20,
              child: SizedBox(
                  //color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height >= 775.0
                      ? MediaQuery.of(context).size.height
                      : 775.0,
                  /* decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.red,
                            Colors.orange

                            //Color(getColorHexFromStr('#FDD100')),
                             //Color(getColorHexFromStr('#FDD120'))
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
*/
                  child:

                  (MediaQuery.of(context).orientation ==Orientation.portrait) ?
                 const GetPortraitOrient()
                :const GetLandScapeOrient(),



              )


              ,
            ),
            //header title
            // Positioned(
            //   top: MediaQuery.of(context).size.height / 18,
            //   left: MediaQuery.of(context).size.width / 2 - 50,
            //   child: Text('Details'
            //     //AppLocalizations.of(context).translate('Details'),
            //     ,style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = ColorManager.primary;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width / 2, size.height / 1, size.width, size.height * 0.4);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WidgetCategory extends StatelessWidget {
  const WidgetCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Card(

          shape: RoundedRectangleBorder(
              side:BorderSide(color: ColorManager.primary,width: AppSize.s0_5)
              ,borderRadius:BorderRadius.circular(270)),

          child: const CircleAvatar(
            radius: AppSize.s40,
            backgroundImage: ExactAssetImage(AssetManager.splash3),
          ),
        ),
         const Text('Mad')
        //  backgroundImage:  (AssetManager.onBoarding3,fit: BoxFit.cover))
      ],
    );
  }
}

class GetCarouselSlider extends StatelessWidget {
  //class ImageSliderDemo extends StatelessWidget {
  final List<String> imgList = [

    AssetManager.splash1,
    AssetManager.splash2,
    AssetManager.splash3,
    AssetManager.splashLogo
  ];

   GetCarouselSlider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),color: Colors.transparent,

        ),
          //color: Colors.red,
          height: get_height(context)* .5,
          width: get_width(context) *.95,
          child: CarouselSlider(
            items: imgList
                .map((p) =>
                Card(

                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.primary,
                        width: AppSize.s0_5),
                  ),
                  elevation: AppSize.s0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(fit: BoxFit.fill,
                          image: ExactAssetImage( p,
                           // width: MediaQuery.of(context).
                            // size.width,
                            //fit: BoxFit.cover,
                          )

                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),

                  ),
                ),
            )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),

              viewportFraction: 1.0,
              enlargeCenterPage: false,
              initialPage: 0,
              onPageChanged: (index, reason) {
                // setState(() {
                //   currentIndex = index;
                //   _product = _products[index];
                // });
              },
            ),
          ),
      ),
    );
  }
}


class GetPortraitOrient extends StatelessWidget {
  const GetPortraitOrient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: AppSize.s6, right: AppSize.s6),
          child: TextFormField(
            showCursor: true,
            // readOnly: true,
            //controller: controllerLoginUserName,
            decoration: InputDecoration(
                label: Text(StringManager.search.tr),
                hintText: StringManager.userNameHint.tr,
                //  prefix: Text(StringManager.userName),
                prefixIcon: const Icon(Icons.search),
                // errorText: (snapshot.data ?? true)
                //     ? null
                //     : StringManager.usernameError,
                suffix: Text(StringManager.userName.tr),
                //  suffixText: StringManager.userName,
                suffixIcon: const Icon(Icons.remove_red_eye_outlined)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s4),
          child:  SizedBox(
            //  color: Colors.red,
            height: get_height(context) / FontManagerSize.s7,
            width: get_width(context),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, int index) {
                  return const Center(child: WidgetCategory());
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s4),
          child: Container(
            margin: const EdgeInsets.all(AppSize.s0_5),
            decoration: BoxDecoration(
              //color: Colors.red,
                borderRadius: BorderRadius.circular(10)),

            height: get_height(context) / AppSize.s6,
            width: get_width(context),
            child: GetCarouselSlider(),
            //child:Cal
          ),
        ),
        Expanded(
          child: Padding(
            padding:  const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
               
              ),
              width: get_width(context),//FontManagerSize.s3,
              //color:Colors.blue,
              child:GridView.builder(
                  itemBuilder :(context ,int index )
              {
                return Card(elevation: 10,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.primary,
                          width: AppSize.s0_5),
                      borderRadius: const  BorderRadius.all(Radius.circular(AppSize.s8))),

                  //borderOnForeground: true,
                  child: Column(
                    children: [

                           Container(
                             height: 80,width: 80,

                             decoration: BoxDecoration(

                               borderRadius: BorderRadius.circular(5),
                                 image: const DecorationImage(fit:BoxFit.cover ,
                                   image:  AssetImage(AssetManager.splash2,)
                                 ),
                               color:Colors.limeAccent,
                             ),

                           ),
//                          CircleAvatar(
//
//                            backgroundImage: ExactAssetImage(AssetManager.splash2)
//
// ,radius: 50,
//                          ),

                     const  Text('rrr'),
                     const  Text('hello')
                    ],
                  ),
                );
              },
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,

                ),)
            ),
          ),
        )
      ],
    );
  }
}



class GetLandScapeOrient extends StatelessWidget {
  const GetLandScapeOrient({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: FontManagerSize.s12,
              left: AppSize.s6, right: AppSize.s6),
          child: TextFormField(
            showCursor: true,
            // readOnly: true,
            //controller: controllerLoginUserName,
            decoration: InputDecoration(
                label: Text(StringManager.search.tr),
                hintText: StringManager.userNameHint.tr,
                //  prefix: Text(StringManager.userName),
                prefixIcon: const Icon(Icons.search),
                // errorText: (snapshot.data ?? true)
                //     ? null
                //     : StringManager.usernameError,
                suffix: Text(StringManager.userName.tr),
                //  suffixText: StringManager.userName,
                suffixIcon: const Icon(Icons.remove_red_eye_outlined)),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSize.s4),
              child:  SizedBox(
                //  color: Colors.red,
                height: get_height(context) * .6,
                width: get_width(context) * .25,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, int index) {
                      return const Center(child: WidgetCategory());
                    }),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSize.s4),
                  child: Container(
                    margin: const EdgeInsets.all(AppSize.s0_5),
                    decoration: BoxDecoration(
                      //color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),

                    height: get_height(context) *.25,
                    width: get_width(context) *.7,
                    child: GetCarouselSlider(),
                    //child:Cal
                  ),
                ),
                Container(
                  height: get_height(context)*.35,
                  width: get_width(context)* .7,//FontManagerSize.s3,
                  color:Colors.blue,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

