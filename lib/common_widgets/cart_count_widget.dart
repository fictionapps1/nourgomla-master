import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_text.dart';
import '../controllers/cart_controller.dart';
import '../controllers/bottom_nav_bar_controller.dart';
import '../ui/screen_navigator/screen_navigator.dart';

class CartCountWidget extends StatelessWidget {
  final navCon=Get.find<BottomNavBarController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: Get.find<CartController>(),
        builder: (cartController) {
          return Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {
                  Get.offAll(() => ScreenNavigator());
                  Future.delayed(Duration.zero, () {
                    navCon.currentIndex.value=2;
                  });
                },
              ),
              if (cartController.cartProducts.isNotEmpty)
                Positioned(
                    bottom: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: FittedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CustomText(
                          text: cartController.cartProducts.length.toString(),
                          color: Colors.white,
                        ),
                      )),
                    )),
            ],
          );
        });
  }
}
