import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/resource/Construct.dart';
import '../../../../core/resource/FontManager.dart';
import '../../../../core/resource/StringManager.dart';

class GetLayoutBuilder extends StatefulWidget {
  const GetLayoutBuilder({Key? key}) : super(key: key);

  @override
  State<GetLayoutBuilder> createState() => _GetLayoutBuilderState();
}

var emailCont = TextEditingController();
var passCont = TextEditingController();
var formKey = GlobalKey<FormState>();
bool isObscureText =true;
class _GetLayoutBuilderState extends State<GetLayoutBuilder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.teal,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        //width: get_width(context)/2,
                        color: Colors.teal,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                          height: double.infinity,
                          //    width: get_width(context)/2,
                          //  color:Colors.transparent
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login With Your Account now',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defualtTextFormField(
                                      obscureText: false,
                                      fieldController: emailCont,
                                      onChange: (value) =>defaultTextFieldOnChange(value!,'Username'),
                                      type: TextInputType.emailAddress,
                                      prefixIcon: IconButton(
                                          icon: const Icon(Icons.person,
                                              color: Colors.red,
                                              // Color(getColorHexFromStr('#FEE16D')),
                                              size: 20.0),
                                          onPressed: () {}),
                                      suffixIcon: IconButton(
                                          icon: const Icon(Icons.cancel,
                                              color: Colors.red,
                                              // Color(getColorHexFromStr('#FEE16D')),
                                              size: 20.0),
                                          onPressed: () {
                                            emailCont.clear();

                                          }),
                                      validate:(value)=>defaultTextFieldValidator(value!,'Username'),
                                      //     (value) {
                                      //   if (value.isEmpty) {
                                      //     return 'enter email';
                                      //   } else {
                                      //     return 'null';
                                      //   }
                                      // },
                                      hintTextLabel: 'Email'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defualtTextFormField(
                                      obscureText: isObscureText,
                                      fieldController: passCont,
                                      onChange: (value) =>defaultTextFieldOnChange(value!,'Password'),

                                      type: TextInputType.emailAddress,
                                      prefixIcon: IconButton(
                                          icon: const Icon(Icons.password,
                                              color: Colors.black,
                                              // Color(getColorHexFromStr('#FEE16D')),
                                              size: 20.0),
                                          onPressed: () {}),
                                      suffixIcon: IconButton(
                                          icon: const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.red,
                                              // Color(getColorHexFromStr('#FEE16D')),
                                              size: 20.0),
                                          onPressed: () {
                                           setState(() {
                                             isObscureText=!isObscureText;

                                           });
                                          }),
                                      validate:(value)=>defaultTextFieldValidator(value!,'Password'),

                                        //   (String value) {
                                        // if (value.isEmpty) {
                                        //   return 'enter email';
                                        // } else {
                                        //   return null;
                                        // }
                                     // },
                                      hintTextLabel: 'Password'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.teal)),
                                      onPressed: //(snapshot.data ?? false)?
                                          () {
                                        if (formKey.currentState != null &&
                                            formKey.currentState!.validate()) {
                                          print('ok ');
                                        }

                                        //Get.to(()=> const Home());
                                        //Get.off(()=>Home() );
                                        //    Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);
                                      },
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: FontManagerSize.s14),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: //(snapshot.data ?? false)?
                                          () {
                                            if (formKey.currentState != null &&
                                                formKey.currentState!.validate()) {
                                              print('ok ');
                                            }
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
                            ),
                          )),
                    ),
                  ],
                ),
              );
            }




    )),
    );
  }







}
