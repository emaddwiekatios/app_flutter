// ignore_for_file: library_private_types_in_public_api

import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/CategoryClass.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/resource/StringManager.dart';
import '../Login/view_login/Auth.dart';
import '../Products/ProductDetails.dart';
import '../Products/ProductsClass.dart';
import 'Home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Color colorOne = Colors.amber;
Color colorTwo = ColorManager.primary;
Color colorThree = ColorManager.primary;

Auth _auth =Get.put(Auth());
late ProductClass instProd ;



late CategoryClass instCat ;
 List<CategoryClass> instCatList=[];



List<ProductClass> instProdList=[];
List<ProductClass> dummyListData =  <ProductClass>[];
List<ProductClass> duplicateItems2 =  <ProductClass>[];
List<ProductClass> duplicateItems =  <ProductClass>[];
List<ProductClass> dummySearchList =  <ProductClass>[];

TextEditingController controllerSearch =TextEditingController();
bool isViewAll=true;
String viewall='View All';
String titlePage='Home';

int? indexParameter;

void loadcategoryinit() {
  instCatList.clear();
  instCatList.add(
      CategoryClass(
          categoryId: 1,
          categoryName: 'Socks',
          categoryImage: AssetManager.socks,
          categoryEntryDate: DateTime.now()));
  instCatList.add(
      CategoryClass(
          categoryId: 2,
          categoryName: 'Bag',
          categoryImage: AssetManager.bag,
          categoryEntryDate: DateTime.now()));
  instCatList.add(
      CategoryClass(
          categoryId: 3,
          categoryName: 'Clothes',
          categoryImage: AssetManager.shop,
          categoryEntryDate: DateTime.now()));
  instCatList.add(
      CategoryClass(
          categoryId: 4,
          categoryName: 'buying',
          categoryImage: AssetManager.buying,
          categoryEntryDate: DateTime.now()));
  instCatList.add(
      CategoryClass(
          categoryId: 5,
          categoryName: 'Bag',
          categoryImage: AssetManager.gift,
          categoryEntryDate: DateTime.now()));
  instCatList.add(
      CategoryClass(
          categoryId: 6,
          categoryName: 'discount',
          categoryImage: AssetManager.discount,
          categoryEntryDate: DateTime.now()));

  instCatList.add(
      CategoryClass(
          categoryId: 2,
          categoryName: 'shoppingbackage',
          categoryImage: AssetManager.shoppingbackage,
          categoryEntryDate: DateTime.now()));

  instCatList.add(
      CategoryClass(
          categoryId: 2,
          categoryName: 'shopaholic',
          categoryImage: AssetManager.shopaholic,
          categoryEntryDate: DateTime.now()));

  instCatList.add(
      CategoryClass(
          categoryId: 2,
          categoryName: 'homeaddress',
          categoryImage: AssetManager.homeaddress,
          categoryEntryDate: DateTime.now()));


}

