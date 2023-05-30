//import 'dart:html';

import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductsClass.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:async';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';

import 'dart:math' as Math;

import 'package:date_format/date_format.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../core/resource/ColorManger.dart';
import '../../../../core/resource/Construct.dart';
import '../../../../core/resource/FontManager.dart';
import '../../../../core/resource/StringManager.dart';
import '../../../../core/resource/ValueManger.dart';
import '../Category/CategoryAdd.dart';

// ignore: must_be_immutable
class ProductEdit extends StatefulWidget {
  //var Docs_max;
  ProductEdit({required this.instProd});

  ProductClass instProd;
  @override
  _ProductEditState createState() => _ProductEditState();
}
var _productss=getCollectionReference(StringManager.collectionProducts);
//final CollectionReference _productss = FirebaseFirestore.instance.collection(StringManager.collection_Products);
QuerySnapshot? cars;
QuerySnapshot? cars_token;
QuerySnapshot? carsproviders;
const CURVE_HEIGHT = 160.0;
const AVATAR_RADIUS = CURVE_HEIGHT * 0.28;
const AVATAR_DIAMETER = AVATAR_RADIUS * 2;
Color? colorOne;
Color? colorTwo;
Color? colorThree;
User? user;
dynamic _pickImageError;
bool isVideo = false;

String? _retrieveDataError;
typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
final ImagePicker _picker = ImagePicker();
final TextEditingController maxWidthController = TextEditingController();
final TextEditingController maxHeightController = TextEditingController();
final TextEditingController qualityController = TextEditingController();

final CollectionReference _Categoryss =
FirebaseFirestore.instance.collection('Category');

class _ProductEditState extends State<ProductEdit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  add  keyboard action

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final FocusNode _nodeText4 = FocusNode();
  final FocusNode _nodeText5 = FocusNode();
  final FocusNode _nodeText6 = FocusNode();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].

  /// end add  keyboard action
  //  Color pyellow = Color(red4);
//  File? _image;
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  // PickedFile _imageFile;
  //File? _imageFile;
  DateTime _date = DateTime.now();
  QuerySnapshot? carsinvoice;
  int maxCatId=0;
  final GlobalKey<ScaffoldState> _scaffoldKeysnak =
  new GlobalKey<ScaffoldState>();

  @override
  void initState()  {
    super.initState();
    contProductid.text=widget.instProd.productId.toString();
    contProductAmt.text=widget.instProd.productPrice.toString();

    contProductname.text=widget.instProd.productName;
    _selectedCat=widget.instProd.productCat.toString();
    //_date=DateTime.now().add(Duration(days: 3));//
    //print(widget.instProd.productEntryDate);
    _date= widget.instProd.productEntryDate;
   //image= Image.file(File(widget.instProd.productImage!.path)))
    getCategory();
    //getCurrentUser();
    // //print("inside init");
    colorOne = Colors.red;
    colorTwo = Colors.red;
    colorThree = Colors.red;

  }

