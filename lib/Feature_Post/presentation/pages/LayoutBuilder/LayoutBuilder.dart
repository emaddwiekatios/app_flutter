import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/resource/FontManager.dart';
import '../../../../core/resource/StringManager.dart';

class GetLayoutBuilder extends StatefulWidget {
  const GetLayoutBuilder({Key? key}) : super(key: key);

  @override
  State<GetLayoutBuilder> createState() => _GetLayoutBuilderState();
}

class _GetLayoutBuilderState extends State<GetLayoutBuilder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    //width: get_width(context)/2,
                    color: Colors.teal,
                  ),
                ),
                Expanded(
                  child: Container(
                      height: double.infinity,
                      //    width: get_width(context)/2,
                      //  color:Colors.transparent
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login With Your Account now',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              showCursor: true,
                              // readOnly: true,
                              // controller: controllerLoginUserName,
                              decoration: InputDecoration(
                                  label: Text(StringManager.userName.tr),
                                  hintText: StringManager.userNameHint.tr,
                                  //  prefix: Text(StringManager.userName),
                                  prefixIcon: const Icon(Icons.email),
                                  suffix: Text(StringManager.userName.tr),
                                  //  suffixText: StringManager.userName,
                                  suffixIcon: const Icon(
                                      Icons.remove_red_eye_outlined)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              showCursor: true,
                              // readOnly: true,
                              // controller: controllerLoginUserName,
                              decoration: InputDecoration(
                                  label: Text(StringManager.userName.tr),
                                  hintText: StringManager.userNameHint.tr,
                                  //  prefix: Text(StringManager.userName),
                                  prefixIcon: const Icon(Icons.email),
                                  suffix: Text(StringManager.userName.tr),
                                  //  suffixText: StringManager.userName,
                                  suffixIcon: const Icon(
                                      Icons.remove_red_eye_outlined)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.teal)),
                                onPressed: //(snapshot.data ?? false)?
                                    () {
                                  //Get.to(()=> const Home());
                                  //Get.off(()=>Home() );
                                  //    Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);
                                },
                                child: Text(
                                  'Register',
                                  style: const TextStyle(
                                      fontSize: FontManagerSize.s14),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                onPressed: //(snapshot.data ?? false)?
                                    () {
                                  //Get.to(()=> const Home());
                                  //Get.off(()=>Home() );
                                  //    Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);
                                },
                                child: Text(
                                  StringManager.login.tr,
                                  style: const TextStyle(
                                      fontSize: FontManagerSize.s22),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
