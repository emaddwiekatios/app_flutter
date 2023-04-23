import 'package:clean_arch_app/Feature_Post/presentation/manager/Getx/HomeController.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/GetxManagement/Second.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class getManagement extends StatelessWidget {
  getManagement({Key? key}) : super(key: key);
  final HomeController _homeController =
      Get.put(HomeController(), permanent: true);
  //final HomeController _homeController2 =Get.put(HomeController(), permanent: true);
TextEditingController contName =TextEditingController();
  TextEditingController contAge =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('OBx'),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _homeController.increase();
                    },
                    child: const Text('Increase'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${_homeController.counter.obs}'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _homeController.decrease();
                    },
                    child: const Text('Decrease'),
                  ),
                ],
              );
            }),
            const Text('GetBuilder'),
            // GetBuilder<HomeController()>(
            const Text('GetX'),
            GetX<HomeController>(
              init: HomeController(),
              builder: ((controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.increase();
                      },
                      child: const Text('Increase'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${controller.counter.obs}'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.decrease();
                      },
                      child: const Text('Decrease'),
                    ),
                  ],
                );
              }),
            ),
            const Text('GetBuilder'),
            GetBuilder<HomeControllerGetBuilder>(
              init: HomeControllerGetBuilder(),
              builder: ((controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.increase();
                      },
                      child: const Text('Increase'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${controller.counter}'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.decrease();
                      },
                      child: const Text('Decrease'),
                    ),
                  ],
                );
              }),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        'Message',
                        'the value is valid  go ',
                        backgroundColor: Colors.blue,
                        animationDuration: const Duration(seconds: 4),
                        borderColor: Colors.yellowAccent,
                        borderRadius:70,
                        borderWidth: 5);
                    },
                    child: const Text(' Show Snakbar')),
                ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(title: 'Home'.tr,
                       // backgroundColor: Colors.tealAccent,
                      cancel: const Text('Candceled '),
                      onCancel: ()
                          {
                            //print('canceled');
                            Navigator.pop(context);
                          },
                      onConfirm: ()
                          {
                         //  //print('ok');
                          },
                      confirm: const Text('confirm')
                          );

                    },
                    child:const  Text(' Show Delog')),
              ],
            ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            showCursor: true,
            // readOnly: true,
            controller: contName,
            decoration: const InputDecoration(
                label: Text(StringManager.password),
                hintText: StringManager.password,
                //  prefix: Text(StringManager.userName),
                prefixIcon: Icon(Icons.password),

                suffix: Text(StringManager.password),
                //  suffixText: StringManager.userName,
                suffixIcon: Icon(Icons.remove_red_eye_outlined)),
          ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              showCursor: true,
              // readOnly: true,
              controller: contAge,
              decoration: const InputDecoration(
                  label: Text(StringManager.password),
                  hintText: StringManager.password,
                  //  prefix: Text(StringManager.userName),
                  prefixIcon: Icon(Icons.password),

                  suffix: Text(StringManager.password),
                  //  suffixText: StringManager.userName,
                  suffixIcon: Icon(Icons.remove_red_eye_outlined)),
            ),

            ElevatedButton(
                onPressed: () {
                  Get.to(()=> const Second(),arguments: {
                    "name":contName.text,
                    "age":contAge.text
                  });
                },
                child: const Text('Go to next Page'))
          ],
        ),
      ),
    );
  }
}
