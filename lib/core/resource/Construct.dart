// ignore_for_file: camel_case_types

import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

CollectionReference<Object?> getCollectionReference(String CollectionName) {
  final CollectionReference newCollectionReference =
      FirebaseFirestore.instance.collection(CollectionName);
  return newCollectionReference;
}
defaultTextFieldOnChange(String stringName,String nameField){
  //if(stringName.isEmpty){
    print(stringName);
   // return 'onchange $nameField empty';
  //}else if(stringName.length < 3){
   // return 'onchange $nameField is Too Short';
  //}
  return null;
}

defaultTextFieldValidator(String password,String nameField){
  if(password.isEmpty){
    return '$nameField empty';
  }else if(password.length < 3){
    return '$nameField is Too Short';
  }
  return null;
}
Widget defualtTextFormField ({
  required TextEditingController fieldController,
  // Function? onChange,
   String? Function(String?)? onChange,
  required String? Function(String?)? validate,
  required TextInputType type,
  required String hintTextLabel,
  required IconButton prefixIcon,
  required IconButton suffixIcon,
  required bool obscureText ,

}) => TextFormField(

obscureText: obscureText,
  showCursor: true,
    keyboardType: type,
    controller: fieldController,
    onChanged: onChange,
    validator:validate,
style: TextStyle(color: Colors.black),
//onSaved: (input) => imagename = input,
    decoration: InputDecoration(
      fillColor: Colors.blue,
      label: Text(hintTextLabel),
        border: InputBorder.none,
      prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding:const  EdgeInsets.only(left: 15.0, top: 15.0, right: 15),
        hintText: hintTextLabel,
        hintStyle: const TextStyle(color: Colors.black, fontFamily: 'Quicksand'),
    ),
);

Future<void> deleteProduct(
    BuildContext context, String collectionName, String productId,
    [String? imageUrl]) async {
  //print('inside delete ');
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(productId)
      .delete();

  if (imageUrl != null) {
    FirebaseStorage.instance.refFromURL(imageUrl).delete();
  }
  // Show a snackbar
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully deleted a product')));
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<int> getDocumentMaxId(String docName, String fieldName) async {
  int MaxId = 0;
  //print('inside getmax');
  await FirebaseFirestore.instance
      .collection('$docName')
      .orderBy('$fieldName', descending: true)
      .limit(1)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var element in querySnapshot.docs) {
      //setState(() {
      MaxId = ((element['$fieldName']) is String)
          ? int.parse(element['$fieldName'])
          : element['$fieldName'];
      // });
    }
  });
  return MaxId;
}

Future<void> updateDataFireStore(
    String collectionName, Map<String, dynamic> updateMap,
    [String? Docsid]) async {
  //print(Docsid);
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(Docsid)
      .update(updateMap);
}

void addDataFireStore(
    String collectionName, Map<String, dynamic> collection) async {
  print('inside add data');
  print(collection);
  print(collectionName);
  FirebaseFirestore.instance.collection(collectionName).add(collection);
}

Future<void> updateIntField(String collectionName, String fieldName,
    [String? Docsid, int? flag]) async {
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(Docsid)
      .update({fieldName: flag});
}

// ignore: camel_case_types, must_be_immutable
class getElevationButton extends StatelessWidget {
  getElevationButton(
      {required this.parFontSize,
      required this.parBorderRadius,
      required this.parBorderWidth,
      required this.nameButton,
      required this.onTabButton,
      required this.parBackGroundColor,
      required this.parForegroundColor,
      Key? key})
      : super(key: key);
  Function() onTabButton;
  String nameButton;
  Color parBackGroundColor, parForegroundColor;
  double parBorderWidth;
  double parBorderRadius;
  double parFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) / AppSize.s18,
      width: getWidth(context) / FontManagerSize.s4,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: parBorderWidth,
        ),
        borderRadius: BorderRadius.circular(parBorderRadius),
      ),
      child: ElevatedButton(
          style: ButtonStyle(
              // overlayColor:MaterialStateProperty.all(Colors.purpleAccent) ,
              foregroundColor: MaterialStateProperty.all(parForegroundColor),
              textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: parFontSize,
              )),
              backgroundColor: MaterialStateProperty.all(parBackGroundColor)),
          onPressed: onTabButton,
          child: Text(nameButton)),
    );
  }
}
