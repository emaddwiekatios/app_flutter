import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/Home.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/Auth.dart';
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

  // final Auth _auth = Get.put(Auth(), permanent: true);

  GlobalKey<FormState> formkey = GlobalKey();

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
    //FocusScope.of(context).requestFocus(FocusNode());

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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(height: getHeight(context),
                width: getWidth(context),),
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
                            ))),
                  ),
                ),
                Positioned(
                  top: (getHeight(context)/2)-10,
                  left: 0,
                  right: 0,
                  child: GetBuilder<Auth>(
                    init: Auth(),
                    builder: ((controller) {
                      return Form(
                        key: formkey,
                        child: Card(
                         // elevation: 30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s20)),
                          // margin: const EdgeInsets.all(AppSize.s10),
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
                                      stream: loginViewModel1
                                          .getLoginViewModelOutUserName,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          showCursor: true,
                                          // readOnly: true,
                                          controller: controllerLoginUserName,
                                          decoration: InputDecoration(
                                              label:
                                                  Text(StringManager.userName.tr),
                                              hintText:
                                                  StringManager.userNameHint.tr,
                                              //  prefix: Text(StringManager.userName),
                                              prefixIcon: const Icon(Icons.email),
                                              errorText: (snapshot.data ?? true)
                                                  ? null
                                                  : StringManager.usernameError,
                                              suffix:
                                                  Text(StringManager.userName.tr),
                                              //  suffixText: StringManager.userName,
                                              suffixIcon: const Icon(
                                                  Icons.remove_red_eye_outlined)),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !value.contains('@')) {
                                              return 'Invalid Username';
                                            }
                                            return null;
                                          },
                                        );
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: StreamBuilder<bool>(
                                      stream: loginViewModel1
                                          .getLoginViewModelOutPassword,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          showCursor: true,
                                          // readOnly: true,
                                          controller: controllerLoginPassword,
                                          decoration: InputDecoration(
                                              label:
                                                  Text(StringManager.password.tr),
                                              hintText: StringManager.password.tr,
                                              //  prefix: Text(StringManager.userName),
                                              prefixIcon:
                                                  const Icon(Icons.password),
                                              errorText: (snapshot.data ?? true)
                                                  ? null
                                                  : StringManager.passwordError.tr,
                                              suffix:
                                                  Text(StringManager.password.tr),
                                              //  suffixText: StringManager.userName,
                                              suffixIcon: const Icon(
                                                  Icons.remove_red_eye_outlined)),
                                        );
                                      }),
                                ),
                                controller.isSignup
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: StreamBuilder<bool>(
                                            stream: loginViewModel1
                                                .getLoginViewModelOutPassword,
                                            builder: (context, snapshot) {
                                              return TextFormField(
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                showCursor: true,
                                                // readOnly: true,
                                                controller:
                                                    controllerLoginPasswordconfirm,
                                                decoration: InputDecoration(
                                                    label: Text(StringManager
                                                        .confirmPassword.tr),
                                                    hintText: StringManager
                                                        .confirmPassword.tr,
                                                    //  prefix: Text(StringManager.userName),
                                                    prefixIcon:
                                                        const Icon(Icons.password),
                                                    errorText:
                                                        (snapshot.data ?? true)
                                                            ? null
                                                            : StringManager
                                                                .passwordError.tr,
                                                    suffix: Text(StringManager
                                                        .confirmPassword.tr),
                                                    //  suffixText: StringManager.userName,
                                                    suffixIcon: const Icon(Icons
                                                        .remove_red_eye_outlined)),
                                              );
                                            }),
                                      )
                                    : Container(),
                                // Text('${controller.errorMessage}'),
                                controller.isSignup
                                    ? Container(
                                        height: getHeight(context) / 20,
                                        width: getWidth(context),
                                        margin: const EdgeInsets.all(
                                            FontManagerSize.s8),
                                        child: StreamBuilder<bool>(
                                          stream: loginViewModel1
                                              .getLoginViewModelOutLoginButton,
                                          builder: (context, snapshot) {
                                            return ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          (snapshot.data ?? false)
                                                              ? ColorManager.primary
                                                              : ColorManager.grey)),
                                              onPressed: (snapshot.data ?? false)
                                                  ? () async {
                                                      //print('insiude button');
                                                      String user =
                                                          controllerLoginUserName
                                                              .text
                                                              .toString();
                                                      String password =
                                                          controllerLoginPassword
                                                              .text
                                                              .toString();

                                                      await controller.signup(
                                                          user, password);

                                                      if (controller.errorMessage!
                                                              .length >
                                                          3) {
                                                        //print('inside error button');
                                                        Get.defaultDialog(
                                                          title: 'The User Error',
                                                          content: Text(
                                                              '${controller.errorMessage}'),
                                                          // backgroundColor: ColorManager.grey,
                                                          cancel: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ElevatedButton.icon(
                                                                label: const Text(
                                                                    'Ok'),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: const Icon(
                                                                    Icons.done),
                                                              ),
                                                              ElevatedButton.icon(
                                                                  label: const Text(
                                                                      'Canceled'),
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons.abc)),
                                                            ],
                                                          ),
                                                        );
                                                      } else if (controller
                                                              .userId!.isNotEmpty &&
                                                          !controller.isSignup) {
                                                        ////print('inside go to home ');
                                                        ////print(controller.userId);
                                                        ////print(    !controller.isSignup);

                                                        Get.to(() => const Home());
                                                      }

                                                      ////print(' after if 3');
                                                    }
                                                  : null,
                                              child: Text(
                                                controller.isSignup
                                                    ? StringManager.signup
                                                    : StringManager.login.tr,
                                                style: const TextStyle(
                                                    fontSize: FontManagerSize.s22),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Container(
                                        height: getHeight(context) / 20,
                                        width: getWidth(context),
                                        margin: const EdgeInsets.all(
                                            FontManagerSize.s8),
                                        child: StreamBuilder<bool>(
                                          stream: loginViewModel1
                                              .getLoginViewModelOutLoginButton,
                                          builder: (context, snapshot) {
                                            return ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          (snapshot.data ?? false)
                                                              ? ColorManager.primary
                                                              : ColorManager.grey)),
                                              onPressed: (snapshot.data ?? false)
                                                  ? () async {
                                                      // //print('insiude button sign in');
                                                      String user =
                                                          controllerLoginUserName
                                                              .text
                                                              .toString();
                                                      String password =
                                                          controllerLoginPassword
                                                              .text
                                                              .toString();
                                                      ////print(user);
                                                      ////print(password);
                                                      await controller.signin(
                                                          user, password);

                                                      if (controller.errorMessage!
                                                              .length >
                                                          3) {
                                                        //print('inside error button');
                                                        Get.defaultDialog(
                                                          title: 'The User Error',
                                                          content: Text(
                                                              '${controller.errorMessage}'),
                                                          // backgroundColor: ColorManager.grey,
                                                          cancel: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ElevatedButton.icon(
                                                                label: const Text(
                                                                    'Ok'),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: const Icon(
                                                                    Icons.done),
                                                              ),
                                                              ElevatedButton.icon(
                                                                  label: const Text(
                                                                      'Canceled'),
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons.abc)),
                                                            ],
                                                          ),
                                                        );
                                                      } else if (controller
                                                              .userId!.isNotEmpty &&
                                                          controller.isSignup) {
                                                        Get.defaultDialog(
                                                          title: 'Create User',
                                                          content: Text(
                                                              'The user Created : ${controller.email}'),
                                                          confirm:
                                                              ElevatedButton.icon(
                                                                  label: const Text(
                                                                      'you can Login '),
                                                                  onPressed: () {
                                                                    // controller.changeisSignup(!controller.isSignup);
                                                                    // controllerLoginPassword.clear();
                                                                    // controllerLoginPasswordconfirm.clear();
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: const Icon(Icons
                                                                      .personal_injury)),
                                                        );
                                                      } else if (controller
                                                              .userId!.isNotEmpty &&
                                                          !controller.isSignup) {
                                                        ////print('inside go to home ');
                                                        ////print(controller.userId);
                                                        ////print(    !controller.isSignup);

                                                        //Get.to(() => const Home());
                                                      }

                                                      // //print(' after if 3');
                                                    }
                                                  : null,
                                              child: Text(
                                                controller.isSignup
                                                    ? StringManager.signup
                                                    : StringManager.login.tr,
                                                style: const TextStyle(
                                                    fontSize: FontManagerSize.s22),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                !controller.isSignup
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.isSignup =
                                                !controller.isSignup;
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
                                            controller.isSignup = false;
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
                      );
                    }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
