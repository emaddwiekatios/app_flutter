// ignore_for_file: camel_case_types

import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

CollectionReference<Object?> getCollectionReference(String CollectionName) {
  final CollectionReference newCollectionReference =
      FirebaseFirestore.instance.collection(CollectionName);
  return newCollectionReference;
}

defaultTextFieldOnChange(String stringName, String nameField) {
  //if(stringName.isEmpty){
  print(stringName);
  // return 'onchange $nameField empty';
  //}else if(stringName.length < 3){
  // return 'onchange $nameField is Too Short';
  //}
  return null;
}

defaultTextFieldValidator(String password, String nameField) {
  if (password.isEmpty) {
    return '$nameField empty';
  } else if (password.length < 3) {
    return '$nameField is Too Short';
  }
  return null;
}

Widget defaultTextFormField({
  required TextEditingController fieldController,
  // Function? onChange,
  Color borderColor = Colors.blueGrey,
  String? Function(String?)? onChange,
  required String? Function(String?)? validate,
  TextInputType type = TextInputType.emailAddress,
  required String hintTextLabel,
  required IconButton prefixIcon,
  required IconButton suffixIcon,
  bool obscureText = true,
}) =>
    TextFormField(
      obscureText: obscureText,
      showCursor: true,
      keyboardType: type,
      controller: fieldController,
      onChanged: onChange,
      validator: validate,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.blue,
        label: Text(hintTextLabel),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15),
        hintText: hintTextLabel,
        hintStyle:
            const TextStyle(color: Colors.black, fontFamily: 'Quicksand'),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.greenAccent,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
        ),
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
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully deleted a product')));
}

void showMessage(BuildContext context, String message, Color backGroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: backGroundColor,
  ));
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

Future<int> getIsProductInCarts(String collectionName, int productId) async {
  int productIdExist = 0;
  await FirebaseFirestore.instance
      .collection(collectionName)
      .where("productId", isEqualTo: productId)
      .get()
      .then((QuerySnapshot querySnapshot) {
    //    print(querySnapshot.docs);
    for (var element in querySnapshot.docs) {
      print('element[productId]=${element['productId']}');

      productIdExist = (element['productId']);
      // });
    }
  });
  return productIdExist;
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
  FirebaseFirestore.instance.collection(collectionName).add(collection);
}

Future<void> updateIntField(String collectionName, String fieldName,
    [String? Docsid, int? flag]) async {
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(Docsid)
      .update({fieldName: flag});
}

class defaltElevationButton extends StatelessWidget {
  defaltElevationButton(
      {this.heightButton,
      this.widthButton,
      required this.parFontSize,
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
  double? heightButton;
  double? widthButton;
  @override
  Widget build(BuildContext context) {
    heightButton ?? (heightButton = getHeight(context) / FontManagerSize.s30);
    widthButton ?? (widthButton = getWidth(context) / FontManagerSize.s3);
    return Container(
      height: heightButton,
      width: widthButton,
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

Widget getButtonGeneral(
    String labelName, double heightBox, double widthBox, Color colorBg) {
  return Container(
    height: heightBox,
    width: widthBox,
    color: colorBg,
  );
}

SnackBar defaultSnackBar(String message, {required String actionMessage}) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 14.0),
    ),
    action: (actionMessage != null)
        ? SnackBarAction(
            textColor: Colors.white,
            label: actionMessage,
            onPressed: () {
              //   return onClick();
            },
          )
        : null,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.indigo,
  );
}

// defualtAppBarWidget(titleName: 'emad',
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// IconButton(icon:Icon(Icons.add),
// onPressed: () {print('add');
// },),
// IconButton(icon:Icon(Icons.add_business),
// onPressed: () { print('add b ');  },),
//
// ],),),

class defualtAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  String titleName;
  Widget child;
  defualtAppBarWidget({required this.titleName, required this.child});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleName),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: ColorManager.primary,
      actions: [child],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
