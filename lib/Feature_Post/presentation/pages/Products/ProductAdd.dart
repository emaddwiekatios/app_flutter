//import 'dart:html';

import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:async';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

import 'package:date_format/date_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:paychalet/Products/ProductsMain.dart';
//import 'package:paychalet/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

class ProductAdd extends StatefulWidget {
  var Docs_max;
  ProductAdd({@required this.Docs_max});
  @override
  _ProductAddState createState() => _ProductAddState();
}

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
bool isSave = false;
String? _retrieveDataError;
typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
final ImagePicker _picker = ImagePicker();
final TextEditingController maxWidthController = TextEditingController();
final TextEditingController maxHeightController = TextEditingController();
final TextEditingController qualityController = TextEditingController();

final CollectionReference _Categoryss =
    FirebaseFirestore.instance.collection('Category');

class _ProductAddState extends State<ProductAdd> {
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
    contProductid.text=widget.Docs_max.toString();
    getCategory();
    getCurrentUser();
    //  print("inside init");
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
  String? imagename;
  //PickedFile sampleimage;
  File? sampleimage;
  var currentdate;
  int state = 0;
  var url2;

  List<String> list_cat = [];

  String _selectedCat = 'Category';

  List<String> list_Providers = [];

  String _selectedProviders = 'Providers';

  List<String> list_currency = ['Shakel', 'Dollar'];

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