void loadProductinit() {
  instProdList.clear();
  instProdList.add(ProductClass(productId: 1, productName: 'T-shirt', productImage: AssetManager.mancat, productPrice: 16, productCat: 'Clothes', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 2, productName: 'Jaket', productImage: AssetManager.mancat3, productPrice: 50, productCat: 'Clothes', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 3, productName: 'Jeans', productImage: AssetManager.mancat4, productPrice: 100, productCat: 'Clothes', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 4, productName: 'Body', productImage: AssetManager.mancat5, productPrice: 400, productCat: 'buying', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 5, productName: 'T-shttirt', productImage: AssetManager.mancat, productPrice: 616, productCat: 'Clothes', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 6, productName: 'Jaketttt', productImage: AssetManager.mancat3, productPrice: 560, productCat: 'Clothes', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 7, productName: 'Jeattns', productImage: AssetManager.mancat4, productPrice: 1600, productCat: 'Clothes', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 8, productName: 'Bodtty', productImage: AssetManager.mancat5, productPrice: 4060, productCat: 'Clothes', productEntryDate: DateTime.now()));

  instProdList.add(ProductClass(productId: 4, productName: 'Body', productImage: AssetManager.mancat5, productPrice: 400, productCat: 'Socks', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 5, productName: 'T-shttirt', productImage: AssetManager.mancat, productPrice: 616, productCat: 'Socks', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 6, productName: 'Jaketttt', productImage: AssetManager.mancat3, productPrice: 560, productCat: 'Socks', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 7, productName: 'Jeattns', productImage: AssetManager.mancat4, productPrice: 1600, productCat: 'Socks', productEntryDate: DateTime.now()));
  instProdList.add(ProductClass(productId: 8, productName: 'Bodtty', productImage: AssetManager.mancat5, productPrice: 4060, productCat: 'Socks', productEntryDate: DateTime.now()));

  //emad dupitems
 //fffffffffn
 // emad   nbjnj
  duplicateItems = instProdList;
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  void filterSearchResultsCat(String query)   {

    print('insdie filter');
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      dummyListData.clear();
      // List<Clients> dummyListData = List<Clients>();
      dummySearchList.forEach((item) {
        if (item.productCat.toUpperCase().contains(query.toUpperCase()) ||
            item.productCat.contains(query)) {

          dummyListData.add(item);
        }
      });
      setState(() {
        titlePage=query;
        instProdList = dummyListData;

        print('titlePage');
        print(titlePage);

      });
      return;
    } else {
      setState(() {
        titlePage=query;
        print('setState2');
        instProdList = duplicateItems;
        indexParameter=null;


      });
    }


  }
  void filterSearchResults(String query) {
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      dummyListData.clear();
      // List<Clients> dummyListData = List<Clients>();
      dummySearchList.forEach((item) {
        if (item.productName.toUpperCase().contains(query.toUpperCase()) ||
            item.productName.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        //  Shackslist=null;
        instProdList = dummyListData;
      });
      return;
    } else {
      setState(() {
        instProdList = duplicateItems;
        indexParameter=null;
        titlePage='Home';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
loadcategoryinit();
    loadProductinit();



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


            // Positioned(
            //   top:0,
            //   left:0,right: 0,
            //
            //   child: Container(
            //       height: getHeight(context)/FontManagerSize.s17,
            //       color:ColorManager.primary),
            // ),
            Positioned(
              top: AppSize.s4,
              left: -AppSize.s4,
              child: IconButton(
                icon: Icon(
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
                    icon: Icon(
                      Icons.notification_add_sharp,
                      color: ColorManager.grey2,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      //  Navigator.popAndPushNamed(context, "/SignIn");

                      //Navigator.pushReplacementNamed(context, "/SignIn");
                    },
                  ),
                  IconButton(
                    icon: Icon(
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

                    Padding(
                      padding: const EdgeInsets.only(left:AppSize.s8,right: AppSize.s8),
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
                          prefixIcon:  IconButton(
                            icon  :Icon(Icons.search), onPressed: ()=>filterSearchResults(controllerSearch.text),),
                          // errorText: (snapshot.data ?? true)
                          //     ? null
                          //     : StringManager.usernameError,
                          suffix: Text(StringManager.search.tr),
                          //  suffixText: StringManager.userName,
                          suffixIcon: IconButton(
                              icon  :const Icon(Icons.cancel), onPressed: (){

                            controllerSearch.clear();
                            filterSearchResults(controllerSearch.text);

                          }),
                        ),
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.only(left:AppSize.s4,right: AppSize.s4),
                        child:Container(
                          // color: Colors.red,
                          height: getHeight(context) / FontManagerSize.s10,
                          width: getWidth(context),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: instCatList.length,
                              itemBuilder: (context, int index) {
                                return   SizedBox(
                                  //color: Colors.red,
                                  height: getHeight(context)/AppSize.s9,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:AppSize.s8,right:AppSize.s8),
                                        child: GestureDetector(
                                          onTap: ()
                                          {



                                            setState(() {

                                              indexParameter=index;
                                            });
                                            filterSearchResultsCat(instCatList[index].categoryName);
                                          },
                                          child: Stack(
                                            children: [
                                              Card(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    side: index==indexParameter ? BorderSide(color: Colors.grey, width: AppSize.s1):
                                                    BorderSide(color: Colors.transparent, width: AppSize.s0),
                                                    borderRadius: BorderRadius.circular(270)),
                                                child:  CircleAvatar(
                                                  foregroundImage: ExactAssetImage(instCatList[index].categoryImage),
                                                  backgroundColor: ColorManager.primary.withOpacity(.2),
                                                  radius: FontManagerSize.s30,
                                                  // backgroundImage: ExactAssetImage(AssetManager),
                                                ),
                                              ),
                                              Positioned(
                                                right:10,
                                                top:5,
                                                child:  index==indexParameter ?Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(250)
                                                  ),

                                                ):Container(),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(instCatList[index].categoryName)
                                      //  backgroundImage:  (AssetManager.onBoarding3,fit: BoxFit.cover))
                                    ],
                                  ),
                                );

                                //Center(child: widgetCategory( instCat: instCatList[index]));
                              }),
                        )



                    ),
                    isViewAll? Padding(
                      padding: const EdgeInsets.only(left:AppSize.s8,right: AppSize.s8),
                      child: Container(
                        margin: const EdgeInsets.only(left:AppSize.s0_5),
                        decoration: BoxDecoration(
                          //color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),

                        height: getHeight(context) / AppSize.s6,
                        width: getWidth(context),
                        child: GetCarouselSlider(),
                        //child:Cal
                      ),
                    ) :Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child:   Text('Newest',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:15.0),
                          child:   GestureDetector(
                              onTap: ()
                              {



                                setState(() {
                                  if (  isViewAll)
                                  {
                                    viewall='View Less';
                                    controllerSearch.clear();
                                    filterSearchResults(controllerSearch.text);
                                  }
                                  else
                                  {
                                    viewall='View All' ;
                                  }
                                  isViewAll=!isViewAll;


                                });
                                // Get.to(() => HomePageAll());
                              },
                              child: Text(viewall,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: ColorManager.primary),)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:AppSize.s4,right: AppSize.s4),
                        child: Container(
                            decoration:  BoxDecoration(

                              borderRadius: BorderRadius.circular(AppSize.s20),

                              //color: Colors.blue,
                            ),
                            width: getWidth(context),
                            height: getHeight(context), //FontManagerSize.s3,

                            child: GridView.builder(
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  onTap: () {
                                    //(index);

                                    Get.to(() =>  ProductDetails( instProd: instProdList[index]));
                                  },
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Hero(
                                          tag: instProdList[index].productId,
                                          child: Card(
                                            color: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(AppSize.s10)),
                                            child: GridTile(
                                                header: Align(
                                                  alignment: Alignment.topLeft,
                                                  child:  Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorManager.primary.withOpacity(.9),
                                                        borderRadius: const BorderRadius.only(
                                                          // bottomLeft:Radius.circular(AppSize.s10),
                                                            topLeft:Radius.circular(AppSize.s10)
                                                        ),
                                                      ),
                                                      height: getHeight(context)/AppSize.s40,

                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:AppSize.s4),
                                                        child: Text(instProdList[index].productCat),
                                                      )),),
                                                footer: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorManager.white.withOpacity(.6),
                                                      borderRadius:const  BorderRadius.only(
                                                          bottomLeft:Radius.circular(AppSize.s10),
                                                          bottomRight:Radius.circular(AppSize.s10)
                                                      ),
                                                    ),
                                                    height: getHeight(context)/FontManagerSize.s24,

                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(' ${instProdList[index].productName}'
                                                          ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                                        Text(' Price :${instProdList[index].productPrice} \$'
                                                          ,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: ColorManager.primary),),

                                                      ],
                                                    )
                                                ),

                                                child: Container(
                                                  height: getHeight(context)/AppSize.s20,
                                                  //width: 80,
                                                  decoration: BoxDecoration(

                                                    borderRadius: BorderRadius.circular(AppSize.s10),

                                                    image:  DecorationImage(
                                                        fit: BoxFit.fill,         image: AssetImage(//AssetManager.mancat
                                                      instProdList[index].productImage,
                                                    )),
                                                    color: ColorManager.primary.withOpacity(.9),
                                                  ),)

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
                                              //             child: Icon(
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
                                          right:AppSize.s4 ,child:IconButton(onPressed: () {

                                        loadProductinit();

                                      },icon: Icon(Icons.favorite, color: Colors.red,)

                                      )

                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: instProdList.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                ),


            ),
            //header title
            //header titleini
            Positioned(
              top: MediaQuery.of(context).size.height /FontManagerSize.s50
              ,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: Text(titlePage,
                //AppLocalizations.of(context).translate('Details'),
                style:const TextStyle(fontSize: FontManagerSize.s24, fontWeight: FontWeight.bold),
              ),
            ),
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

