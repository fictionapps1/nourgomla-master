import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:get/get.dart';

class EmptyView extends StatelessWidget {
  final String text;
  final String image;

  EmptyView({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(

            child: Center(
              child: Image.asset(
                image??'assets/no_data.png',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 40),
          CustomText(
              text: text ?? 'no_data'.tr, size: 30, weight: FontWeight.bold)
        ],
      ),
    );
  }
}
