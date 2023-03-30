// ignore_for_file: camel_case_types

import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




Future<int> getDocumentMaxId(Doc_name,Field) async {
  int MaxId=0;
  print('inside getmax');
 await  FirebaseFirestore.instance.collection('$Doc_name').orderBy('$Field', descending: true).limit(1).
  get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((element)  {
      //setState(() {
        MaxId=   int.parse(element['$Field']);
        print(int.parse(element['$Field']));
    // });
    });
  });
  return  MaxId;


}

// ignore: camel_case_types, must_be_immutable
class getElevationButton extends StatelessWidget {
   getElevationButton({
     required this.parFontSize,
     required this.parBorderRadius,
     required  this.parBorderWidth,
     required  this.nameButton,
     required this.onTabButton,
     required  this.parBackGroundColor,
     required  this.parForegroundColor,
     Key? key}) : super(key: key);
   Function() onTabButton;
   String nameButton;
   Color parBackGroundColor,
       parForegroundColor;
   double parBorderWidth;
   double parBorderRadius;
   double parFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context)/AppSize.s20,
        width: getWidth(context)/FontManagerSize.s3,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primary,
            width: parBorderWidth,
          ),
          borderRadius: BorderRadius.circular(parBorderRadius),
        ),

    child: ElevatedButton(

          style: ButtonStyle(
            // overlayColor:MaterialStateProperty.all(Colors.purpleAccent) ,
            foregroundColor: MaterialStateProperty.all(parForegroundColor),
            textStyle: MaterialStateProperty.all(
                TextStyle(
                    fontSize: parFontSize,
                )),
            backgroundColor: MaterialStateProperty.all(parBackGroundColor )

                   ),
          onPressed: onTabButton,
        child: Text(nameButton)),
    );
  }
}