// class widgetCategory extends StatefulWidget {
//    widgetCategory({Key? key,required this.instCat}) : super(key: key);
// CategoryClass instCat;
//
//   @override
//   State<widgetCategory> createState() => _widgetCategoryState();
// }
//
// class _widgetCategoryState extends State<widgetCategory> {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SizedBox(
//
//       height: getHeight(context)/AppSize.s9,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left:AppSize.s8,right:AppSize.s8),
//             child: GestureDetector(
//               onTap: ()
//               {
//
//
//
//
//               },
//               child: Card(
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                     //side: BorderSide(color: ColorManager.primary, width: AppSize.s0_5),
//                     borderRadius: BorderRadius.circular(270)),
//                 child:  CircleAvatar(
//                   foregroundImage: ExactAssetImage(widget.instCat.categoryImage),
//                   backgroundColor: ColorManager.primary.withOpacity(.2),
//                   radius: FontManagerSize.s30,
//                     // backgroundImage: ExactAssetImage(AssetManager),
//                 ),
//               ),
//             ),
//           ),
//            Text(widget.instCat.categoryName)
//           //  backgroundImage:  (AssetManager.onBoarding3,fit: BoxFit.cover))
//         ],
//       ),
//     );
//   }
//
//
//
// }

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

class GetPortraitOrient extends StatefulWidget {
  const GetPortraitOrient({Key? key}) : super(key: key);

