import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/Construct.dart';
import 'package:flutter/material.dart';
//import 'file:///Users/serviceapp/Desktop/Apps_from_flash/flutter_app_money4/lib/colors.dart' as prefix0;

//import 'package:keyboard_actions/keyboard_actions.dart';

//import './Restore.dart';
//import 'package:paychalet/colors.dart';
//import 'package:paychalet/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:paychalet/TextFieldCustom/CustomTextField.dart';
//import '../../../paychalet new2/lib/Home.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resource/AssetManager.dart';
import '../../../../../core/resource/MediaQuery.dart';
//import 'package:paychalet/AppLocalizations.dart';
//import 'GetCurrentUserFB.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

int _state = 0;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
User? user;
final GlobalKey<FormState> _formKeyin = GlobalKey<FormState>();
bool _loading = false;
bool _autoValidate = false;
String? errorMsg;

String? _email;
String? _pass1;

class _SignInState extends State<SignIn> {
  TextEditingController _cont_user = TextEditingController();
  TextEditingController _cont_pass1 = TextEditingController();
  TextEditingController _cont_pass2 = TextEditingController();
//  Color p_color = pcolor;

  FocusNode _nodeuser = FocusNode();
  FocusNode _nodepass1 = FocusNode();
  FocusNode _nodepass2 = FocusNode();
  bool? pshow2, pshow1;



