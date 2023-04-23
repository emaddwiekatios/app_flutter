

import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/ColorManger.dart';
import '../../../../core/resource/Construct.dart';
import '../../../../core/resource/FontManager.dart';
import '../../../../core/resource/ValueManger.dart';
import '../Products/ProductsClass.dart';
import 'package:date_format/date_format.dart';


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
            ///print(widget.instCarts.productName);
          },
          child: Container(
          margin:const  EdgeInsets.all(AppSize.s6),
          height: getHeight(context)/FontManagerSize.s7,
          width: getWidth(context)/FontManagerSize.s3,
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: ColorManager.primary,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child:
          Stack(
            children: [
          Card(
            color: Colors.grey[100],
            margin: EdgeInsets.all(FontManagerSize.s5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s10)),
                elevation: .5,
                child:
                Padding(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: AppSize.s65,
                            backgroundImage: NetworkImage(widget.instCarts.productImage),
                            //  child: Image.asset(widget.instCarts.productImage,fit:BoxFit.cover),
                          ),
                          SizedBox(
                            width: getWidth(context)/AppSize.s12,

                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.instCarts.productName),
                              Text("Price  ${widget.instCarts.productPrice}\$"),
                              Text('${formatDate(widget.instCarts.productEntryDate, [yyyy, '-', mm, '-', dd])}'),


                            ],
                          ),


                          Row(
                            children: [
                             IconButton(onPressed: (){
                               updateIntField(StringManager.collection_Carts,'productCount',widget.instCarts.docsId,widget.instCarts.productCount-1);

                             },
                                 icon:  Icon(Icons.remove_circle,color:Colors.grey[300], )),
                              Text('${widget.instCarts.productCount}'),
                               IconButton(onPressed: (){
                                 var tempProductCount =widget.instCarts.productCount+1;
                                 //print(tempProductCount);
                                 updateIntField(StringManager.collection_Carts,'productCount',widget.instCarts.docsId,widget.instCarts.productCount+1);

                               }, icon:  Icon(Icons.add_circle,color: ColorManager.primary, )),
                            ],
                          )


                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Positioned(
                top:2,
                right: 2,
                child:
              IconButton(onPressed: (){
                deleteProduct(
                   context,
                   StringManager.collection_Carts,
                  widget.instCarts.docsId,null
                   );

              }, icon:const Icon(Icons.cancel_outlined )),)
            ],
          ),
    ),




      );


  }
}