  @override
  State<GetPortraitOrient> createState() => _GetPortraitOrientState();
}

class _GetPortraitOrientState extends State<GetPortraitOrient> {
  void filterSearchResultsCat(String query)   {

print('insdie filter');
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      dummyListData.clear();
      // List<Clients> dummyListData = List<Clients>();
      dummySearchList.forEach((item) {
        if (item.productCat.toUpperCase().contains(query.toUpperCase()) ||
            item.productCat.contains(query)) {

          dummyListData.add(item);
        }
      });
      setState(() {
         titlePage=query;
        instProdList = dummyListData;

        print('titlePage');
        print(titlePage);

      });
      return;
    } else {
      setState(() {
        titlePage=query;
        print('setState2');
        instProdList = duplicateItems;
        indexParameter=null;


      });
    }


  }
  void filterSearchResults(String query) {
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      dummyListData.clear();
      // List<Clients> dummyListData = List<Clients>();
      dummySearchList.forEach((item) {
        if (item.productName.toUpperCase().contains(query.toUpperCase()) ||
            item.productName.contains(query)) {
            dummyListData.add(item);
        }
      });
      setState(() {
        //  Shackslist=null;
        instProdList = dummyListData;
      });
      return;
    } else {
      setState(() {
        instProdList = duplicateItems;
        indexParameter=null;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left:AppSize.s8,right: AppSize.s8),
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
                prefixIcon:  IconButton(
                  icon  :Icon(Icons.search), onPressed: ()=>filterSearchResults(controllerSearch.text),),
                // errorText: (snapshot.data ?? true)
                //     ? null
                //     : StringManager.usernameError,
                suffix: Text(StringManager.search.tr),
                //  suffixText: StringManager.userName,
                suffixIcon: IconButton(
                icon  :const Icon(Icons.cancel), onPressed: (){

                  controllerSearch.clear();
                  filterSearchResults(controllerSearch.text);

                }),
          ),
        ),
        ),

        Padding(
          padding: const EdgeInsets.only(left:AppSize.s4,right: AppSize.s4),
          child:Container(
            // color: Colors.red,
            height: getHeight(context) / FontManagerSize.s10,
            width: getWidth(context),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: instCatList.length,
                itemBuilder: (context, int index) {
                  return   SizedBox(
                    //color: Colors.red,
                    height: getHeight(context)/AppSize.s9,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:AppSize.s8,right:AppSize.s8),
                          child: GestureDetector(
                            onTap: ()
                            {



                              setState(() {

                                indexParameter=index;
                              });
                              filterSearchResultsCat(instCatList[index].categoryName);
                            },
                            child: Stack(
                              children: [
                            Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      side: index==indexParameter ? BorderSide(color: Colors.grey, width: AppSize.s1):
                                      BorderSide(color: Colors.transparent, width: AppSize.s0),
                                      borderRadius: BorderRadius.circular(270)),
                                  child:  CircleAvatar(
                                    foregroundImage: ExactAssetImage(instCatList[index].categoryImage),
                                    backgroundColor: ColorManager.primary.withOpacity(.2),
                                    radius: FontManagerSize.s30,
                                    // backgroundImage: ExactAssetImage(AssetManager),
                                  ),
                                ),
                                Positioned(
                                  right:10,
                                  top:5,
                                  child:  index==indexParameter ?Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(250)
                                    ),

                                  ):Container(),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Text(instCatList[index].categoryName)
                        //  backgroundImage:  (AssetManager.onBoarding3,fit: BoxFit.cover))
                      ],
                    ),
                  );

                  //Center(child: widgetCategory( instCat: instCatList[index]));
                }),
          )



        ),
                   isViewAll? Padding(
          padding: const EdgeInsets.only(left:AppSize.s8,right: AppSize.s8),
          child: Container(
            margin: const EdgeInsets.only(left:AppSize.s0_5),
            decoration: BoxDecoration(
              //color: Colors.red,
                borderRadius: BorderRadius.circular(10)),

            height: getHeight(context) / AppSize.s6,
            width: getWidth(context),
            child: GetCarouselSlider(),
            //child:Cal
          ),
        ) :Container(),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [

           Padding(
             padding: const EdgeInsets.only(left:15.0),
             child:   Text('Newest',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
           ),
           Padding(
             padding: const EdgeInsets.only(right:15.0),
             child:   GestureDetector(
               onTap: ()
                 {



                   setState(() {
                     if (  isViewAll)
                       {
                         viewall='View Less';
                         controllerSearch.clear();
                         filterSearchResults(controllerSearch.text);
                       }
                     else
                       {
                         viewall='View All' ;
                       }
                     isViewAll=!isViewAll;


                   });
                  // Get.to(() => HomePageAll());
                 },
                 child: Text(viewall,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: ColorManager.primary),)),
           ),
         ],
       ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:AppSize.s4,right: AppSize.s4),
            child: Container(
                decoration:  BoxDecoration(

                    borderRadius: BorderRadius.circular(AppSize.s20),

                   //color: Colors.blue,
                    ),
                width: getWidth(context),
                height: getHeight(context), //FontManagerSize.s3,

                child: GridView.builder(
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        //(index);

                        Get.to(() =>  ProductDetails( instProd: instProdList[index]));
                      },
                      child: Stack(
                        children: [
                      Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                              tag: instProdList[index].productId,
                              child: Card(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppSize.s10)),
                                child: GridTile(
                                  header: Align(
                                    alignment: Alignment.topLeft,
                                    child:  Container(
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary.withOpacity(.9),
                                        borderRadius: const BorderRadius.only(
                                           // bottomLeft:Radius.circular(AppSize.s10),
                                            topLeft:Radius.circular(AppSize.s10)
                                        ),
                                      ),
                                      height: getHeight(context)/AppSize.s40,

                                      child: Padding(
                                        padding: const EdgeInsets.only(left:AppSize.s4),
                                        child: Text(instProdList[index].productCat),
                                      )),),
                                footer: Container(
                                    decoration: BoxDecoration(
                                      color: ColorManager.white.withOpacity(.6),
                                      borderRadius:const  BorderRadius.only(
                                        bottomLeft:Radius.circular(AppSize.s10),
                                          bottomRight:Radius.circular(AppSize.s10)
                                             ),
                                    ),
                                    height: getHeight(context)/FontManagerSize.s24,

                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(' ${instProdList[index].productName}'
                                        ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                      Text(' Price :${instProdList[index].productPrice} \$'
                                        ,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: ColorManager.primary),),

                                    ],
                                  )
                                ),

                                child: Container(
                                            height: getHeight(context)/AppSize.s20,
                                            //width: 80,
                                            decoration: BoxDecoration(

                                                borderRadius: BorderRadius.circular(AppSize.s10),

                                              image:  DecorationImage(
                                                  fit: BoxFit.fill,         image: AssetImage(//AssetManager.mancat
                                                instProdList[index].productImage,
                                                  )),
                                              color: ColorManager.primary.withOpacity(.9),
                                            ),)

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
                                //             child: Icon(
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
                              right:AppSize.s4 ,child:IconButton(onPressed: () {

                            loadProductinit();

                          },icon: Icon(Icons.favorite, color: Colors.red,)

                          )

                          )
                        ],
                      ),
                    );
                  },
                  itemCount: instProdList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                )),
          ),
        )
      ],
    );
  }
}