  void initState() {
    // TODO: implement initState
    super.initState();




    pshow2 = true;
    pshow1 = true;
    _state = 0;
    _cont_pass1.clear();

    _cont_user.clear();
  }
  @override
  Widget build(BuildContext context) {
    final double pheight=MediaQuery.of(context).size.height;
    final double pwidth=MediaQuery.of(context).size.width;
   // var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      // ),
      body:
//        FormKeyboardActions(
//          keyboardActionsPlatform: KeyboardActionsPlatform.ALL, //optional
//          keyboardBarColor: Colors.grey[200], //optional
//          nextFocus: true, //optional
//          actions: [
//            KeyboardAction(
//              focusNode: _nodeuser,
//              displayCloseWidget: true,
//            ),
//            KeyboardAction(
//              displayCloseWidget: true,
//              focusNode: _nodepass1,
//              closeWidget: Padding(
//                padding: EdgeInsets.all(8.0),
//                child: Icon(Icons.close),
//              ),
//            ),
//            KeyboardAction(
//              displayCloseWidget: true,
//              focusNode: _nodepass2,
//              closeWidget: Padding(
//                padding: EdgeInsets.all(5.0),
//                child: Text("CLOSE"),
//              ),
//            ),
//          ],
//          child:
      SingleChildScrollView(
        child:   Stack(
          children: [
             SizedBox(height: getHeight(context),
              width: getWidth(context),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: getWidth(context),
                height: getHeight(context) / 2,
                decoration: const BoxDecoration(
                    color: Colors.red,

                    image: DecorationImage(
                       fit: BoxFit.fill,
                       image: AssetImage(
                         AssetManager.login,
                       ),
                    ),
                ),
              ),
            ),
            Positioned(
              top: (getHeight(context)/2)-30,
              left: 0,
              right: 0,
              child: Container(
               // margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:



                    Form(
                      key: _formKeyin,
                      //  autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: pheight/ 30,
                          ),
                          Align(
                              alignment:   Alignment.topLeft,
                              child: Text(
                                'Login In',
                                style: TextStyle(
                                  fontSize: pheight/25,
                                  fontWeight: FontWeight.bold,
                                  // color: ColorManager.secondary
                                ),
                              )),

                          SizedBox(
                            height: pheight/ 30,
                          ),
                          defaultTextFormField(
                              obscureText: false,
                              fieldController: _cont_user,
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
                                      _cont_user.clear();

                                    });
                                  }),
                              validate:(value)=>defaultTextFieldValidator(value!,'User Name'),

                              hintTextLabel: 'User Name'),

                          SizedBox(
                            height: pheight / 45,
                          ),
                          defaultTextFormField(
                              obscureText: false,
                              fieldController: _cont_pass1,
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
                                      _cont_pass1.clear();

                                    });
                                  }),
                              validate:(value)=>defaultTextFieldValidator(value!,'Password'),

                              hintTextLabel: 'Password'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 45,
                          ),





                          Container(
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorManager.secondary, //Colors.orange[800].withOpacity(0.7),
                            ),
                            // child :setUpButtonChild(),

                            child: defaltElevationButton(
                              nameButton: 'Sign In',
                              onTabButton: () async {

                                logInToFb();
                              },
                              parBackGroundColor: ColorManager.primary,
                              parBorderRadius: 5,
                              parBorderWidth: 1,
                              parFontSize: 15,
                              parForegroundColor: ColorManager.white,
                            ),
                          ),




                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 70.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 50,
                                  )),
                            ),

                            Text('OR SIGN IN WITH',style: TextStyle(fontSize: pheight/45),),

                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 70.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: pheight/50,
                                  )),
                            ),
                          ]),

                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: <Widget>[
                          //     Container(
                          //       width: MediaQuery.of(context).size.width / 4,
                          //       height: MediaQuery.of(context).size.height / 12,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: Colors.black12, width: 1),
                          //           shape: BoxShape.circle,
                          //           color: Colors.white,
                          //           //   borderRadius: BorderRadius.circular(50),
                          //           image: DecorationImage(
                          //               image: AssetImage('images/face4.png'),
                          //               // AssetImage(photos[photoIndex]),
                          //               fit: BoxFit.contain)),
                          //     ),
                          //     Container(
                          //       width: MediaQuery.of(context).size.width / 4,
                          //       height: MediaQuery.of(context).size.height / 12,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: Colors.black12, width: 1),
                          //           shape: BoxShape.circle,
                          //           color: Colors.white,
                          //           //   borderRadius: BorderRadius.circular(50),
                          //           image: DecorationImage(
                          //               image: AssetImage('images/google3.png'),
                          //               // AssetImage(photos[photoIndex]),
                          //               fit: BoxFit.contain)),
                          //     ),
                          //     Container(
                          //       width: MediaQuery.of(context).size.width / 4,
                          //       height: MediaQuery.of(context).size.height / 12,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: Colors.black12, width: 1),
                          //           shape: BoxShape.circle,
                          //           color: Colors.white,
                          //           //   borderRadius: BorderRadius.circular(50),
                          //           image: DecorationImage(
                          //               image: AssetImage('images/instagram.jpg'),
                          //               // AssetImage(photos[photoIndex]),
                          //               fit: BoxFit.contain)),
                          //     ),
                          //   ],
                          // ),ch
                        ],
                      ),
                    ),



                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 10,
                    // ),




                ),
              ),
            ),
            // Positioned(
            //   top: (getHeight(context)/2)-10,
            //   left: 0,
            //   right: 0,
            //   child: GetBuilder<Auth>(
            //     init: Auth(),
            //     builder: ((controller) {
            //       return Form(
            //         key: formkey,
            //         child: Card(
            //           // elevation: 30,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(AppSize.s20)),
            //           // margin: const EdgeInsets.all(AppSize.s10),
            //           child: Padding(
            //             padding: const EdgeInsets.all(AppSize.s28),
            //             child: Column(
            //               children: [
            //                 Text(
            //                   StringManager.login.tr,
            //                   style: getBoldStyle(color: ColorManager.primary),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: StreamBuilder<bool>(
            //                       stream: loginViewModel1
            //                           .getLoginViewModelOutUserName,
            //                       builder: (context, snapshot) {
            //                         return TextFormField(
            //                           showCursor: true,
            //                           // readOnly: true,
            //                           controller: controllerLoginUserName,
            //                           decoration: InputDecoration(
            //                               label:
            //                               Text(StringManager.userName.tr),
            //                               hintText:
            //                               StringManager.userNameHint.tr,
            //                               //  prefix: Text(StringManager.userName),
            //                               prefixIcon: const Icon(Icons.email),
            //                               errorText: (snapshot.data ?? true)
            //                                   ? null
            //                                   : StringManager.usernameError,
            //                               suffix:
            //                               Text(StringManager.userName.tr),
            //                               //  suffixText: StringManager.userName,
            //                               suffixIcon: const Icon(
            //                                   Icons.remove_red_eye_outlined)),
            //                           validator: (value) {
            //                             if (value!.isEmpty ||
            //                                 !value.contains('@')) {
            //                               return 'Invalid Username';
            //                             }
            //                             return null;
            //                           },
            //                         );
            //                       }),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: StreamBuilder<bool>(
            //                       stream: loginViewModel1
            //                           .getLoginViewModelOutPassword,
            //                       builder: (context, snapshot) {
            //                         return TextFormField(
            //                           keyboardType: TextInputType.text,
            //                           obscureText: true,
            //                           showCursor: true,
            //                           // readOnly: true,
            //                           controller: controllerLoginPassword,
            //                           decoration: InputDecoration(
            //                               label:
            //                               Text(StringManager.password.tr),
            //                               hintText: StringManager.password.tr,
            //                               //  prefix: Text(StringManager.userName),
            //                               prefixIcon:
            //                               const Icon(Icons.password),
            //                               errorText: (snapshot.data ?? true)
            //                                   ? null
            //                                   : StringManager.passwordError.tr,
            //                               suffix:
            //                               Text(StringManager.password.tr),
            //                               //  suffixText: StringManager.userName,
            //                               suffixIcon: const Icon(
            //                                   Icons.remove_red_eye_outlined)),
            //                         );
            //                       }),
            //                 ),
            //                 controller.isSignup
            //                     ? Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: StreamBuilder<bool>(
            //                       stream: loginViewModel1
            //                           .getLoginViewModelOutPassword,
            //                       builder: (context, snapshot) {
            //                         return TextFormField(
            //                           keyboardType: TextInputType.text,
            //                           obscureText: true,
            //                           showCursor: true,
            //                           // readOnly: true,
            //                           controller:
            //                           controllerLoginPasswordconfirm,
            //                           decoration: InputDecoration(
            //                               label: Text(StringManager
            //                                   .confirmPassword.tr),
            //                               hintText: StringManager
            //                                   .confirmPassword.tr,
            //                               //  prefix: Text(StringManager.userName),
            //                               prefixIcon:
            //                               const Icon(Icons.password),
            //                               errorText:
            //                               (snapshot.data ?? true)
            //                                   ? null
            //                                   : StringManager
            //                                   .passwordError.tr,
            //                               suffix: Text(StringManager
            //                                   .confirmPassword.tr),
            //                               //  suffixText: StringManager.userName,
            //                               suffixIcon: const Icon(Icons
            //                                   .remove_red_eye_outlined)),
            //                         );
            //                       }),
            //                 )
            //                     : Container(),
            //                 // Text('${controller.errorMessage}'),
            //                 controller.isSignup
            //                     ? Container(
            //                   height: getHeight(context) / 20,
            //                   width: getWidth(context),
            //                   margin: const EdgeInsets.all(
            //                       FontManagerSize.s8),
            //                   child: StreamBuilder<bool>(
            //                     stream: loginViewModel1
            //                         .getLoginViewModelOutLoginButton,
            //                     builder: (context, snapshot) {
            //                       return ElevatedButton(
            //                         style: ButtonStyle(
            //                             elevation:
            //                             MaterialStateProperty.all(0),
            //                             backgroundColor:
            //                             MaterialStateProperty.all(
            //                                 (snapshot.data ?? false)
            //                                     ? ColorManager.primary
            //                                     : ColorManager.grey)),
            //                         onPressed: (snapshot.data ?? false)
            //                             ? () async {
            //                           print('insiude button');
            //                           String user =
            //                           controllerLoginUserName
            //                               .text
            //                               .toString();
            //                           String password =
            //                           controllerLoginPassword
            //                               .text
            //                               .toString();
            //
            //                           await controller.signup(
            //                               user, password);
            //
            //                           if (controller.errorMessage!
            //                               .length >
            //                               3) {
            //                             //print('inside error button');
            //                             Get.defaultDialog(
            //                               title: 'The User Error',
            //                               content: Text(
            //                                   '${controller.errorMessage}'),
            //                               // backgroundColor: ColorManager.grey,
            //                               cancel: Row(
            //                                 mainAxisAlignment:
            //                                 MainAxisAlignment
            //                                     .center,
            //                                 children: [
            //                                   ElevatedButton.icon(
            //                                     label: const Text(
            //                                         'Ok'),
            //                                     onPressed: () {
            //                                       Navigator.pop(
            //                                           context);
            //                                     },
            //                                     icon: const Icon(
            //                                         Icons.done),
            //                                   ),
            //                                   ElevatedButton.icon(
            //                                       label: const Text(
            //                                           'Canceled'),
            //                                       onPressed: () {
            //                                         Navigator.pop(
            //                                             context);
            //                                       },
            //                                       icon: const Icon(
            //                                           Icons.abc)),
            //                                 ],
            //                               ),
            //                             );
            //                           } else if (controller
            //                               .userId!.isNotEmpty &&
            //                               !controller.isSignup) {
            //                             ////print('inside go to home ');
            //                             ////print(controller.userId);
            //                             ////print(    !controller.isSignup);
            //
            //                             Get.to(() => const Home());
            //                           }
            //
            //                           ////print(' after if 3');
            //                         }
            //                             : null,
            //                         child: Text(
            //                           controller.isSignup
            //                               ? StringManager.signup
            //                               : StringManager.login.tr,
            //                           style: const TextStyle(
            //                               fontSize: FontManagerSize.s22),
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 )
            //                     : Container(
            //                   height: getHeight(context) / 20,
            //                   width: getWidth(context),
            //                   margin: const EdgeInsets.all(
            //                       FontManagerSize.s8),
            //                   child: StreamBuilder<bool>(
            //                     stream: loginViewModel1
            //                         .getLoginViewModelOutLoginButton,
            //                     builder: (context, snapshot) {
            //                       return ElevatedButton(
            //                         style: ButtonStyle(
            //                             elevation:
            //                             MaterialStateProperty.all(0),
            //                             backgroundColor:
            //                             MaterialStateProperty.all(
            //                                 (snapshot.data ?? false)
            //                                     ? ColorManager.primary
            //                                     : ColorManager.grey)),
            //                         onPressed: (snapshot.data ?? false)
            //                             ? () async {
            //                           // //print('insiude button sign in');
            //                           String user =
            //                           controllerLoginUserName
            //                               .text
            //                               .toString();
            //                           String password =
            //                           controllerLoginPassword
            //                               .text
            //                               .toString();
            //                           ////print(user);
            //                           ////print(password);
            //                           await controller.signin(
            //                               user, password);
            //
            //                           if (controller.errorMessage!
            //                               .length >
            //                               3) {
            //                             //print('inside error button');
            //                             Get.defaultDialog(
            //                               title: 'The User Error',
            //                               content: Text(
            //                                   '${controller.errorMessage}'),
            //                               // backgroundColor: ColorManager.grey,
            //                               cancel: Row(
            //                                 mainAxisAlignment:
            //                                 MainAxisAlignment
            //                                     .center,
            //                                 children: [
            //                                   ElevatedButton.icon(
            //                                     label: const Text(
            //                                         'Ok'),
            //                                     onPressed: () {
            //                                       Navigator.pop(
            //                                           context);
            //                                     },
            //                                     icon: const Icon(
            //                                         Icons.done),
            //                                   ),
            //                                   ElevatedButton.icon(
            //                                       label: const Text(
            //                                           'Canceled'),
            //                                       onPressed: () {
            //                                         Navigator.pop(
            //                                             context);
            //                                       },
            //                                       icon: const Icon(
            //                                           Icons.abc)),
            //                                 ],
            //                               ),
            //                             );
            //                           } else if (controller
            //                               .userId!.isNotEmpty &&
            //                               controller.isSignup) {
            //                             Get.defaultDialog(
            //                               title: 'Create User',
            //                               content: Text(
            //                                   'The user Created : ${controller.email}'),
            //                               confirm:
            //                               ElevatedButton.icon(
            //                                   label: const Text(
            //                                       'you can Login '),
            //                                   onPressed: () {
            //                                     // controller.changeisSignup(!controller.isSignup);
            //                                     // controllerLoginPassword.clear();
            //                                     // controllerLoginPasswordconfirm.clear();
            //                                     Navigator.pop(
            //                                         context);
            //                                   },
            //                                   icon: const Icon(Icons
            //                                       .personal_injury)),
            //                             );
            //                           } else if (controller
            //                               .userId!.isNotEmpty &&
            //                               !controller.isSignup) {
            //                             ////print('inside go to home ');
            //                             ////print(controller.userId);
            //                             ////print(    !controller.isSignup);
            //
            //                             //Get.to(() => const Home());
            //                           }
            //
            //                           // //print(' after if 3');
            //                         }
            //                             : null,
            //                         child: Text(
            //                           controller.isSignup
            //                               ? StringManager.signup
            //                               : StringManager.login.tr,
            //                           style: const TextStyle(
            //                               fontSize: FontManagerSize.s22),
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 ),
            //                 !controller.isSignup
            //                     ? InkWell(
            //                   onTap: () {
            //                     setState(() {
            //                       controller.isSignup =
            //                       !controller.isSignup;
            //                     });
            //                   },
            //                   child: Text(
            //                     'You Dont Have Account Sign Up',
            //                     style: TextStyle(
            //                         fontSize: AppSize.s16,
            //                         color: ColorManager.primary,
            //                         fontWeight: FontWeight.w600),
            //                   ),
            //                 )
            //                     : InkWell(
            //                   onTap: () {
            //                     setState(() {
            //                       controller.isSignup = false;
            //                     });
            //                   },
            //                   child: Text(
            //                     'You  Have Account Signin',
            //                     style: TextStyle(
            //                         fontSize: AppSize.s16,
            //                         color: ColorManager.primary,
            //                         fontWeight: FontWeight.w600),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     }),
            //   ),
            // ),
          ],
        )





      ),
      //    ) end key action
    );
  }

  showpass1() {
    setState(() {
      pshow1 = !pshow1!;
    });
  }

  void _validateLoginInput() async {
    setState(() {
      _state = 1;
    });
    final FormState? form = _formKeyin.currentState;
    if (_formKeyin.currentState!.validate()) {
      form?.save();
      setState(() {
        _loading = true;
      });
      try {
        print('inside try');
        print(_email);

        User result = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email!, password: _pass1!)) as User;
        // print('result.user=${result.user}');
        user = result;

        if (user?.email == _cont_user.text.toString()) {
          print('ok go to main page');
//
          Navigator.pushNamed(context,'/PreHome');
//
//
        }
      }

      catch (error) {
        switch (error) {
          case "ERROR_USER_NOT_FOUND":
            {
              setState(() {
                errorMsg =
                "There is no user with such entries. Please try again.";

                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text('errorMsg'),
                      ),
                    );
                  });
            }
            break;
          case "ERROR_WRONG_PASSWORD":
            {
              setState(() {
                errorMsg = "Password doesn\'t match your email.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text('errorMsg'),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              setState(() {
                errorMsg = "";
              });
            }
        }
      }
    } else {
      setState(() {
        //show_alert('Message', 'errorMsg');
        _autoValidate = true;
      });
    }

    setState(() {
      _state = 2;

      //Navigator.pushReplacementNamed('/Home');
      // Navigator.of(context).pushNamed('/Home');

      //Navigator.pushNamed(context, '/Home');
      //Navigator.of(context).pushNamed('/Home');
      // Navigator.of(context).pushReplacementNamed('/Home');
    });
  }

  void logInToFb() {


    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _cont_user.text, password: _cont_pass1.text)
        .then((result) {
      Navigator.pushNamed(context, '/PreHome');
//      Navigator.pushReplacement(
//        context,
//        MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
//      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }


}