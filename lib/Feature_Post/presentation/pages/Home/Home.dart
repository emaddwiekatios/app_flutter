//import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/HomePage.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/Auth.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/loginNew.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/view_login.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Types/TypeMain.dart';
//import 'package:clean_arch_app/Feature_Post/presentation/pages/logingpt.dart';
//import 'package:clean_arch_app/Feature_Post/presentation/pages/splash/splash.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/material.dart';

///import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../manager/Language/LocaleController.dart';
//import '../Products/ProductsClass.dart';
//import 'HomePage.dart' as home;

import '../LayoutBuilder/LayoutBuilder.dart';

import '../TypeCategory/TypeCategoryMain.dart';

import '../Types/PreTypeMain.dart';

///import '../../../../core/resource/template.dart';
import 'HomePage.dart';

//emad add not  to test  add
//add  new change
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

LocaleController localeController = Get.put(LocaleController());
Auth _authlogout = Get.put(Auth());

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: Text('Home'.tr),)

        body: HomePage(),
      ),
    );
  }
}

Widget getDrawer(context) {
  return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: Container(
                  height: getHeight(context) / 5,
                  width: getWidth(context) / 5,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AssetManager.splash1,
                    fit: BoxFit.fill,
                  ),
                  //  fit: BoxFit.fill),
                ),
                accountName: const Text('Emad Dwiekat'),
                accountEmail: const Text('Emad@gmail.com'),
                currentAccountPictureSize: const Size.fromRadius(40),
                // arrowColor: Theme.of(context).backgroundColor,
                //  decoration: BoxDecoration(
                //      color:Theme.of(context).backgroundColor
                //  ),
              ),

              ListTile(
                  leading: Icon(
                    Icons.home,
                    color: ColorManager.primary,
                  ),
                  title: Text('Home'.tr),
                  trailing: Text('Details'.tr),
                  onTap: () {
                    //print('ontap');
                    Navigator.pop(context);
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),

              //
              ListTile(
                  leading: Icon(
                    Icons.generating_tokens,
                    color: ColorManager.primary,
                  ),
                  title: Text('Add'.tr),
                  trailing: Text('Add'.tr),
                  onTap: () {
                    ////print('ontap');
                    Get.toNamed('/AddPages');
                    //  Get.to(() => GetxManagement());
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),

              ListTile(
                  leading: Icon(
                    Icons.generating_tokens,
                    color: ColorManager.primary,
                  ),
                  title: Text('testing'.tr),
                  trailing: Text('Add'.tr),
                  onTap: () {
                    print('ontap');
                    Get.toNamed('/testing');
                    //  Get.to(() => GetxManagement());
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),

              const Text('Admin Tab'),
              const Divider(
                height: FontManagerSize.s8,
              ),
              ListTile(
                  leading: Icon(
                    Icons.generating_tokens,
                    color: ColorManager.primary,
                  ),
                  title: Text('Product'.tr),
                  trailing: Text('Product'.tr),
                  onTap: () {
                    ////print('ontap');
                    Get.toNamed('/ProductMainNew');
                    //  Get.to(() => GetxManagement());
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),
              ListTile(
                  leading: Icon(
                    Icons.generating_tokens,
                    color: ColorManager.primary,
                  ),
                  title: Text('Categorys'.tr),
                  trailing: Text('Categorys'.tr),
                  onTap: () {
                    ////print('ontap');
                    Get.toNamed('/CategoryMain');
                    //  Get.to(() => GetxManagement());
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),
              ListTile(
                  leading: Icon(
                    Icons.layers_outlined,
                    color: ColorManager.primary,
                  ),
                  title: Text('Masaref'.tr),
                  trailing: Text('Masaref'.tr),
                  onTap: () {
                    //Get.toNamed(RoutesManager.layoutbuilderRoute);
                    Get.to(() => PreTypeMain());
                  }),
              ListTile(
                  leading: Icon(
                    Icons.layers_outlined,
                    color: ColorManager.primary,
                  ),
                  title: Text('Type Category'.tr),
                  //trailing: Text('Type Category'.tr),
                  onTap: () {
                    //Get.toNamed(RoutesManager.layoutbuilderRoute);
                    Get.to(() => TypeCategoryMain());
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),
            ],
          ),
          ListTile(
              leading: Icon(
                Icons.home,
                color: ColorManager.primary,
              ),
              title: Text('Lang'.tr),
              trailing: Text('Lang'.tr),
              onTap: () {
                if (localeController.currentLanguage == const Locale('en')) {
                  localeController.changeLanguage(const Locale('ar'));
                } else {
                  localeController.changeLanguage(const Locale('en'));
                }

                Navigator.pop(context);
              }),
          const Divider(
            height: FontManagerSize.s8,
          ),
          ListTile(
              leading: Icon(
                Icons.logout,
                color: ColorManager.primary,
              ),
              title: Text('Logout'.tr),
              trailing: Text('Logout'.tr),
              onTap: () {
                // _authlogout.logout();
                //   Navigator.of(context).pop();
                Navigator.pushNamed(context, '/SignIn');

                //  Navigator.pushReplacement(context,
                //      MaterialPageRoute(builder: (_)=> Splash()
                //      ));
                //
              }),
          const Divider(
            height: FontManagerSize.s8,
          ),
        ],
      ));
}