// class GetLandScapeOrient extends StatelessWidget {
//   const GetLandScapeOrient({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//               top: FontManagerSize.s12, left: AppSize.s6, right: AppSize.s6),
//           child: TextFormField(
//             showCursor: true,
//             // readOnly: true,
//             //controller: controllerLoginUserName,
//             decoration: InputDecoration(
//                 label: Text(StringManager.search.tr),
//                 hintText: StringManager.userNameHint.tr,
//                 //  prefix: Text(StringManager.userName),
//                 prefixIcon: const Icon(Icons.search),
//                 // errorText: (snapshot.data ?? true)
//                 //     ? null
//                 //     : StringManager.usernameError,
//                 suffix: Text(StringManager.userName.tr),
//                 //  suffixText: StringManager.userName,
//                 suffixIcon: const Icon(Icons.remove_red_eye_outlined)),
//           ),
//         ),
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(AppSize.s4),
//               child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: 10,
//                   itemBuilder: (context, int index) {
//                     return const Center(child: WidgetCategory());
//                   }),
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(AppSize.s4),
//                   child: Container(
//                     margin: const EdgeInsets.all(AppSize.s0_5),
//                     decoration: BoxDecoration(
//                         //color: Colors.red,
//                         borderRadius: BorderRadius.circular(10)),
//
//                     height: get_height(context) * .25,
//                     width: get_width(context) * .7,
//                     child: GetCarouselSlider(),
//                     //child:Cal
//                   ),
//                 ),
//                 // Container(
//                 //   height: get_height(context) * .35,
//                 //   width: get_width(context) * .7, //FontManagerSize.s3,
//                 //   color: Colors.blue,
//                 // ),
//               ],
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
