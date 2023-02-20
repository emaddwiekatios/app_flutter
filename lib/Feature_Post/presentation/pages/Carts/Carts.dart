// ignore_for_file: library_private_types_in_public_api

import 'package:clean_arch_app/Feature_Post/presentation/pages/Carts/Cartsceil.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/AssetManager.dart';
import '../Products/ProductsClass.dart';

class Carts extends StatefulWidget {
  const Carts({super.key});

  @override
  _CartsState createState() => _CartsState();
}

const curveHeight = 160.0;
const avatarRadius = curveHeight * 0.28;
const avatarDiameter = avatarRadius * 2;
Color colorOne = Colors.amber;
Color colorTwo = ColorManager.primary;
Color colorThree = ColorManager.primary;

class _CartsState extends State<Carts> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  // Color pyellow = Color(Colors.amber);

  ////  add  keyboard action

  // final FocusNode _nodeText1 = FocusNode();
  // final FocusNode _nodeText2 = FocusNode();
  // final FocusNode _nodeText3 = FocusNode();
  // final FocusNode _nodeText4 = FocusNode();
  // final FocusNode _nodeText5 = FocusNode();
  // final FocusNode _nodeText6 = FocusNode();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  // KeyboardActionsConfig _buildConfig(BuildContext context) {
  //   return KeyboardActionsConfig(
  //     keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
  //     keyboardBarColor: Colors.grey[200],
  //     nextFocus: true,
  //     actions: [
  //       KeyboardActionsItem(
  //         focusNode: _nodeText1,
  //       ),
  //       KeyboardActionsItem(focusNode: _nodeText2, toolbarButtons: [
  //             (node) {
  //           return GestureDetector(
  //             onTap: () => node.unfocus(),
  //             child: Padding(
  //               padding: EdgeInsets.all(8.0),
  //               child: Icon(Icons.close),
  //             ),
  //           );
  //         }
  //       ]),
  //       KeyboardActionsItem(
  //         focusNode: _nodeText3,
  //         onTapAction: () {
  //           showDialog(
  //               context: context,
  //               builder: (context) {
  //                 return AlertDialog(
  //                   content: Text("Custom Action"),
  //                   actions: <Widget>[
  //                     FlatButton(
  //                       child: Text("OK"),
  //                       onPressed: () => Navigator.of(context).pop(),
  //                     )
  //                   ],
  //                 );
  //               });
  //         },
  //       ),
  //       KeyboardActionsItem(
  //         focusNode: _nodeText4,
  //         // displayCloseWidget: false,
  //       ),
  //       KeyboardActionsItem(
  //         focusNode: _nodeText5,
  //         toolbarButtons: [
  //           //button 1
  //               (node) {
  //             return GestureDetector(
  //               onTap: () => node.unfocus(),
  //               child: Container(
  //                 color: Colors.white,
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Text(
  //                   "CLOSE",
  //                   style: TextStyle(color: Colors.black),
  //                 ),
  //               ),
  //             );
  //           },
  //           //button 2
  //               (node) {
  //             return GestureDetector(
  //               onTap: () => node.unfocus(),
  //               child: Container(
  //                 color: Colors.black,
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Text(
  //                   "DONE",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             );
  //           }
  //         ],
  //       ),
  //       KeyboardActionsItem(
  //         focusNode: _nodeText6,
  //         footerBuilder: (_) => PreferredSize(
  //             child: SizedBox(
  //                 height: 40,
  //                 child: Center(
  //                   child: Text('Custom Footer'),
  //                 )),
  //             preferredSize: Size.fromHeight(40)),
  //       ),
  //     ],
  //   );
  // }

//note  add  code on text field
//  KeyboardActions(
//  config: _buildConfig(context),
  //child:widget
  // add on text field  focusNode: _nodeText1,

  ///// end add  keyboard action
  List<ProductClass> instCartsList=[];
@override
  void initState() {
    // TODO: implement initState
  loadCartsinit();
    super.initState();
  }
  void loadCartsinit() {
    instCartsList.clear();
    instCartsList.add(ProductClass(productId: 1,
        productName: 'T-shirt',
        productImage: AssetManager.mancat,
        productPrice: 16,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
    instCartsList.add(ProductClass(productId: 2,
        productName: 'Jaket',
        productImage: AssetManager.mancat3,
        productPrice: 50,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
    instCartsList.add(ProductClass(productId: 3,
        productName: 'Jeans',
        productImage: AssetManager.mancat4,
        productPrice: 100,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
    instCartsList.add(ProductClass(productId: 4,
        productName: 'Body',
        productImage: AssetManager.mancat5,
        productPrice: 400,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
    instCartsList.add(ProductClass(productId: 5,
        productName: 'T-shttirt',
        productImage: AssetManager.mancat,
        productPrice: 616,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
    instCartsList.add(ProductClass(productId: 6,
        productName: 'Jaketttt',
        productImage: AssetManager.mancat3,
        productPrice: 560,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
    instCartsList.add(ProductClass(productId: 7,
        productName: 'Jeattns',
        productImage: AssetManager.mancat4,
        productPrice: 1600,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
    instCartsList.add(ProductClass(productId: 8,
        productName: 'Bodtty',
        productImage: AssetManager.mancat5,
        productPrice: 4060,
        productCat: 'Clothes',
        productEntryDate: DateTime.now()));
  }
    @override
  Widget build(BuildContext context) {
    var pHeight = MediaQuery.of(context).size.height;
    var pWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,

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
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.circular(200),
                  //  color: Colors.amber,
                ),
                child: CustomPaint(
                  painter: _MyPainter(),
                  child: Container(
                    height: 400.0,
                  ),
                ),
              ),
            ),
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
            Positioned(
              bottom: -125,
              left: -150,
              child: Container(
                height: 250, //MediaQuery.of(context).size.height / 4,
                width: 250, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250),
                  color: ColorManager.primary,
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              right: -115,
              child: Container(
                height: 250, //MediaQuery.of(context).size.height / 4,
                width: 250, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: ColorManager.primary),
              ),
            ),
            //menu
            Positioned(
              top: pHeight / 25,
              left: pWidth / 20,
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // print('inside button');
                  // _scaffoldKey.currentState.openDrawer();

                  Navigator.pushReplacementNamed(context, "/PreHome");
                },
              ),
            ),
            Positioned(
              top: pHeight / 25,
              right: pWidth / 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  //print('inside button');
                  // FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  //  Navigator.popAndPushNamed(context, "/SignIn");

                  //Navigator.pushReplacementNamed(context, "/SignIn");
                },
              ),
            ),
            //body
            Positioned(
              top: pHeight / 10,
              right: 0,
              bottom: 20,
              child: SizedBox(
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
                  child:  Center(
                      child: ListView.builder(
                      itemCount: instCartsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print('insdie int ');
                        return   CartsCeil(instCarts: instCartsList[index],);
                      },
                    ),
                  )//hgjghjg   hj
/*
FutureBuilder<List<UserModel>>(
future: db.getUserModelData(),
builder: (context, snapshot) {
if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
*/

              ),
            ),
            //header title
            Positioned(
              top: MediaQuery.of(context).size.height / 18,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: const Text(
                'Details'
                //AppLocalizations.of(context).translate('Details'),
                ,
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.deepOrangeAccent;
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
