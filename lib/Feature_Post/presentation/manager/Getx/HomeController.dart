import 'package:get/get.dart';

//GetX OBX
class HomeController extends GetxController
{
  RxInt counter = 0.obs ;
  void increase()
  {
    counter++;

   // update();
  }

  void decrease()
  {
    counter--;

   // update();
  }
}

//GetBuildder
class HomeControllerGetBuilder extends GetxController
{
  int counter = 0;
  void increase()
  {
    counter++;

     update();
  }

  void decrease()
  {
    counter--;

    update();
  }
}