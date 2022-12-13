import 'package:clean_arch_app/Feature_Post/presentation/manager/Language/LocaleController.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/GetxManagement/GetxMangment.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/HomePage.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/LayoutBuilder/LayoutBuilder.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/resource/template.dart';

//emad add not  to test  add
//add  new change
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

LocaleController localeController = Get.put(LocaleController());

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: Text('Home'.tr),)

        body: HomePage(),
      ),
    );
  }
}

Widget GetDrower(context) {
  return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: Container(
                  height: get_height(context) / 5,
                  width: get_width(context) / 5,
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
                    print('ontap');
                    Navigator.pop(context);
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),
              ListTile(
                  leading: Icon(
                    Icons.generating_tokens,
                    color: ColorManager.primary,
                  ),
                  title: Text('GetX'.tr),
                  trailing: Text('Getx'.tr),
                  onTap: () {
                    print('ontap');
                    Get.to(() => GetxManagement());
                  }),
              const Divider(
                height: FontManagerSize.s8,
              ),
              ListTile(
                  leading: Icon(
                    Icons.layers_outlined,
                    color: ColorManager.primary,
                  ),
                  title: Text('Layout'.tr),
                  trailing: Text('Layout'.tr),
                  onTap: () {
                    Get.to(() => GetLayoutBuilder());
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
                if (localeController.currentLanguage == Locale('en'))
                  localeController.changeLanguage(Locale('ar'));
                else
                  localeController.changeLanguage(Locale('en'));

                Navigator.pop(context);
              }),
          const Divider(
            height: FontManagerSize.s8,
          ),
        ],
      ));
}
