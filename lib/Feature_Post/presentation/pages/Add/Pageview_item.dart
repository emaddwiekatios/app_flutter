import 'package:clean_arch_app/core/resource/Construct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(this.image, this.title, this.subtitle, {super.key});
  final String? title;
  final String? subtitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image!,
        ),
        Text(title!),
        Text(subtitle!),

        // getButtonGeneral('Next', 20, 200, Color.fromARGB(555, 55, 55, 5))
      ],
    );
  }
}
