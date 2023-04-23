// ignore_for_file: library_private_types_in_public_api

//import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/CategoryClass.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/resource/Construct.dart';
import '../../../../core/resource/StringManager.dart';
import '../Category/CategoryClass.dart';
import '../Login/view_login/Auth.dart';
import '../Products/ProductDetails.dart';
import '../Products/ProductsClass.dart';
import 'Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Color colorOne = Colors.amber;
Color colorTwo = ColorManager.primary;
Color colorThree = ColorManager.primary;

Auth _auth = Get.put(Auth());
late ProductClass instProd;
bool updateDataFlag=true;
late CategoryClass instCat;
List<CategoryClass> instCatList = [];
List<ProductClass> instProdListSimilar = [];

//final CollectionReference _productss =FirebaseFirestore.instance.collection(StringManager.collection_Products);
//final CollectionReference _categoryss =FirebaseFirestore.instance.collection('Categorys');
List<ProductClass> instProdList=[] ;
List<ProductClass> dummyListData = [];
List<ProductClass> duplicateItems2 = [];
List<ProductClass> duplicateItems = [];
List<ProductClass> dummySearchList = [];
bool favoriteFlag = false;
TextEditingController controllerSearch = TextEditingController();
bool isViewAll = true;
String viewall = 'View All';
String titlePage = 'Home';