  Widget build(BuildContext context) {
    var pheight = MediaQuery.of(context).size.height;
    var pwidth = MediaQuery.of(context).size.width;

//    var appLanguage = Provider.of<AppLanguage>(context);

    return SafeArea(
      child: Scaffold(
        //  resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        // drawer: Appdrawer(),
        body: GestureDetector(
          onTap: () {
            print('ontap');
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
                  decoration: BoxDecoration(
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
                    print('inside button');
                    print('inside button');
                    //_scaffoldKey.currentState.openDrawer();
                    // Navigator.of(context).pushReplacement(
                    //   new MaterialPageRoute(
                    //       builder: (BuildContext context) => new main_page()),
                    // );
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 15,
                left: MediaQuery.of(context).size.width / 2 -
                    ('Add Product'.toString().length * 8),
                child: Text(
                  'Add Product',
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
                      child: Container(
                          // color: Colors.red,
                          //   height: MediaQuery.of(context).size.height/2,
                          //   width: MediaQuery.of(context).size.width,

                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 4,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Product Id',
                                      //'${AppLocalizations.of(context).translate('Product Id')} :'
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 4) -
                                    15,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: contProductid,
                                      onChanged: (value) {},
                                      validator: (input) {
                                        if (input!.isEmpty) {
                                          return 'Please Prod Id ';
                                        }
                                      },
                                      onSaved: (input) => imagename = input,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,

//                        prefixIcon: Icon(Icons.search,
//                            color: red2),
//                            size: 30.0),
                                          suffixIcon: IconButton(
                                              icon: Icon(Icons.cancel,
                                                  color: Colors.red,
                                                  // Color(getColorHexFromStr('#FEE16D')),
                                                  size: 20.0),
                                              onPressed: () {
                                                print('inside clear');
                                                contProductid.clear();
                                                contProductid.clear();
                                              }),
                                          contentPadding: EdgeInsets.only(
                                              left: 15.0, top: 15.0, right: 15),
                                          hintText: 'Product Id',
                                          // AppLocalizations.of(context).translate('Product Id'),

                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Quicksand'))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 4,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ElevatedButton(
                                      //elevation: 0,
                                      onPressed: () {
                                       //  Navigator.of(context).pushReplacementNamed('/MainPage');
                                         DatePicker.showDatePicker(context,
                                             showTitleActions: true,
                                             minTime: DateTime(2020, 1, 1),
                                             maxTime: DateTime(2024, 12, 31),
                                        onChanged: (date) {_date=date;},
                                        onConfirm: (date) {date=date;},
                                        currentTime: DateTime.now()
                                        //, locale: LocaleType.en

                                                       );



                                      },
                                      //  color: Colors.white,
                                      //padding: EdgeInsets.only(left: (5.0), top: 5.0),
                                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                                      child: Text(
                                        '${formatDate(_date, [
                                              yyyy,
                                              '-',
                                              M,
                                              '-',
                                              dd,
                                              ' '
                                            ])}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 4,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Product_name',
                                      // '${AppLocalizations.of(context).translate('Product_name')} :'
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 4) -
                                    15,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: TextFormField(
                                      controller: contProductname,
                                      onChanged: (value) {},
                                      validator: (input) {
                                        if (input!.isEmpty) {
                                          return 'Please Prod Name ';
                                        }
                                      },
                                      onSaved: (input) => imagename = input,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
//                        prefixIcon: Icon(Icons.search,
//                            color: red2),
//                            size: 30.0),
                                          suffixIcon: IconButton(
                                              icon: Icon(Icons.cancel,
                                                  color: Colors.cyan, //(
                                                  //   getColorHexFromStr('#FEE16D')
                                                  //),
                                                  size: 20.0),
                                              onPressed: () {
                                                print('inside clear');
                                                contProductname.clear();
                                                contProductname.clear();
                                              }),
                                          contentPadding: EdgeInsets.only(
                                              left: 15.0, top: 15.0, right: 15),
                                          // hintText: AppLocalizations.of(context).translate('Product_name'),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Quicksand'))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          isSave ? CircularProgressIndicator() : SizedBox(),
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 4,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Category',
                                      //  '${AppLocalizations.of(context).translate('Category')} :'
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 4) -
                                    15,
                                child: Material(
                                  elevation: 5.0,
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
                                                    list_cat.map((String val) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    child: new Text(val),
                                                  );
                                                }).toList(),
                                                hint: Text(_selectedCat),
                                                onChanged: (newVal) {
                                                  this.setState(() {
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
                                            size: 15,
                                          ),
                                          onPressed: () async {
                                            //print('ffffff');
                                           // setState(() {
                                            //  maxCatId=await getDocumentMaxId('Categorys','Cat_Id');
                                           // });
                                            
                                        
                                            //getCategory();
                                            // FirebaseFirestore.instance.collection('Categorys').get().then((QuerySnapshot querySnapshot) {
                                            //   querySnapshot.docs.forEach((element) {
                                            //   setState(() {
                                            //     list_cat.add(
                                            //         element['Cat_Name']);
                                            //   });
                                            // });
                                            // });
                                          }

                                          ),

                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          // getData().then((results) {
                                          //   setState(() {
                                          //     Navigator.pushNamed(
                                          //         context, '/CategoryAdd');
                                          //   });
                                          // });
                                        },
                                      ),
//                                    RaisedButton(
//                                        elevation: 7.0,
//                                        child: Text( AppLocalizations.of(context).translate('Add Category')),
//                                        textColor: Colors.white,
//                                        color: Colors.red,
//                                        onPressed: () {
//                                          Navigator.pushNamed(
//                                              context, '/CategoryAdd');
//                                        }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width / 4,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Product Price',
                                      // '${AppLocalizations.of(context).translate('Product_amt')} :'
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width / 4) -
                                    15,
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: TextFormField(
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            focusNode: _nodeText1,
                                            controller: contProductAmt,
                                            onChanged: (value) {},
                                            validator: (input) {
                                              if (input!.isEmpty) {
                                                return 'Please Prod Cost ';
                                              }
                                            },
                                            onSaved: (input) =>
                                                imagename = input,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
//                        prefixIcon: Icon(Icons.search,
//                            color: red2),
//                            size: 30.0),
                                                suffixIcon: IconButton(
                                                    icon: Icon(Icons.cancel,
                                                        color: Colors.blue,
                                                        size: 20.0),
                                                    onPressed: () {
                                                      print('inside clear');
                                                      contProductAmt.clear();
                                                      contProductAmt.clear();
                                                    }),
                                                contentPadding: EdgeInsets.all(
                                                    10.0), //, top: 15.0,right:15),
                                                // hintText: AppLocalizations.of(context).translate('Product_amt'),

                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'Quicksand'))),
                                      ),
                                      Text("curr"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: DropdownButton<String>(
                                              items: list_currency
                                                  .map((String val) {
                                                return new DropdownMenuItem<
                                                    String>(
                                                  value: val,
                                                  child: new Text(val),
                                                );
                                              }).toList(),
                                              hint: Text(_selectedcurrency),
                                              onChanged: (newVal) {
                                                this.setState(() {
                                                  _selectedcurrency = newVal!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  // elevation: 7.0,
                                  child: Text('save'),

                                  ///AppLocalizations.of(context).translate('Save'),
                                  // Text("Save"),
                                  //textColor: Colors.white,
                                  //color: Colors.red,
                                  onPressed: () {
                                    print('inside save');
                                    showDialog<void>(
                                      context: context,
                                      // false = user must tap button, true = tap outside dialog
                                      builder: (BuildContext dialogContext) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    );

                                    uploadimage();
                                  }),
                              ElevatedButton(
                                //elevation: 7.0,
                                child: Text(
                                  'Canceled',
                                  //  AppLocalizations.of(context).translate('Cancel')
                                ),

                                // Text("Upload"),
                                //  textColor: Colors.white,
                                // color: Colors.red,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),

                            ],
                          ),
                          Container(
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            image = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            setState(() {
                                              //update UI
                                            });
                                          },
                                          child: Text("Pick Image camera")),
                                      ElevatedButton(
                                          onPressed: () async {
                                            image = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              //update UI
                                            });
                                          },
                                          child: Text("Pick Image gallery")),
                                    ],
                                  ),
                                  image == null
                                      ? Container()
                                      : Container(
                                          height: getHeight(context) / 4,
                                          width: getWidth(context) - 20,
                                          child: Image.file(File(image!.path)))
                                ],
                              ))
                        ],
                      )),
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

  Future<void> uploadimage() async {
    final Reference ref = FirebaseStorage.instance
        .ref('/File')
        .child('${contProductname.text}.jpg');
    final UploadTask task = ref.putFile(File(image!.path));
    task.then((res) {
      res.ref.getDownloadURL().then((value) {
        url2 = value;
        print(value);
        addisubcollection();
      });

      //url=downurl as String;
    });
  }



  void addisubcollection() {
    final todayDate = DateTime.now();
    currentdate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);

    FirebaseFirestore.instance.collection("Clean_App_Products_New").add({
      "productId": contProductid.text,
      "productName": contProductname.text,
      "productImage": url2,
      "productPrice": contProductAmt.text,
      "productCat": _selectedCat ,//contProductcat.text,
      "productEntryDate": DateTime.now(),
      "favoriteFlag": "0", //contProductfav.text
    });
    Navigator.of(context).pop();
  }


  getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = await _auth.currentUser;

    //final uid = user.uid;
    //return user.email;
  }

  addimagedata() {
    final todayDate = DateTime.now();
    currentdate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);

    getCurrentUser();
    FirebaseFirestore.instance.collection("Clean_App_Products_New").doc().set({
      'Product_id': contProductid.text,
      'Product_name': contProductname.text,
      // 'Product_desc': contProductdesc.text,
      'Product_amt': contProductAmt.text,
      // 'Product_to': _selectedProviders ,//contProductTo.text,
      'Product_fav': "false",
      'Product_cat': _selectedCat,
      'Product_entry_date': _date, // currentdate,
      'Product_modify_date': todayDate, // currentdate,
      'Product_img': url2,
      'Product_from': _selectedpays_from,
      'Product_user': user?.email.toString(),
      'Product_currency': _selectedcurrency
    });

    FirebaseFirestore.instance.collection("ProductsHistory").doc().set({
      'Product_id': contProductid.text,
      'Product_name': contProductname.text,
      'Product_desc': contProductdesc.text,
      'Product_amt': contProductAmt.text,
      'Product_to': contProductTo.text,
      'Product_fav': "false",
      'Product_cat': _selectedCat,
      'Product_entry_date': todayDate, //currentdate,
      'Product_modify_date': todayDate, //currentdate,
      'Product_img': url2,
      'Product_from': _selectedpays_from,
      'Product_user': user?.email.toString(),
      'Product_currency': _selectedcurrency
    });

    _showSnackbar(contProductname.text);
    setState(() {
      contProductid.text = (int.parse(contProductid.text) + 1).toString();
      contProductname.clear();
      contProductdesc.clear();
      contProductAmt.clear();
      contProductTo.clear();
    });
  }

  Future<http.Response> addProducttosql() async {
    print('inside add');
    final todayDate = DateTime.now();
    currentdate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);
    var url =
        ("http://emaddwiekat.atwebpages.com/Sales/Flutter/AddProductd.php");

    var response = await http.post(Uri.parse(url), body: {
      "Product_id": contProductid.text,
      "Product_name": contProductname.text,
      "Product_desc": contProductdesc.text,
      "Product_amt": contProductAmt.text,
      "Product_to": _selectedProviders,
      "Product_fav": "false",
      "Product_cat": _selectedCat,
      "Product_entry_date": _date.toString(), // currentdate,
      "Product_modify_date": currentdate.toString(), // currentdate,
      "Product_img": 'url2',
      "Product_from": _selectedpays_from,
      "Product_user": user!.email.toString(),
      "Product_currency": _selectedcurrency
    });
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }





  printlistproviders() {
    // if (cars != null) {
    //   list_Providers.clear();
    //   for (var i = 0; i < carsproviders.docs.length; i++) {
    //     list_Providers.add(carsproviders.docs[i].data()['Provider_name']);
    //   }
    // } else {
    //   print("error");
    // }
  }

  print_data() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  print_data_list() {
    // print('inside func list');
    // if (cars_token != null) {
    //
    //   for (var i = 0; i < cars_token.docs.length; i++) {
    //     print('token data ');
    //     print(cars_token.docs[i].data());
    //     //list_cat.add(cars.docs[i].data()['cat_name']);
    //   }
    // } else {
    //   print("error");
    // }
  }

  printlist() {
    print(_Categoryss);
    if (cars != null) {
      list_cat.clear();
      cars!.docs.forEach((element) {
        setState(() {
          setState(() {
            list_cat.add(element['Cat_Name']);
          });

        });
      });

      // querySnapshot.docs.forEach((element) {
      //   setState(() {
      //     list_cat.add(element['Cat_Name']);
      //   });
    } else {
      print("error");
    }
  }

  void _showSnackbar(String name) {
//    final scaff = Scaffold.of(context);
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text('Tranaction ${name} Saved'),
//       backgroundColor: Colors.amber,
//       duration: Duration(seconds: 5),
//       action: SnackBarAction(
//         label: 'Done', onPressed: _scaffoldKey.currentState.hideCurrentSnackBar,
//       ),
//     ));
  }




  void getCategory() {
    list_cat.clear();
    FirebaseFirestore.instance.collection('Categorys').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          list_cat.add(
              element['Cat_Name']);
        });
      });
    });

  }
//  void _onPressed() {
//    print('inside onpreesses');
//    FirebaseFirestore.instance.collection("users").get().then((querySnapshot) {
//      querySnapshot.docs.forEach((result) {
//        print(result.data);
////        FirebaseFirestore.instance
////            .collection("users")
////            .doc(result.id)
////            .collection("tokens")
////            .get()
////            .then((querySnapshot) {
////          querySnapshot.docs.forEach((result) {
////            print(result.data);
////          });
////        });
//      });
//    });
//  }
//
//
//  void _onPressedone() async{
//    final User _auth = FirebaseAuth.instance.currentUser;
//    FirebaseFirestore.instance
//        .collection("users")
//        .doc(_auth.uid)
//        .collection("tokens")
//        .get().then((value){
//          value.docs.forEach((element) {
//            print(element.data()['token']);
//          });
//
//    });
//  }
//
//  void _onPressedall() async{
//

//    FirebaseFirestore.instance
//        .collection("users")
//        .doc(_auth.uid)
//        .collection("tokens")
//        .get().then((value){
//      print(value.docs[0].data()['token']);
//    });
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
