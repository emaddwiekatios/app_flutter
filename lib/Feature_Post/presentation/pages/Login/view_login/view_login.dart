import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/Home.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';
import 'package:clean_arch_app/core/resource/StyleManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewModel_login/viewmodel_login.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  LoginViewModel loginViewModel1 = LoginViewModel();

  TextEditingController controllerLoginUserName = TextEditingController();
  TextEditingController controllerLoginPassword = TextEditingController();

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
          Image.asset(AssetManager.onBoardLogo),
          SizedBox(
            height: get_height(context) / 15,
          ),
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
                        suffixIcon: const Icon(Icons.remove_red_eye_outlined)),
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
                        suffixIcon: const Icon(Icons.remove_red_eye_outlined)),
                  );
                }),
          ),
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
                            Get.to(() => const Home());
                            //Get.off(()=>Home() );
                            //    Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);
                          }
                        : null,
                    child: Text(
                      StringManager.login.tr,
                      style: const TextStyle(fontSize: FontManagerSize.s22),
                    ),
                  );
                }),
          ),
          // Center(child: Text(StringManager.login.tr)),
        ],
      ),
    ));
  }
}
