//import 'dart:html';

import 'package:clean_arch_app/Feature_Post/presentation/pages/Category/CategoryClass.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:async';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
import '../../../../core/resource/ValueManger.dart';

class CategoryEdit extends StatefulWidget {
  CategoryClass Intcategory;
  CategoryEdit({required this.Intcategory});
  @override
  _CategoryEditState createState() => _CategoryEditState();
}

QuerySnapshot? cars;
QuerySnapshot? carsToken;
QuerySnapshot? carsProviders;

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
    FirebaseFirestore.instance.collection('Categorys');

class _CategoryEditState extends State<CategoryEdit> {
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
    contcatid.text=widget.Intcategory.catId.toString() ;
    contcatAmt.text=widget.Intcategory.catPrice ;
    contcatdate.text=widget.Intcategory.catDate.toString() ;
    contcatname.text=widget.Intcategory.catName ;

    getCategory();
    getCurrentUser();
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

  TextEditingController contcatid = new TextEditingController();
  TextEditingController contcatname = new TextEditingController();
  TextEditingController contcatAmt = new TextEditingController();
  TextEditingController contcatfav = new TextEditingController();
  TextEditingController contcatcat = new TextEditingController();
  TextEditingController contcatdesc = new TextEditingController();
  TextEditingController contcaturl = new TextEditingController();
  TextEditingController contcatdentrydate = new TextEditingController();
  TextEditingController contcatTo = new TextEditingController();
  TextEditingController contcatdate = new TextEditingController();
  File? imageFile;

