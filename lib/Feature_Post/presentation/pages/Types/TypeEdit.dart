//import 'dart:html';

import 'package:clean_arch_app/Feature_Post/presentation/pages/Types/TypesClass.dart';
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
import '../TypeCategory/TypeCategoryAdd.dart';

// ignore: must_be_immutable
class TypeEdit extends StatefulWidget {
  //var Docs_max;
  TypeEdit({required this.instProd});

  TypeClass instProd;
  @override
  _TypeEditState createState() => _TypeEditState();
}

var _Typess = getCollectionReference(StringManager.collectionTypes);
//final CollectionReference _Typess = FirebaseFirestore.instance.collection(StringManager.collection_Types);
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

class _TypeEditState extends State<TypeEdit> {
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
  int maxCatId = 0;
  final GlobalKey<ScaffoldState> _scaffoldKeysnak =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    contTypeid.text = widget.instProd.TypeId.toString();
    contTypeAmt.text = widget.instProd.TypePrice.toString();

    contTypename.text = widget.instProd.TypeName;
    _selectedCat = widget.instProd.TypeCat.toString();
    //_date=DateTime.now().add(Duration(days: 3));//
    //print(widget.instProd.TypeEntryDate);
    _date = widget.instProd.TypeEntryDate;
    //image= Image.file(File(widget.instProd.TypeImage!.path)))
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

