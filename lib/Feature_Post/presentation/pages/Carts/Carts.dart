// ignore_for_file: library_private_types_in_public_api

import 'package:clean_arch_app/Feature_Post/presentation/pages/Carts/Cartsceil.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/Construct.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';


import '../../../../core/resource/AssetManager.dart';
import '../../../../core/resource/StringManager.dart';
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
var _carts=getCollectionReference(StringManager.collection_Carts);
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
  //               child: const Icon(Icons.close),
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

  //get_sumitem();
    super.initState();
  }

  var sumItem=0.0;
  var noItem=0;
  // void get_sumitem()
  // {
  //
  //   for(int i =0 ;i<instCartsList.length;i++)
  //     {
  //       sumItem=(sumItem+ instCartsList[i].productPrice) ;
  //
  //     }
  //   noItem=instCartsList.length;
  
  // }
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
      /*  Positioned(
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
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  ////print('inside button');
                  // _scaffoldKey.currentState.openDrawer();

                  Navigator.pushReplacementNamed(context, "/PreHome");
                },
              ),
            ),
            // Positioned(
            //   top: pHeight / 25,
            //   right: pWidth / 20,
            //   child: IconButton(
            //     icon: const Icon(Icons.arrow_back),
            //     onPressed: () {
            //       //print('inside button');
            //       // FirebaseAuth.instance.signOut();
            //       Navigator.pop(context);
            //       //  Navigator.popAndPushNamed(context, "/SignIn");
            //
            //       //Navigator.pushReplacementNamed(context, "/SignIn");
            //     },
            //   ),
            // ),
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
                  child:  Center(
                      child: StreamBuilder(
                        stream: getCollectionReference(StringManager.collection_Carts).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {




                          if (snapshot.hasData) {

                            instCartsList.clear();
                              for (int i = 0; i <
                                  snapshot.data!.docs.length; i++) {
                                final DocumentSnapshot documentSnapshot = snapshot
                                    .data!.docs[i];
                                ProductClass filteredData = ProductClass(
                                    productId:
                                        documentSnapshot['productId'],
                                    productName: documentSnapshot['productName'],
                                    productImage: documentSnapshot['productImage'],
                                    productCat: documentSnapshot['productCat'],
                                    productEntryDate: DateTime.now(),
                                    //DateTime.parse(documentSnapshot['productEntryDate']),
                                    productPrice: documentSnapshot['productPrice'],
                                    favoriteFlag:
                                    documentSnapshot['favoriteFlag'],
                                    docsId: documentSnapshot.id,
                                    productCount: documentSnapshot['productCount']);
                                instCartsList.add(filteredData);

                              }



                            return ListView.builder(
                              itemCount: instCartsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                //print('insdie int ');
                                return     GestureDetector(
                                  onTap: ()
                                  {
                                    //print(instCartsList[index].productName);
                                  },
                                  child: Container(
                                    margin:const  EdgeInsets.all(AppSize.s6),
                                    height: getHeight(context)/FontManagerSize.s7,
                                    width: getWidth(context)/FontManagerSize.s3,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //   color: ColorManager.primary,
                                      //   width: 1,
                                      // ),
                                      borderRadius: BorderRadius.circular(AppSize.s10),
                                    ),
                                    child:
                                    Stack(
                                      children: [
                                        Card(
                                          color: Colors.grey[100],
                                          margin: EdgeInsets.all(FontManagerSize.s5),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s10)),
                                          elevation: .5,
                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(AppSize.s10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: FontManagerSize.s50,
                                                      backgroundImage: NetworkImage(instCartsList[index].productImage),
                                                      //  child: Image.asset(instCartsList[index].productImage,fit:BoxFit.cover),
                                                    ),
                                                    SizedBox(
                                                      width: getWidth(context)/AppSize.s12,

                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(instCartsList[index].productName),
                                                        Text("Price  ${instCartsList[index].productPrice}\$"),
                                                        Text('${formatDate(instCartsList[index].productEntryDate, [yyyy, '-', mm, '-', dd])}'),


                                                      ],
                                                    ),


                                                    Row(
                                                      children: [
                                                        IconButton(onPressed: (){
                                                          updateIntField(StringManager.collection_Carts,'productCount',instCartsList[index].docsId,instCartsList[index].productCount-1);

                                                        },
                                                            icon:  Icon(Icons.remove_circle,color:Colors.grey[300], )),
                                                        Text('${instCartsList[index].productCount}'),
                                                        IconButton(onPressed: (){
                                                          setState(() {
                                                            var tempProductCount =instCartsList[index].productCount+1;
                                                         
                                                          });

                                                          updateIntField(StringManager.collection_Carts,'productCount',instCartsList[index].docsId,instCartsList[index].productCount+1);

                                                        }, icon:  Icon(Icons.add_circle,color: ColorManager.primary, )),
                                                      ],
                                                    )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top:2,
                                          right: 2,
                                          child:
                                          IconButton(onPressed: (){
                                            deleteProduct(
                                                context,
                                                StringManager.collection_Carts,
                                                instCartsList[index].docsId,null
                                            );

                                          }, icon:const Icon(Icons.cancel_outlined )),)
                                      ],
                                    ),
                                  ),




                                );

                              },
                             );
                          } else if (snapshot.hasError) {
                            return const Icon(Icons.error_outline);
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),

                      ),
                  )//hgjghjg   hj


              ),





            //bottom shhet

            Positioned(
              bottom: AppSize.s0,
              right: 0,//MediaQuery.of(context).size.width / 2 -50,
              child:  ElevatedButton(
                style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.cyanAccent)) ,
                child: Text('Check out'),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        margin:const EdgeInsets.only(left:AppSize.s10,top: FontManagerSize.s5),
                        height: getHeight(context)/FontManagerSize.s8,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(200))
                        )
                        ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column

                              (
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Item : ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                    Text('$noItem',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Total : ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                    Text('$sumItem\$',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tax : ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                    Text('${sumItem*.16}\$',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('G Total : ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                    Text('${sumItem*1.16}\$',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                  ],
                                ),
                              ],
                            ),

                            getElevationButton(
                                parFontSize: AppSize.s20,
                                parBorderRadius: AppSize.s10,
                                parBorderWidth: AppSize.s1,
                                nameButton: 'Check Out',
                                onTabButton: (){
                                 //print('inside checkout');
                                },
                                parBackGroundColor: ColorManager.primary,
                                parForegroundColor: Colors.white)
                          ],
                        ),


                      );
                    },
                  );
                },
              ),
            ),

            //header title
            Positioned(
              top: MediaQuery.of(context).size.height / 18,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: const Text(
                'Carts'
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
