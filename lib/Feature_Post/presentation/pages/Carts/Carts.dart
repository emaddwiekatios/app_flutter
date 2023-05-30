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
double sumItem=0.0;
int noItem=0;
const curveHeight = 160.0;
const avatarRadius = curveHeight * 0.28;
const avatarDiameter = avatarRadius * 2;
Color colorOne = Colors.amber;
Color colorTwo = ColorManager.primary;
Color colorThree = ColorManager.primary;
var _carts=getCollectionReference(StringManager.collectionCarts);
class _CartsState extends State<Carts> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  List<ProductClass> instCartsList=[];
@override
  void initState() {
  //();

    super.initState();
  }

  void onWillpop()
  {
    getSumItem();
  print('inside willpop');
  }

  void getSumItem ()
  {
    sumItem=0.0;
    instCartsList.forEach((element) {
      //setState(() {
        sumItem=(sumItem+ int.parse(element.productPrice)*element.productCount);
     // });
    });
  print(sumItem);
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

            Positioned(
              top: AppSize.s40,
              right: 0,
              bottom: 100,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height >= 775.0
                      ? MediaQuery.of(context).size.height
                      : 775.0,
                  child:  Center(
                      child: StreamBuilder(
                        stream: getCollectionReference(StringManager.collectionCarts).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          sumItem=0.0;
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

                                sumItem=sumItem+(double.parse(documentSnapshot['productPrice'])* documentSnapshot['productCount']);
                                   instCartsList.add(filteredData);


                              }

                            Future.delayed(Duration.zero,(){
                              setState(() {
                              //  print('future');
                              });
                            });

                            return ListView.builder(
                              itemCount: instCartsList.length,
                              itemBuilder: (BuildContext context, int index) {


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
                                                          updateIntField(StringManager.collectionCarts,'productCount',instCartsList[index].docsId,instCartsList[index].productCount-1);

                                                        },
                                                            icon:  Icon(Icons.remove_circle,color:Colors.grey[300], )),
                                                        Text('${instCartsList[index].productCount}'),
                                                        IconButton(onPressed: (){
                                                          setState(() {
                                                            var tempProductCount =instCartsList[index].productCount+1;

                                                          });

                                                          updateIntField(StringManager.collectionCarts,'productCount',instCartsList[index].docsId,instCartsList[index].productCount+1);

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
                                          IconButton(onPressed: () async {

                                           await deleteProduct(
                                                context,
                                                StringManager.collectionCarts,
                                                instCartsList[index].docsId,null
                                            );
                                            setState(() {
                                              print('inside set state');
                                              noItem=instCartsList.length;
                                              getSumItem();
                                            });

                                          }, icon:const Icon(Icons.cancel_outlined )),)
                                      ],
                                    ),
                                  ),




                                );

                              },
                             );
                          }
                          else if (snapshot.hasError) {
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
              right:  AppSize.s0,
                left:  AppSize.s0,//MediaQuery.of(context).size.width / 2 -50,
              child: Container(

                margin:const EdgeInsets.all(AppSize.s10),
                height: getHeight(context)/FontManagerSize.s10,
                decoration: const BoxDecoration(
                color: Colors.blueGrey,

                    borderRadius: BorderRadius.all( Radius.circular(10))
                )
                ,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column

                        (
                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Total : ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              Text('$sumItem\$',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Item : ',style: TextStyle(fontSize: AppSize.s16, fontWeight: FontWeight.bold),),
                                  Text('$noItem',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax : ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              Text('${(sumItem*.16).roundToDouble()}\$',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('G Total : ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              Text('${(sumItem*1.16).roundToDouble()}\$',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                            ],
                          ),

                        ],
                      ),
                      defaltElevationButton(
                           heightButton: getHeight(context)/FontManagerSize.s20,
                           widthButton: getWidth(context)/3,
                          parFontSize: AppSize.s20,
                          parBorderRadius: AppSize.s10,
                          parBorderWidth: AppSize.s1,
                          nameButton: 'Check',
                          onTabButton: (){
                            //print('inside checkout');
                          },
                          parBackGroundColor: ColorManager.primary,
                          parForegroundColor: Colors.white)

                    ],
                  ),
                ),


              )

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