int? indexParameter;

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void filterSearchResultsCatSimilar(String query) {
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      dummyListData.clear();
      // List<Clients> dummyListData = List<Clients>();
      for (var item in dummySearchList) {
        if (item.productCat.toUpperCase().contains(query.toUpperCase()) ||
            item.productCat.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        instProdListSimilar = dummyListData;
      });
      return;
    } else {
      setState(() {
        instProdListSimilar = duplicateItems;
      });
    }
  }

  void filterSearchResultsCat(String query) {
    setState(() {
      updateDataFlag=false;
    });
    dummySearchList = duplicateItems;
    dummyListData=[];
  // //print('instProdList=${instProdList.length}');
    if (query.isNotEmpty) {
      for (var item in dummySearchList) {
        if (item.productCat.toUpperCase().contains(query.toUpperCase()) ||
            item.productCat.contains(query)) {
          dummyListData.add(item);
         //print('dummyListData=$dummyListData');
        }
      }


    }
    else {
      //print("inside else");
      setState(() {
        instProdList = duplicateItems;
        indexParameter = null;
        titlePage = 'Home';

        updateDataFlag=true;

      });
    }
    setState(() {
      instProdList = dummyListData;
    });
   ////print('instProdList=${instProdList.length}');
  }


  void filterSearchResults(String query) {
    setState(() {
      updateDataFlag=false;
    });
    dummySearchList = duplicateItems;
    dummyListData=[];

    if (query.isNotEmpty) {
      for (var item in dummySearchList) {
        if (item.productName.toUpperCase().contains(query.toUpperCase()) ||
            item.productName.contains(query)) {
          dummyListData.add(item);
          //print('dummyListData=$dummyListData');
        }
      }
      setState(() {
        instProdList = dummyListData;
      });

    }
    else {

      setState(() {
        instProdList = duplicateItems;
        indexParameter = null;
        titlePage = 'Home';

          updateDataFlag=true;

      });
    }


  }

  @override
  void initState() {
    instProdList.add(ProductClass(productId: 1, productName: "1", productImage: "",
        productPrice: "0", productCat: "0", productEntryDate: DateTime.now(), favoriteFlag: 0,
        docsId: "",productCount: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(context),
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
            Positioned(
              top: AppSize.s4,
              left: -AppSize.s4,
              child: IconButton(
                icon:  Icon(
                  Icons.menu,
                  color: ColorManager.grey2,
                ),
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
                    icon:  Icon(
                      Icons.notification_add_sharp,
                      color: ColorManager.grey2,
                    ),
                    onPressed: () {
                      sendDataFireStore();
                      // Navigator.pop(context);
                      //  Navigator.popAndPushNamed(context, "/SignIn");

                      //Navigator.pushReplacementNamed(context, "/SignIn");
                    },
                  ),
                  IconButton(
                    icon:  Icon(
                      Icons.shopping_cart_outlined,
                      color: ColorManager.grey2,
                    ),
                    onPressed: () {
                      //print('inside button');
                      // FirebaseAuth.instance.signOut();
                      //  Navigator.pop(context);
                      //  Navigator.popAndPushNamed(context, "/SignIn");

                      //Navigator.pushReplacementNamed(context, "/SignIn");
                    },
                  ),
                ],
              ),
            ),

            //body
            Positioned(
              top: getHeight(context) / FontManagerSize.s16,
              right: 0,
              bottom: 20,
              child: SizedBox(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,

                child:
                    // (MediaQuery.of(context).orientation == Orientation.portrait)
                    //  ?
                    Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //search
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppSize.s8, right: AppSize.s8),
                      child: TextFormField(
                        onChanged: (value) {

                          filterSearchResults(value);
                        },
                        showCursor: true,
                        // readOnly: true,
                        controller: controllerSearch,
                        decoration: InputDecoration(
                          label: Text(StringManager.search.tr),
                          hintText: StringManager.search.tr,
                          //  prefix: Text(StringManager.userName),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () =>
                                filterSearchResults(controllerSearch.text),
                          ),
                          // errorText: (snapshot.data ?? true)
                          //     ? null
                          //     : StringManager.usernameError,
                          suffix: Text(StringManager.search.tr),
                          //  suffixText: StringManager.userName,
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                controllerSearch.clear();
                                filterSearchResults(controllerSearch.text);
                              }),
                        ),
                      ),
                    ),
                    //listview hor
                    Padding(
                      padding: const EdgeInsets.only(
                          top: FontManagerSize.s2,
                          left: AppSize.s4,
                          right: AppSize.s4),
                      child: Container(
                        // color: Colors.red,
                        height: getHeight(context) / AppSize.s9,
                        width: getWidth(context),

                        child: StreamBuilder(
                          stream: getCollectionReference('Categorys').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {




                           ////print("inside _categoryss");
                            if (streamSnapshot.hasData) {

                              instCatList.clear();
                              for (int i =0 ;i<streamSnapshot.data!.docs.length;i++) {
                                final DocumentSnapshot documentSnapshot = streamSnapshot
                                    .data!.docs[i];
                                CategoryClass filteredData = CategoryClass(
                                  catId: int.parse(documentSnapshot['catId']),
                                  catName: documentSnapshot['catName'],
                                  catImage: documentSnapshot['catImage'],
                                  catPrice: documentSnapshot['catPrice'],
                                  catDesc: documentSnapshot['catDesc'],
                                  catDate: DateTime
                                      .now(),
                                    docsId:documentSnapshot.id//documentSnapshot['catDate']
                                );




                                instCatList.add(filteredData);
                              }
                             ////print("inside if");
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:instCatList.length,// streamSnapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  //final DocumentSnapshot documentSnapshot =streamSnapshot.data!.docs[index];
                                  return SizedBox(
                                    //color: Colors.red,
                                    height: getHeight(context) / AppSize.s9,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: AppSize.s8, right: AppSize.s8),
                                          child: GestureDetector(
                                            onTap: () {
                                              //print('ontp');
                                              setState(() {
                                                indexParameter = index;
                                              });
                                             //print('indexParameter=$indexParameter');

                                              filterSearchResultsCat(
                                                  instCatList[index].catName);
                                            
                                            },
                                            child: Stack(
                                              children: [
                                                Card(
                                                  elevation: 4,
                                                  shape: RoundedRectangleBorder(
                                                      side: index == indexParameter
                                                          ? BorderSide(
                                                          color: Colors.grey,
                                                          width: AppSize.s1)
                                                          : BorderSide(
                                                          color: Colors.transparent,
                                                          width: AppSize.s0),
                                                      borderRadius:
                                                      BorderRadius.circular(250)),
                                                  child: Container(

                                                        height: 50,
                                                        width: 50,

                                                       decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(250),
                                                         image: DecorationImage(
                                                           image: NetworkImage( instCatList[index].catImage,
                                                         )
                                                         //  image:Image.network( documentSnapshot['catImage'])
                                                       ),


                                                  ),),

                                                       //   image: Image.network( documentSnapshot['catImage'])),




                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 5,
                                                  child: index == indexParameter? Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                        BorderRadius.circular(250)),
                                                  )
                                                      : Container(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text('${instCatList[index].catName}'),
                                        //  backgroundImage:  (AssetManager.onBoarding3,fit: BoxFit.cover))
                                      ],
                                    ),
                                  );
                                },
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),

                    isViewAll
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: AppSize.s8, right: AppSize.s8),
                            child: Container(
                              margin: const EdgeInsets.only(left: AppSize.s0_5),
                              decoration: BoxDecoration(
                                  //color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),

                              height: getHeight(context) / FontManagerSize.s7,
                              width: getWidth(context),
                              child: GetCarouselSlider(),
                              //child:Cal
                            ),
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Newest',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isViewAll) {
                                    viewall = 'View Less';
                                    controllerSearch.clear();
                                    filterSearchResults(controllerSearch.text);
                                  } else {
                                    viewall = 'View All';
                                  }
                                  isViewAll = !isViewAll;
                                });
                                // Get.to(() => HomePageAll());
                              },
                              child: Text(
                                viewall,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.primary),
                              )),
                        ),
                      ],
                    ),
                    //products
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: AppSize.s4, right: AppSize.s4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                          ),
                          width: getWidth(context),
                          height: getHeight(context), //FontManagerSize.s3,
                          child: StreamBuilder(
                            stream:getCollectionReference(StringManager.collection_Products).snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {



                              if (streamSnapshot.hasData) {
                                if (updateDataFlag) {
                                  instProdList.clear();
                                  for (int i = 0; i <
                                      streamSnapshot.data!.docs.length; i++) {
                                    final DocumentSnapshot documentSnapshot = streamSnapshot
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
                                        docsId: documentSnapshot.id
                                    ,productCount: 1);


                                    instProdList.add(filteredData);
                                    duplicateItems = instProdList;
                                  }
                                }
                              //  return ProdcutCeil( instProdList: instProdList,);
                              return   GridView.builder(
                                itemCount:instProdList.length,//streamSnapshot.data!.docs.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                                itemBuilder: (context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      
                                      //(index);
                                      // instProdListSimilar.clear();
                                      filterSearchResultsCatSimilar(
                                          instProdList[index].productCat);
                                      Get.to(() => ProductDetails(
                                        instProd: instProdList[index],
                                        prodList: instProdListSimilar,
                                      ));
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Hero(
                                            tag: instProdList[index].productName,
                                            child: Card(
                                              color: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s10)),
                                              child: GridTile(
                                                  header: Align(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          color: ColorManager
                                                              .primary
                                                              .withOpacity(
                                                              .9),
                                                          borderRadius: const BorderRadius
                                                              .only(
  topLeft: Radius
                                                                  .circular(
                                                                  AppSize
                                                                      .s10)),
                                                        ),
                                                        height: getHeight(
                                                            context) /
                                                            AppSize.s40,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left: AppSize
                                                                  .s4),
                                                          // child: Text( filteredData.productCat),
                                                          child:Text(instProdList[index].productCat),
                                                        )),
                                                  ),
                                                  footer: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        color: ColorManager
                                                            .white
                                                            .withOpacity(.6),
                                                        borderRadius: const BorderRadius
                                                            .only(
                                                            bottomLeft: Radius
                                                                .circular(
                                                                AppSize
                                                                    .s10),
                                                            bottomRight: Radius
                                                                .circular(
                                                                AppSize
                                                                    .s10)),
                                                      ),
                                                      height:
                                                      getHeight(context) /
                                                          FontManagerSize
                                                              .s20,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text('${instProdList[index].productName} ',
                                                            //  Text(' ${filteredData.productName}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                FontManagerSize
                                                                    .s16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          Text(
                                                            ' Price :${instProdList[index].productPrice} \$',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: Colors.black),
                                                          ),
                                                        ],
                                                      )),
                                                  child: Container(
                                                    height:
                                                    getHeight(context) /
                                                        AppSize.s20,

                                                    //width: 80,

                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          AppSize
                                                              .s10),
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            //AssetManager.mancat

                                                            instProdList[index].
                                                            productImage,
                                                          )
                                                      ),
                                                      color: ColorManager
                                                          .primary
                                                          .withOpacity(.9),
                                                    ),
                                                  )

                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            right: AppSize.s4,
                                            child: IconButton(
                                                onPressed: () {

                                                  setState(() {
                                                    int temp = instProdList[index].favoriteFlag ==0
                                                        ? 1
                                                        : 0;
                                                   // instProdList[index].favoriteFlag = temp;

                                                    updateIntField(StringManager.collection_Products,'favoriteFlag',instProdList[index].docsId,temp);
                                                  });
                                                },
                                                icon: instProdList[index]
                                                    .favoriteFlag ==
                                                    1
                                                    ? const Icon(
                                                  Icons
                                                      .favorite_outlined,
                                                  color: Colors.red,
                                                )
                                                    : const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.red,
                                                )))
                                      ],
                                    ),
                                  );

                                },
                              );
                              }

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),

                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //header title
            Positioned(
              top: MediaQuery.of(context).size.height / FontManagerSize.s50,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: Text(
                titlePage,
                //AppLocalizations.of(context).translate('Details'),
                style: const TextStyle(
                    fontSize: FontManagerSize.s24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendDataFireStore() {
    FirebaseFirestore.instance.collection("Clean_App_Products").doc().set({
      'name': "rmsd",
      'price': "10",
    });
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



class GetCarouselSlider extends StatefulWidget {
  GetCarouselSlider({Key? key}) : super(key: key);

  @override
  State<GetCarouselSlider> createState() => _GetCarouselSliderState();
}

class _GetCarouselSliderState extends State<GetCarouselSlider> {
  //class ImageSliderDemo extends StatelessWidget {
  final List<String> imgList = [
    AssetManager.homeadv1,
    AssetManager.homeadv2,
    AssetManager.homeadv3,
    AssetManager.homeadv4

    // AssetManager.splash1,
    // AssetManager.splash2,
    // AssetManager.splash3,
    // AssetManager.splashLogo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        //color: Colors.red,
        height: getHeight(context) * .5,
        width: getWidth(context) * .9999,
        child: CarouselSlider(
          items: imgList
              .map(
                (p) => Card(
                  // shape: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //       color: ColorManager.primary, width: AppSize.s0_5),
                  // ),
                  elevation: AppSize.s0,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: ExactAssetImage(
                              p,
                              // width: MediaQuery.of(context).
                              // size.width,
                              //fit: BoxFit.cover,
                            )),
                        borderRadius: BorderRadius.circular(10)),
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


class CatListCiel extends StatelessWidget {
   CatListCiel({Key? key,required this.instCatClass}) : super(key: key);
  CategoryClass instCatClass;

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: instCatClass.catName,
              child: Card(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            AppSize.s10)),
                child: GridTile(
                    header: Align(
                      alignment:
                          Alignment.topLeft,
                      child: Container(
                          decoration:
                              BoxDecoration(
                            color: ColorManager
                                .primary
                                .withOpacity(.9),
                            borderRadius: const BorderRadius
                                    .only(

                                // bottomLeft:Radius.circular(AppSize.s10),

                                topLeft: Radius
                                    .circular(
                                        AppSize
                                            .s10)),
                          ),
                          height:
                              getHeight(context) /
                                  AppSize.s40,
                          child: Padding(
                            padding:
                                const EdgeInsets
                                        .only(
                                    left: AppSize
                                        .s4),
                            child: Text(
                                instCatClass
                                    .catDesc),
                          )),
                    ),
                    footer: Container(
                        decoration: BoxDecoration(
                          color: ColorManager
                              .white
                              .withOpacity(.6),
                          borderRadius: const BorderRadius
                                  .only(
                              bottomLeft:
                                  Radius.circular(
                                      AppSize
                                          .s10),
                              bottomRight:
                                  Radius.circular(
                                      AppSize
                                          .s10)),
                        ),
                        height:
                            getHeight(context) /
                                FontManagerSize
                                    .s24,
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              ' ${instCatClass.catName}',
                              style: TextStyle(
                                  fontSize:
                                      FontManagerSize
                                          .s14,
                                  fontWeight:
                                      FontWeight
                                          .bold),
                            ),
                            Text(
                              ' Price :${instCatClass.catPrice} \$',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color:
                                      ColorManager
                                          .primary),
                            ),
                          ],
                        )),
                    child: Container(
                      height: getHeight(context) /
                          AppSize.s20,

                      //width: 80,

                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                                AppSize.s10),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              //AssetManager.mancat

                              instCatClass
                                  .catImage,
                            )),
                        color: ColorManager
                            .primary
                            .withOpacity(.9),
                      ),
                    )

                    // Column(

                    //   children: [

                    //     Card(

                    //       elevation: 0,

                    //       shape: const OutlineInputBorder(

                    //         borderSide: BorderSide(

                    //             color: Colors.transparent,

                    //             width: AppSize.s0_5),

                    //         borderRadius: BorderRadius.all(

                    //           Radius.circular(AppSize.s8),

                    //         ),

                    //       ),

                    //       child: Stack(

                    //         children: [

                    //           Positioned(

                    //             child: Container(

                    //               height: 90,

                    //               //width: 80,

                    //               decoration: BoxDecoration(

                    //                 borderRadius: BorderRadius.circular(5),

                    //                 image: const DecorationImage(

                    //                     fit: BoxFit.fill,

                    //             ';]        image: AssetImage(

                    //                       AssetManager.mancat4,

                    //                     )),

                    //                 color: Colors.green,

                    //               ),

                    //             ),

                    //           ),

                    //           Positioned(

                    //               bottom: AppSize.s0,

                    //               left: AppSize.s0,

                    //               right: AppSize.s0,

                    //               child: Container(

                    //                   height:

                    //                       get_height(context) / AppSize.s40,

                    //                   color: ColorManager.primary

                    //                       .withOpacity(.4),

                    //                   child: const Center(

                    //                       child: Text('T-shirt')))),

                    //           const Positioned(

                    //             right: AppSize.s4,

                    //             child: const Icon(

                    //               Icons.favorite_border_outlined,

                    //               color: Colors.red,

                    //             ),

                    //           ),

                    //         ],

                    //       ),

                    //     ),

                    //     Column(

                    //       children: [

                    //         const Text('Price :50'),

                    //       ],

                    //     ),

                    //     // Text('price : ${23}\$'),

                    //   ],

                    // ),

                    ),
              ),
            ),
          ),
          Positioned(
              right: AppSize.s4,
              child: IconButton(
                  onPressed: () {
                    // setState(() {
                    //   int temp = filteredData
                    //               .catPrice ==
                    //           0
                    //       ? 1
                    //       : 0;
                    //
                    //  //print('temp=$temp');
                    //
                    //   filteredData.catPrice =
                    //       temp.toString();
                    //
                    //  //print(
                    //       filteredData.catPrice);
                    // });
                  },
                  icon: instCatClass.catPrice ==
                          1
                      ? const Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        )))
        ],
      );

  }
}



