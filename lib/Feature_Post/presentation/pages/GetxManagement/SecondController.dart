import 'package:get/get.dart';

class NextPage extends GetxController
{
  String? name ;
  String? age;


  @override
  void onInit() {
    // TODO: implement onInit
    name = Get.arguments["name"];
     age = Get.arguments["age"];
    super.onInit();
  }

}