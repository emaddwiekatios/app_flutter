import 'package:clean_arch_app/Feature_Post/presentation/pages/GetxManagement/SecondController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final NextPage _secondController =Get.put(NextPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('name :${_secondController.name}'),
            Text('Age : ${_secondController.age}'),
          ],
        ),
      ),
    );
  }
}