  @override
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
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                   
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 15,
                left: MediaQuery.of(context).size.width / 2 -
                    ('Edit Category'.toString().length * 8),
                child: const Text(
                  'Edit Category',
                  //AppLocalizations.of(context).translate('Add cat'),

                  //'Add cat',
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: defaultTextFormField(
                                obscureText: false,
                                fieldController: contcatid,
                                onChange: (value) =>defaultTextFieldOnChange(value!,'Category ID'),

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
                                        contcatid.clear();

                                      });
                                    }),
                                validate:(value)=>defaultTextFieldValidator(value!,'Category Id'),

                                hintTextLabel: 'Category Id'),
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
                                        child: Text('Category_Date'
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
                                fieldController: contcatname,
                                onChange: (value) =>defaultTextFieldOnChange(value!,'Category Name'),

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
                                        contcatname.clear();

                                      });
                                    }),
                                validate:(value)=>defaultTextFieldValidator(value!,'Category Name'),

                                hintTextLabel: 'Category Name'),
                          ),

                          isSave ? CircularProgressIndicator() : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: defaultTextFormField(
                                obscureText: false,
                                fieldController: contcatAmt,
                                onChange: (value) =>defaultTextFieldOnChange(value!,'Category Amt'),

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
                                        contcatAmt.clear();

                                      });
                                    }),
                                validate:(value)=>defaultTextFieldValidator(value!,'Category Amt'),

                                hintTextLabel: 'Category Amt'),
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
                                                widget.Intcategory.catImage))),



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
                                defaltElevationButton(nameButton:'Save',
                                  onTabButton: () {
                                    var categoryMap= {
                                      "catId": contcatid.text,
                                      "catName": contcatname.text,
                                      //"catimage": url2,
                                      "catPrice": contcatAmt.text,
                                      "catDesc":contcatname.text  ,//contcatcat.text,
                                      "catDate": _date,
                                      "Type": "0" //contcatfav.text
                                    };

                                    updateDataFireStore(StringManager.collectionCategory,categoryMap ,widget.Intcategory.docsId);

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

  Future<void> uploadimage() async {
    final Reference ref = FirebaseStorage.instance
        .ref('/File/Category')
        .child('${contcatname.text}.jpg');
    final UploadTask task = ref.putFile(File(image!.path));
    task.then((res) {
      res.ref.getDownloadURL().then((value) {
        url2 = value;
       //print(value);
        addisubcollection();
      });

      //url=downurl as String;
    });
  }



  void addisubcollection() async {

    final todayDate = DateTime.now();
    currentdate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);

    FirebaseFirestore.instance.collection("Categorys").add({
      "catId": contcatid.text,
      "catName": contcatname.text,
      "catimage": url2,
      "catPrice": contcatAmt.text,
      "catDesc":contcatname.text  ,//contcatcat.text,
      "catDate": DateTime.now(),
      "Type": "0", //contcatfav.text
    });

    int  maxcatId = await getDocumentMaxId('Categorys', 'catId');
   //print(maxcatId);
    setState(() {
      contcatid.text=(maxcatId+1).toString();
      contcatname.clear();
      contcatAmt.clear();


    });

    Navigator.of(context).pop();
  }


  getCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;

    //final uid = user.uid;
    //return user.email;
  }

  addimagedata() {
    final todayDate = DateTime.now();
    currentdate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);

    getCurrentUser();
    FirebaseFirestore.instance.collection("Clean_App_cats_New").doc().set({
      'cat_id': contcatid.text,
      'cat_name': contcatname.text,
      // 'cat_desc': contcatdesc.text,
      'cat_amt': contcatAmt.text,
      // 'cat_to': _selectedProviders ,//contcatTo.text,
      'catfav': "false",
      'catcat': _selectedCat,
      'catentry_date': _date, // currentdate,
      'catmodify_date': todayDate, // currentdate,
      'catimg': url2,
      'catfrom': _selectedpays_from,
      'catuser': user?.email.toString(),
      'catcurrency': _selectedcurrency
    });

    FirebaseFirestore.instance.collection("catsHistory").doc().set({
      'cat_id': contcatid.text,
      'cat_name': contcatname.text,
      'cat_desc': contcatdesc.text,
      'cat_amt': contcatAmt.text,
      'cat_to': contcatTo.text,
      'cat_fav': "false",
      'cat_cat': _selectedCat,
      'cat_entry_date': todayDate, //currentdate,
      'cat_modify_date': todayDate, //currentdate,
      'cat_img': url2,
      'cat_from': _selectedpays_from,
      'cat_user': user?.email.toString(),
      'cat_currency': _selectedcurrency
    });

    _showSnackbar(contcatname.text);
    setState(() {
      contcatid.text = (int.parse(contcatid.text) + 1).toString();
      contcatname.clear();
      contcatdesc.clear();
      contcatAmt.clear();
      contcatTo.clear();
    });
  }

  Future<http.Response> addcattosql() async {
   ////print('inside add');
    final todayDate = DateTime.now();
    currentdate = formatDate(todayDate,
        [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);
    var url =
        ("http://emaddwiekat.atwebpages.com/Sales/Flutter/Addcatd.php");

    var response = await http.post(Uri.parse(url), body: {
      "cat_id": contcatid.text,
      "cat_name": contcatname.text,
      "cat_desc": contcatdesc.text,
      "cat_amt": contcatAmt.text,
      "cat_to": _selectedProviders,
      "cat_fav": "false",
      "cat_cat": _selectedCat,
      "cat_entry_date": _date.toString(), // currentdate,
      "cat_modify_date": currentdate.toString(), // currentdate,
      "cat_img": 'url2',
      "cat_from": _selectedpays_from,
      "cat_user": user!.email.toString(),
      "cat_currency": _selectedcurrency
    });
    
    return response;
  }





  printlistproviders() {
    // if (cars != null) {
    //   list_Providers.clear();
    //   for (var i = 0; i < carsproviders.docs.length; i++) {
    //     list_Providers.add(carsproviders.docs[i].data()['Provider_name']);
    //   }
    // } else {
    //  //print("error");
    // }
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
    //     //list_cat.add(cars.docs[i].data()['catname']);
    //   }
    // } else {
    //  //print("error");
    // }
  }

  printlist() {

    if (cars != null) {
      list_cat.clear();
      for (var element in cars!.docs) {
        setState(() {
          setState(() {
            list_cat.add(element['catName']);
          });

        });
      }

      // querySnapshot.docs.forEach((element) {
      //   setState(() {
      //     list_cat.add(element['catName']);
      //   });
    } else {
     //print("error");
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
      for (var element in querySnapshot.docs) {
        setState(() {
          list_cat.add(
              element['catName']);
        });
      }
    });

  }




//  void _onPressed() {
//   //print('inside onpreesses');
//    FirebaseFirestore.instance.collection("users").get().then((querySnapshot) {
//      querySnapshot.docs.forEach((result) {
//       //print(result.data);
////        FirebaseFirestore.instance
////            .collection("users")
////            .doc(result.id)
////            .collection("tokens")
////            .get()
////            .then((querySnapshot) {
////          querySnapshot.docs.forEach((result) {
////           //print(result.data);
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
//           //print(element.data()['token']);
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
//     //print(value.docs[0].data()['token']);
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