/*
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
*/
  String? imageName;
  //PickedFile sampleimage;
  File? sampleImage;
  var currentDate;
  int state = 0;
  var url2;

  List<String> listCat = [];

  String _selectedCat = 'Category';

  List<String> listProviders = [];

  String selectedProviders = 'Providers';

  List<String> listCurrency = ['shakel', 'Dollar'];

  String _selectedcurrency = 'Shakel';

  List<String> list_pays_from = ['Emad', 'Walid', 'Emad+Walid'];

  String _selectedpays_from = 'Emad';

  TextEditingController contProductid = new TextEditingController();
  TextEditingController contProductname = new TextEditingController();
  TextEditingController contProductAmt = new TextEditingController();
  TextEditingController contProductfav = new TextEditingController();
  TextEditingController contProductcat = new TextEditingController();
  TextEditingController contProductdesc = new TextEditingController();
  TextEditingController contProducturl = new TextEditingController();
  TextEditingController contProductdentrydate = new TextEditingController();
  TextEditingController contProductTo = new TextEditingController();
  TextEditingController contProductdate = new TextEditingController();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    var pheight = MediaQuery.of(context).size.height;
    var pwidth = MediaQuery.of(context).size.width;



    return SafeArea(
      child: Scaffold(

        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        // drawer: Appdrawer(),
        body: GestureDetector(
          onTap: () {
           //print('ontap');
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
                    //  color: red4,
                  ),
                  child: CustomPaint(
                    child: Container(
                      height: 400.0,
                    ),
                    painter: _MyPainter(),
                  ),
                ),
              ),

              //background color
              Positioned(
                bottom: -125,
                left: -150,
                child: Container(
                  height: 250, //MediaQuery.of(context).size.height / 4,
                  width: 250, //MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(250),
                    color: Colors.red,
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
                      color: Colors.red),
                ),
              ),
              //menu
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                 
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 15,
                left: MediaQuery.of(context).size.width / 2 -
                    ('Edit Product'.toString().length * 8),
                child: Text(
                  'Edit Product',
                  //AppLocalizations.of(context).translate('Add Product'),

                  //'Add Product',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              //body
              Positioned(
                top: 100,
                right: 0,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: pheight + 200,
//                          MediaQuery.of(context).size.height >= 775.0
//                              ? MediaQuery.of(context).size.height
//                              : 775.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //prodid
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: defaultTextFormField(
                                obscureText: false,
                                fieldController: contProductid,
                                onChange: (value) =>defaultTextFieldOnChange(value!,'Product ID'),

                                type: TextInputType.emailAddress,
                                prefixIcon: IconButton(
                                    icon: const Icon(Icons.account_circle_rounded,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {}),
                                suffixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.cancel
                                        , color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {
                                      setState(() {
                                        contProductid.clear();

                                      });
                                    }),
                                validate:(value)=>defaultTextFieldValidator(value!,'Product Id'),

                                hintTextLabel: 'Product Id'),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:pheight/FontManagerSize.s20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:Border.all(color: Colors.black)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: const Padding(
                                        padding:  EdgeInsets.only(left:AppSize.s10),
                                        child: Text('Product_Date'
                                          //  '${AppLocalizations.of(context).translate('Product_Date')} :'
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),


                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        height: pheight/AppSize.s10,
                                        width:
                                        MediaQuery.of(context).size.width / 2,
                                        child: defaltElevationButton(nameButton:'${formatDate(_date, [yyyy,'-',M,'-', dd,' '])}',
                                          onTabButton: () {
                                            DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(2020, 1, 1),
                                              maxTime: DateTime(2024, 12, 31),
                                              onChanged: (date) {_date=date;},
                                              onConfirm: (date) {date=date;},
                                              currentTime: DateTime.now(),
                                            );},
                                          parBackGroundColor: Colors.grey[200]!,
                                          parBorderRadius: 5,
                                          parBorderWidth: 5,
                                          parFontSize: 15,
                                          parForegroundColor: Colors.black,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //   locale: LocaleType.ar
                                          DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2020, 1, 1),
                                            maxTime: DateTime(2024, 12, 31),
                                            onChanged: (date) {_date=date;},
                                            onConfirm: (date) {date=date;},
                                            currentTime: DateTime.now(),);
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: defaultTextFormField(
                                obscureText: false,
                                fieldController: contProductname,
                                onChange: (value) =>defaultTextFieldOnChange(value!,'Product Name'),

                                type: TextInputType.emailAddress,
                                prefixIcon: IconButton(
                                    icon: const Icon(Icons.account_circle_rounded,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {}),
                                suffixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.cancel
                                        , color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {
                                      setState(() {
                                        contProductname.clear();

                                      });
                                    }),
                                validate:(value)=>defaultTextFieldValidator(value!,'Product Name'),

                                hintTextLabel: 'Product Name'),
                          ),


                          //category
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,right:8),
                            child: Container(
                              height:pheight/FontManagerSize.s20,

                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Material(
                                        elevation: 0.0,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: const Padding(
                                          padding:  EdgeInsets.all(AppSize.s12),
                                          child: Text(
                                            'Category',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex:3,
                                    child: Material(
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0, right: 0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: DropdownButton<String>(
                                                    items:
                                                    listCat.map((String val) {
                                                      return  DropdownMenuItem<
                                                          String>(
                                                        value: val,
                                                        child:  Text(val),
                                                      );
                                                    }).toList(),
                                                    hint: Text(_selectedCat),
                                                    onChanged: (newVal) {
                                                      setState(() {
                                                        _selectedCat = newVal!;
                                                      });
                                                    }),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.refresh,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              onPressed: () async {
                                                getCategory();

                                              }

                                          ),

                                          IconButton(
                                              icon: const Icon(
                                                  Icons.add, size: 20),
                                              onPressed: () async {
                                                //print('go to cat add');
                                                var maxCatId = await getDocumentMaxId(
                                                    'Categorys', 'catId');
                                                Get.to(CategoryAdd(
                                                  Docs_max: maxCatId + 1,
                                                ));
                                              }),



                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: defaultTextFormField(
                                obscureText: false,
                                fieldController: contProductAmt,
                                onChange: (value) =>defaultTextFieldOnChange(value!,'Product Amt'),

                                type: TextInputType.emailAddress,
                                prefixIcon: IconButton(
                                    icon: const Icon(Icons.account_circle_rounded,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {}),
                                suffixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.cancel
                                        , color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {
                                      setState(() {
                                        contProductAmt.clear();

                                      });
                                    }),
                                validate:(value)=>defaultTextFieldValidator(value!,'Product Amt'),

                                hintTextLabel: 'Product Amt'),
                          ),


                          Container(
                              padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [


                                  image == null
                                      ? Container(
                                    height:
                                    getHeight(context) / FontManagerSize.s4,
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(AppSize.s20),
                                      // color: Colors.tealAccent,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            // image: AssetImage(AssetManager.mancat4)
                                            image: NetworkImage(
                                                widget.instProd.productImage))),



                                  )
                                      : Container(
                                      height: getHeight(context) / 4,
                                      width: getWidth(context) - 20,
                                      child: Image.file(File(image!.path)))
                                ],
                              )),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                defaltElevationButton(nameButton:'Update',
                                  onTabButton: () {
                                    showDialog<void>(
                                      context: context,
                                      // false = user must tap button, true = tap outside dialog
                                      builder: (BuildContext dialogContext) {
                                        return Center(
                                            child: CircularProgressIndicator()
                                        );
                                      },
                                    );
                                    var productMap={
                                      "productId": int.parse(contProductid.text),
                                      "productName": contProductname.text,
                                      // "productImage": url2,
                                      "productPrice": contProductAmt.text,
                                      "productCat": _selectedCat ,//contProductcat.text,
                                      "productEntryDate": _date,
                                      "favoriteFlag": 0, //contProductfav.text
                                    };
                                    // ignore: use_build_context_synchronously
                                    updateDataFireStore(StringManager.collectionProducts, productMap,widget.instProd.docsId);
                                    showMessage(context,'You have successfully Updated ${contProductname.text} product',Colors.green);
                                    Navigator.of(context).pop();
                                  },
                                  parBackGroundColor: ColorManager.secondary,
                                  parBorderRadius: 5,
                                  parBorderWidth: 5,
                                  parFontSize: 15,
                                  parForegroundColor: Colors.black,
                                ),
                                defaltElevationButton(nameButton:'Cancel',
                                  onTabButton: () {
                                    Navigator.pop(context);
                                  },
                                  parBackGroundColor: ColorManager.secondary,
                                  parBorderRadius: 5,
                                  parBorderWidth: 5,
                                  parFontSize: 15,
                                  parForegroundColor: Colors.black,
                                ),
                                defaltElevationButton(nameButton:'Camera',
                                  onTabButton: () async {
                                    image = await ImagePicker()
                                        .pickImage(
                                        source: ImageSource.camera);
                                    setState(() {
                                      //update UI
                                    });
                                  },
                                  parBackGroundColor: ColorManager.secondary,
                                  parBorderRadius: 5,
                                  parBorderWidth: 5,
                                  parFontSize: 15,
                                  parForegroundColor: Colors.black,
                                ),

                                defaltElevationButton(nameButton:'Gallery',
                                  onTabButton: () async {
                                    image = await ImagePicker()
                                        .pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {
                                      //update UI
                                    });
                                  },
                                  parBackGroundColor: ColorManager.secondary,
                                  parBorderRadius: 5,
                                  parBorderWidth: 5,
                                  parFontSize: 15,
                                  parForegroundColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     ElevatedButton(
                          //       // elevation: 7.0,
                          //         child: Text('Update'),
                          //
                          //
                          //
                          //         onPressed: ()  {
                          //
                          //            var productMap={
                          //             "productId": contProductid.text,
                          //             "productName": contProductname.text,
                          //             // "productImage": url2,
                          //             "productPrice": contProductAmt.text,
                          //             "productCat": _selectedCat ,//contProductcat.text,
                          //             "productEntryDate": _date,
                          //             "favoriteFlag": 0, //contProductfav.text
                          //           };
                          //           // ignore: use_build_context_synchronously
                          //           updateDataFireStore(StringManager.collection_Products, productMap,widget.instProd.docsId);
                          //            showMessage(context,'You have successfully Updated ${contProductname.text} product');
                          //
                          //
                          //         }),
                          //
                          //     IconButton(icon: Icon(Icons.photo_camera),
                          //         onPressed: () async {
                          //           image = await ImagePicker()
                          //               .pickImage(
                          //               source: ImageSource.camera);
                          //           setState(() {
                          //             //update UI
                          //           });
                          //         },
                          //       ),
                          //     IconButton(icon:const Icon(Icons.photo_album_sharp),
                          //         onPressed: () async {
                          //           image = await ImagePicker()
                          //               .pickImage(
                          //               source:
                          //               ImageSource.gallery);
                          //           setState(() {
                          //             //update UI
                          //           });
                          //         },
                          //         ),
                          //     ElevatedButton(
                          //       //elevation: 7.0,
                          //       child: Text(
                          //         'Canceled',
                          //         //  AppLocalizations.of(context).translate('Cancel')
                          //       ),
                          //
                          //       // Text("Upload"),
                          //       //  textColor: Colors.white,
                          //       // color: Colors.red,
                          //       onPressed: () {
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],

            //  ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    final Reference ref = FirebaseStorage.instance
        .ref('/File')
        .child('${contProductname.text}.jpg');
    final UploadTask task = ref.putFile(File(image!.path));
    task.then((res) {
      res.ref.getDownloadURL().then((value) {
        url2 = value;
    
        addDataFireStore();
      });

    });
  }


                      // Clear the text fields



  void addDataFireStore() {
    final todayDate = DateTime.now();
    currentDate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);

    FirebaseFirestore.instance.collection("Clean_App_Products_New").add({
      "productId": contProductid.text,
      "productName": contProductname.text,
      "productImage": url2,
      "productPrice": contProductAmt.text,
      "productCat": _selectedCat ,
      "productEntryDate": currentDate,
      "favoriteFlag": "0",
    });
    Navigator.of(context).pop();
  }


  getCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;

    //final uid = user.uid;
    //return user.email;
  }


  Future<http.Response> addProductSql() async {
   //print('inside add');
    final todayDate = DateTime.now();
    currentDate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);
    var url =
    ("http://emaddwiekat.atwebpages.com/Sales/Flutter/AddProductd.php");

    var response = await http.post(Uri.parse(url), body: {
      "Product_id": contProductid.text,
      "Product_name": contProductname.text,
      "Product_desc": contProductdesc.text,
      "Product_amt": contProductAmt.text,
      "Product_to": selectedProviders,
      "Product_fav": "false",
      "Product_cat": _selectedCat,
      "Product_entry_date": _date.toString(),
      "Product_modify_date": currentDate.toString(),
      "Product_img": 'url2',
      "Product_from": _selectedpays_from,
      "Product_user": user!.email.toString(),
      "Product_currency": _selectedcurrency
    });
   //print("${response.statusCode}");
   //print("${response.body}");
    return response;
  }






  print_data() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  print_data_list() {
    ////print('inside func list');
    // if (cars_token != null) {
    //
    //   for (var i = 0; i < cars_token.docs.length; i++) {
    //    //print('token data ');
    //    //print(cars_token.docs[i].data());
    //     //list_cat.add(cars.docs[i].data()['cat_name']);
    //   }
    // } else {
    //  //print("error");
    // }
  }

  printList() {
 
    if (cars != null) {
      listCat.clear();
      for (var element in cars!.docs) {
        setState(() {
          setState(() {
            listCat.add(element['Cat_Name']);
          });

        });
      }

     
    } else {
     //print("error");
    }
  }






  void getCategory() {
    listCat.clear();
    FirebaseFirestore.instance.collection('Categorys').get().then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          listCat.add(
              element['catName']);
        });
      }
    });

  }


  // Future<void> _createOrUpdate([String? Docsid]) async {
  //   await _productss.doc(Docsid).update({
  //     "productId": contProductid.text,
  //     "productName": contProductname.text,
  //    // "productImage": url2,
  //     "productPrice": contProductAmt.text,
  //     "productCat": _selectedCat ,//contProductcat.text,
  //     "productEntryDate": _date,
  //     "favoriteFlag": 0, //contProductfav.text
  //   });
  //   // ignore: use_build_context_synchronously
  //   showMessage(context,'You have successfully Updated ${contProductname.text} product');
  // }


  void change_date(DateTime newDate) {
    setState(() {
      _date=newDate;

    });
  }

}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;

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
