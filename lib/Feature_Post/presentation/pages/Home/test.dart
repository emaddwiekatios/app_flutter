

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/FontManager.dart';
import '../../../../core/resource/MediaQuery.dart';
import '../../../../core/resource/ValueManger.dart';

class test extends StatelessWidget {
     const test({Key? key}) : super(key: key);

     @override
     Widget build(BuildContext context) {
       return          Padding(
            padding: const EdgeInsets.only(left: AppSize.s4, right: AppSize.s4),
            child: Container(
              // color: Colors.red,
              height: getHeight(context) / FontManagerSize.s10,
              width: getWidth(context),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, int index) {
                    return SizedBox(
                      //color: Colors.red,
                      height: getHeight(context) / AppSize.s9,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: AppSize.s8, right: AppSize.s8),
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   indexParameter = index;
                                // });
                                // filterSearchResultsCat(
                                //     instCatList[index].Cat_Name);
                              },
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        side: index == 'indexParameter'
                                            ? BorderSide(
                                                color: Colors.grey,
                                                width: AppSize.s1)
                                            : BorderSide(
                                                color: Colors.transparent,
                                                width: AppSize.s0),
                                        borderRadius:
                                            BorderRadius.circular(270)),
                                    child: CircleAvatar(
                                   //   foregroundImage: ExactAssetImage(instCatList[index].Cat_image),
                                     // backgroundColor: ColorManager.primary.withOpacity(.2),
                                      radius: FontManagerSize.s30,
                                      // backgroundImage: ExactAssetImage(AssetManager),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 5,
                                    child: index == 1? Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(250)),
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text('instCatList[index].Cat_Name')
                          //  backgroundImage:  (AssetManager.onBoarding3,fit: BoxFit.cover))
                        ],
                      ),
                    );

                    //Center(child: widgetCategory( instCat: instCatList[index]));
                  }),
            ));
     }
   }


