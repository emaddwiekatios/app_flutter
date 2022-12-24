import 'dart:convert';
import 'dart:math';

import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/Home.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';
import 'package:clean_arch_app/core/resource/StyleManger.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewModel_login/viewmodel_login.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  LoginViewModel loginViewModel1 = LoginViewModel();

  bool isSignup = false;
  String ererorMessage = '';

  TextEditingController controllerLoginUserName = TextEditingController();
  TextEditingController controllerLoginPassword = TextEditingController();
  TextEditingController controllerLoginPasswordconfirm =
      TextEditingController();
  _bind() {
    loginViewModel1.start();
    controllerLoginUserName.addListener(
        () => loginViewModel1.setUserName(controllerLoginUserName.text));
    controllerLoginPassword.addListener(
        () => loginViewModel1.setPassword(controllerLoginPassword.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    FocusScope.of(context).requestFocus(FocusNode());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
        body: InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                transform: Matrix4.rotationZ(-8 * pi / 180),
                height: get_height(context) / AppSize.s10,
                width: get_width(context) / AppSize.s2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.yellow, Colors.orange],
                        begin: Alignment.topRight,
                        end: Alignment.topLeft),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Shopy',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.black),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                    ),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.blue,
                    ),
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
          // Image.asset(AssetManager.onBoardLogo),
          SizedBox(
            height: get_height(context) / 15,
          ),
          Card(
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s20)),
            margin: EdgeInsets.all(AppSize.s10),
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s28),
              child: Column(
                children: [
                  Text(
                    StringManager.login.tr,
                    style: getBoldStyle(color: ColorManager.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<bool>(
                        stream: loginViewModel1.getLoginViewModelOutUserName,
                        builder: (context, snapshot) {
                          return TextFormField(
                            showCursor: true,
                            // readOnly: true,
                            controller: controllerLoginUserName,
                            decoration: InputDecoration(
                                label: Text(StringManager.userName.tr),
                                hintText: StringManager.userNameHint.tr,
                                //  prefix: Text(StringManager.userName),
                                prefixIcon: const Icon(Icons.email),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : StringManager.usernameError,
                                suffix: Text(StringManager.userName.tr),
                                //  suffixText: StringManager.userName,
                                suffixIcon:
                                    const Icon(Icons.remove_red_eye_outlined)),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<bool>(
                        stream: loginViewModel1.getLoginViewModelOutPassword,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            showCursor: true,
                            // readOnly: true,
                            controller: controllerLoginPassword,
                            decoration: InputDecoration(
                                label: Text(StringManager.password.tr),
                                hintText: StringManager.password.tr,
                                //  prefix: Text(StringManager.userName),
                                prefixIcon: const Icon(Icons.password),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : StringManager.passwordError.tr,
                                suffix: Text(StringManager.password.tr),
                                //  suffixText: StringManager.userName,
                                suffixIcon:
                                    const Icon(Icons.remove_red_eye_outlined)),
                          );
                        }),
                  ),
                  isSignup
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<bool>(
                              stream:
                                  loginViewModel1.getLoginViewModelOutPassword,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  showCursor: true,
                                  // readOnly: true,
                                  controller: controllerLoginPasswordconfirm,
                                  decoration: InputDecoration(
                                      label: Text(
                                          StringManager.Confirmpassword.tr),
                                      hintText:
                                          StringManager.Confirmpassword.tr,
                                      //  prefix: Text(StringManager.userName),
                                      prefixIcon: const Icon(Icons.password),
                                      errorText: (snapshot.data ?? true)
                                          ? null
                                          : StringManager.passwordError.tr,
                                      suffix: Text(
                                          StringManager.Confirmpassword.tr),
                                      //  suffixText: StringManager.userName,
                                      suffixIcon: const Icon(
                                          Icons.remove_red_eye_outlined)),
                                );
                              }),
                        )
                      : Container(),
                  Text(ererorMessage),
                  Container(
                    height: get_height(context) / 20,
                    width: get_width(context),
                    margin: const EdgeInsets.all(FontManagerSize.s8),
                    child: StreamBuilder<bool>(
                        stream: loginViewModel1.getLoginViewModelOutLoginButton,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    (snapshot.data ?? false)
                                        ? ColorManager.primary
                                        : ColorManager.grey)),
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    String user =
                                        controllerLoginUserName.text.toString();
                                    String password =
                                        controllerLoginPassword.text.toString();
                                    isSignup
                                        ? signup(user, password)
                                        : signin(user, password);

                                    //Get.to(() => const Home());
                                    //Get.off(()=>Home() );
                                    //    Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => Home()));
                                  }
                                : null,
                            child: Text(
                              isSignup
                                  ? StringManager.signup
                                  : StringManager.login.tr,
                              style: const TextStyle(
                                  fontSize: FontManagerSize.s22),
                            ),
                          );
                        }),
                  ),
                  !isSignup
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              isSignup = true;
                            });
                          },
                          child: Text(
                            'You Dont Have Account Sign Up',
                            style: TextStyle(
                                fontSize: AppSize.s16,
                                color: ColorManager.primary,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              isSignup = false;
                            });
                          },
                          child: Text(
                            'You  Have Account Signin',
                            style: TextStyle(
                                fontSize: AppSize.s16,
                                color: ColorManager.primary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void signin(String email, String password) {
    _authenticate(email, password, 'signInWithPassword');
  }

  void signup(String email, String password) {
    _authenticate(email, password, 'signUp');
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAPb2LfILtCTM_kopIGMbmoJ6nYsBARRUg';
    //signUp
    //signInWithPassword
    try {
      Uri uri = Uri.parse(url);
      final res = await http.post(uri,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureTolken': true
          }));
      final responsedata = json.decode(res.body);
      if (responsedata['error'] != null) {
        print(responsedata['error']['message']);
      }
      print(responsedata['email']);
      print(responsedata['localId']);
    } catch (e) {}
  }
}