  TextEditingController contTypeid = new TextEditingController();
  TextEditingController contTypename = new TextEditingController();
  TextEditingController contTypeAmt = new TextEditingController();
  TextEditingController contTypefav = new TextEditingController();
  TextEditingController contTypecat = new TextEditingController();
  TextEditingController contTypedesc = new TextEditingController();
  TextEditingController contTypeurl = new TextEditingController();
  TextEditingController contTypedentrydate = new TextEditingController();
  TextEditingController contTypeTo = new TextEditingController();
  TextEditingController contTypedate = new TextEditingController();
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
                    ('Edit Type'.toString().length * 8),
                child: Text(
                  'Edit Type',
                  //AppLocalizations.of(context).translate('Add Type'),

                  //'Add Type',
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
                                fieldController: contTypeid,
                                onChange: (value) =>
                                    defaultTextFieldOnChange(value!, 'Type ID'),
                                type: TextInputType.emailAddress,
                                prefixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.account_circle_rounded,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {}),
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {
                                      setState(() {
                                        contTypeid.clear();
                                      });
                                    }),
                                validate: (value) => defaultTextFieldValidator(
                                    value!, 'Type Id'),
                                hintTextLabel: 'Type Id'),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: pheight / FontManagerSize.s20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: AppSize.s10),
                                        child: Text('Type_Date'
                                            //  '${AppLocalizations.of(context).translate('Type_Date')} :'
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        height: pheight / AppSize.s10,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: defaltElevationButton(
                                          nameButton: '${formatDate(_date, [
                                                yyyy,
                                                '-',
                                                M,
                                                '-',
                                                dd,
                                                ' '
                                              ])}',
                                          onTabButton: () {
                                            DatePicker.showDatePicker(
                                              context,
                                              showTitleActions: true,
                                              minTime: DateTime(2020, 1, 1),
                                              maxTime: DateTime(2024, 12, 31),
                                              onChanged: (date) {
                                                _date = date;
                                              },
                                              onConfirm: (date) {
                                                date = date;
                                              },
                                              currentTime: DateTime.now(),
                                            );
                                          },
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
                                          DatePicker.showDatePicker(
                                            context,
                                            showTitleActions: true,
                                            minTime: DateTime(2020, 1, 1),
                                            maxTime: DateTime(2024, 12, 31),
                                            onChanged: (date) {
                                              _date = date;
                                            },
                                            onConfirm: (date) {
                                              date = date;
                                            },
                                            currentTime: DateTime.now(),
                                          );
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
                                fieldController: contTypename,
                                onChange: (value) => defaultTextFieldOnChange(
                                    value!, 'Type Name'),
                                type: TextInputType.emailAddress,
                                prefixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.account_circle_rounded,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {}),
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {
                                      setState(() {
                                        contTypename.clear();
                                      });
                                    }),
                                validate: (value) => defaultTextFieldValidator(
                                    value!, 'Type Name'),
                                hintTextLabel: 'Type Name'),
                          ),

                          //category
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Container(
                              height: pheight / FontManagerSize.s20,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Material(
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: const Padding(
                                          padding: EdgeInsets.all(AppSize.s12),
                                          child: Text(
                                            'Category',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 8,
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
                                                    items: listCat
                                                        .map((String val) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: val,
                                                        child: Text(val),
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
                                              }),
                                          IconButton(
                                              icon: const Icon(Icons.add,
                                                  size: 20),
                                              onPressed: () async {
                                                //print('go to cat add');
                                                var maxCatId =
                                                    await getDocumentMaxId(
                                                        StringManager
                                                            .collectionTypeCategory,
                                                        'catId');
                                                Get.to(TypeCategoryAdd(
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
                                fieldController: contTypeAmt,
                                onChange: (value) => defaultTextFieldOnChange(
                                    value!, 'Type Amt'),
                                type: TextInputType.emailAddress,
                                prefixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.account_circle_rounded,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {}),
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.blue,
                                        // Color(getColorHexFromStr('#FEE16D')),
                                        size: 20.0),
                                    onPressed: () {
                                      setState(() {
                                        contTypeAmt.clear();
                                      });
                                    }),
                                validate: (value) => defaultTextFieldValidator(
                                    value!, 'Type Amt'),
                                hintTextLabel: 'Type Amt'),
                          ),

                          // Container(
                          //     padding:
                          //         EdgeInsets.only(top: 20, left: 20, right: 20),
                          //     alignment: Alignment.topCenter,
                          //     child: Column(
                          //       children: [
                          //         image == null
                          //             ? Container(
                          //                 height: getHeight(context) /
                          //                     FontManagerSize.s4,
                          //                 // decoration: BoxDecoration(
                          //                 //     // borderRadius: BorderRadius.circular(AppSize.s20),
                          //                 //     // color: Colors.tealAccent,
                          //                 //     image: DecorationImage(
                          //                 //         fit: BoxFit.fill,
                          //                 //         // image: AssetImage(AssetManager.mancat4)
                          //                 //         image: NetworkImage(widget
                          //                 //             .instProd.TypeImage))),
                          //               )
                          //             : Container(
                          //                 height: getHeight(context) / 4,
                          //                 width: getWidth(context) - 20,
                          //                 child: Image.file(File(image!.path)))
                          //       ],
                          //     )),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                defaltElevationButton(
                                  heightButton: pheight / 20,
                                  nameButton: 'Update',
                                  onTabButton: () {
                                    showDialog<void>(
                                      context: context,
                                      // false = user must tap button, true = tap outside dialog
                                      builder: (BuildContext dialogContext) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    );

                                    updateDatacollection();

                                    showMessage(
                                        context,
                                        'You have successfully Updated ${contTypename.text} Type',
                                        Colors.green);

                                    Navigator.of(context).pop();
                                  },
                                  parBackGroundColor: ColorManager.secondary,
                                  parBorderRadius: 5,
                                  parBorderWidth: 5,
                                  parFontSize: 15,
                                  parForegroundColor: Colors.black,
                                ),
                                defaltElevationButton(
                                  heightButton: pheight / 20,
                                  nameButton: 'Cancel',
                                  onTabButton: () {
                                    Navigator.pop(context);
                                  },
                                  parBackGroundColor: ColorManager.secondary,
                                  parBorderRadius: 5,
                                  parBorderWidth: 5,
                                  parFontSize: 15,
                                  parForegroundColor: Colors.black,
                                ),
                                // defaltElevationButton(
                                //   nameButton: 'Camera',
                                //   onTabButton: () async {
                                //     image = await ImagePicker()
                                //         .pickImage(source: ImageSource.camera);
                                //     setState(() {
                                //       //update UI
                                //     });
                                //   },
                                //   parBackGroundColor: ColorManager.secondary,
                                //   parBorderRadius: 5,
                                //   parBorderWidth: 5,
                                //   parFontSize: 15,
                                //   parForegroundColor: Colors.black,
                                // ),
                                // defaltElevationButton(
                                //   nameButton: 'Gallery',
                                //   onTabButton: () async {
                                //     image = await ImagePicker()
                                //         .pickImage(source: ImageSource.gallery);
                                //     setState(() {
                                //       //update UI
                                //     });
                                //   },
                                //   parBackGroundColor: ColorManager.secondary,
                                //   parBorderRadius: 5,
                                //   parBorderWidth: 5,
                                //   parFontSize: 15,
                                //   parForegroundColor: Colors.black,
                                // ),
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
                          //            var TypeMap={
                          //             "TypeId": contTypeid.text,
                          //             "TypeName": contTypename.text,
                          //             // "TypeImage": url2,
                          //             "TypePrice": contTypeAmt.text,
                          //             "TypeCat": _selectedCat ,//contTypecat.text,
                          //             "TypeEntryDate": _date,
                          //             "favoriteFlag": 0, //contTypefav.text
                          //           };
                          //           // ignore: use_build_context_synchronously
                          //           updateDataFireStore(StringManager.collection_Types, TypeMap,widget.instProd.docsId);
                          //            showMessage(context,'You have successfully Updated ${contTypename.text} Type');
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

  // Future<void> uploadImage() async {
  //   final Reference ref =
  //       FirebaseStorage.instance.ref('/File').child('${contTypename.text}.jpg');
  //   final UploadTask task = ref.putFile(File(image!.path));
  //   task.then((res) {
  //     res.ref.getDownloadURL().then((value) {
  //       url2 = value;

  //       addDataFireStore();
  //     });
  //   });
  // }

  // Clear the text fields

  // void addDataFireStore() {
  //   final todayDate = DateTime.now();
  //   currentDate = formatDate(todayDate,
  //       [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);

  //   FirebaseFirestore.instance.collection("Clean_App_Types_New").add({
  //     "TypeId": contTypeid.text,
  //     "TypeName": contTypename.text,
  //     "TypeImage": url2,
  //     "TypePrice": contTypeAmt.text,
  //     "TypeCat": _selectedCat,
  //     "TypeEntryDate": currentDate,
  //     "favoriteFlag": "0",
  //   });
  //   Navigator.of(context).pop();
  // }

  getCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;

    //final uid = user.uid;
    //return user.email;
  }

  Future<http.Response> addTypeSql() async {
    //print('inside add');
    final todayDate = DateTime.now();
    currentDate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);
    var url = ("http://emaddwiekat.atwebpages.com/Sales/Flutter/AddTyped.php");

    var response = await http.post(Uri.parse(url), body: {
      "Type_id": contTypeid.text,
      "Type_name": contTypename.text,
      "Type_desc": contTypedesc.text,
      "Type_amt": contTypeAmt.text,
      "Type_to": selectedProviders,
      "Type_fav": "false",
      "Type_cat": _selectedCat,
      "Type_entry_date": _date.toString(),
      "Type_modify_date": currentDate.toString(),
      "Type_img": 'url2',
      "Type_from": _selectedpays_from,
      "Type_user": user!.email.toString(),
      "Type_currency": _selectedcurrency
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
    FirebaseFirestore.instance
        .collection(StringManager.collectionTypeCategory)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          listCat.add(element['catName']);
        });
      }
    });
  }

  // Future<void> _createOrUpdate([String? Docsid]) async {
  //   await _Typess.doc(Docsid).update({
  //     "TypeId": contTypeid.text,
  //     "TypeName": contTypename.text,
  //    // "TypeImage": url2,
  //     "TypePrice": contTypeAmt.text,
  //     "TypeCat": _selectedCat ,//contTypecat.text,
  //     "TypeEntryDate": _date,
  //     "favoriteFlag": 0, //contTypefav.text
  //   });
  //   // ignore: use_build_context_synchronously
  //   showMessage(context,'You have successfully Updated ${contTypename.text} Type');
  // }

  void change_date(DateTime newDate) {
    setState(() {
      _date = newDate;
    });
  }

  void updateDatacollection() {
    var TypeMap = {
      "TypeId": int.parse(contTypeid.text),
      "TypeName": contTypename.text,
      // "TypeImage": url2,
      "TypePrice": contTypeAmt.text,
      "TypeCat": _selectedCat, //contTypecat.text,
      "TypeEntryDate": _date,
      "favoriteFlag": 0, //contTypefav.text
    };
    updateDataFireStore(
        StringManager.collectionTypes, TypeMap, widget.instProd.docsId);

    Navigator.of(context).pop();
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