class ProdcutCeil extends StatelessWidget {
   ProdcutCeil({Key? key,required this.instProdList}) : super(key: key);
List<ProductClass> instProdList;
  @override
  Widget build(BuildContext context) {
    return   GridView.builder(
      itemCount:instProdList.length,//streamSnapshot.data!.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context, int index) {

        ////print(instProdList.length);
        return InkWell(
          onTap: () {
           ////print('inside tabbbbb=  $index');
            //(index);
            // instProdListSimilar.clear();
            // filterSearchResultsCatSimilar(
            //     instProdList[index].productCat);
            Get.to(() => ProductDetails(
              instProd: instProdList[index],
              prodList: instProdListSimilar,
            ));
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: instProdList[index].productName,
                  child: Card(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            AppSize.s10)),
                    child: GridTile(
                        header: Align(
                          alignment:
                          Alignment.topLeft,
                          child: Container(
                              decoration:
                              BoxDecoration(
                                color: ColorManager
                                    .primary
                                    .withOpacity(
                                    .9),
                                borderRadius: const BorderRadius
                                    .only(

                                  // bottomLeft:Radius.circular(AppSize.s10),

                                    topLeft: Radius
                                        .circular(
                                        AppSize
                                            .s10)),
                              ),
                              height: getHeight(
                                  context) /
                                  AppSize.s40,
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                    left: AppSize
                                        .s4),
                                // child: Text( filteredData.productCat),
                                child:Text(instProdList[index].productCat),
                              )),
                        ),
                        footer: Container(
                            decoration:
                            BoxDecoration(
                              color: ColorManager
                                  .white
                                  .withOpacity(.6),
                              borderRadius: const BorderRadius
                                  .only(
                                  bottomLeft: Radius
                                      .circular(
                                      AppSize
                                          .s10),
                                  bottomRight: Radius
                                      .circular(
                                      AppSize
                                          .s10)),
                            ),
                            height:
                            getHeight(context) /
                                FontManagerSize
                                    .s20,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text('${instProdList[index].productName}',
                                  //  Text(' ${filteredData.productName}',
                                  style: TextStyle(
                                      fontSize:
                                      FontManagerSize
                                          .s16,
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                ),
                                Text(
                                  ' Price :${instProdList[index].productPrice} \$',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                      color: ColorManager
                                          .primary),
                                ),
                              ],
                            )),
                        child: Container(
                          height:
                          getHeight(context) /
                              AppSize.s20,

                          //width: 80,

                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(
                                AppSize
                                    .s10),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  //AssetManager.mancat

                                  instProdList[index].
                                  productImage,
                                )
                            ),
                            color: ColorManager
                                .primary
                                .withOpacity(.9),
                          ),
                        )

                    ),
                  ),
                ),
              ),
              Positioned(
                  right: AppSize.s4,
                  child: IconButton(
                      onPressed: () {
                        // setState(() {
                        //   int temp = instProdList[index]
                        //       .favoriteFlag ==
                        //       0
                        //       ? 1
                        //       : 0;
                        //
                        //  //print('temp=$temp');
                        //
                        //   instProdList[index]
                        //       .favoriteFlag = temp;
                        //
                        //  //print(instProdList[index]
                        //       .favoriteFlag);
                        // });
                      },
                      icon: instProdList[index]
                          .favoriteFlag ==
                          1
                          ? const Icon(
                        Icons
                            .favorite_outlined,
                        color: Colors.red,
                      )
                          : const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      )))
            ],
          ),
        );

      },
    );
  }
}

