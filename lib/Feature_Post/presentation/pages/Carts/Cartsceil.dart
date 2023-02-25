

import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/ColorManger.dart';
import '../../../../core/resource/FontManager.dart';
import '../../../../core/resource/ValueManger.dart';
import '../Products/ProductsClass.dart';

class CartsCeil extends StatefulWidget {
   CartsCeil({Key? key,required this.instCarts}) : super(key: key);
  ProductClass instCarts;
  @override
  State<CartsCeil> createState() => _CartsCeilState();
}

class _CartsCeilState extends State<CartsCeil> {
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: ()
        {
          print(widget.instCarts.productName);
        },
        child: Container(
        margin:const  EdgeInsets.all(AppSize.s6),
        height: getHeight(context)/AppSize.s8,
        width: getWidth(context)/FontManagerSize.s3,
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: ColorManager.primary,
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child:
        Card(
          elevation: 2,
          child:
          Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: AppSize.s40,
                      backgroundImage: AssetImage(widget.instCarts.productImage),
                      //  child: Image.asset(widget.instCarts.productImage,fit:BoxFit.cover),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.instCarts.productName),
                        Text(widget.instCarts.productCat),
                        Text('${widget.instCarts.productEntryDate.year}'),


                      ],
                    ),



                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.instCarts.productName),
                        Text(widget.instCarts.productCat),
                        Text('${widget.instCarts.productEntryDate.year}'),


                      ],
                    ),



                  ],
                ),
                Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [


                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(widget.instCarts.productName),
                            Text(widget.instCarts.productCat),
                            Text('${widget.instCarts.productEntryDate.year}'),


                          ],
                        ),



                      ],
                    ),
              ],
            ),
          ),
        ),
    ),
      );
  }
}

