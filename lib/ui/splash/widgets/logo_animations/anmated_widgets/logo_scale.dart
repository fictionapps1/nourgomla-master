import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/splash_controller.dart';
class LogoScaleAnimation extends StatelessWidget {
  final bool animateLogo;

  LogoScaleAnimation(this.animateLogo);
  @override
  Widget build(BuildContext context) {
    SplashController splashCon=Get.find<SplashController>();
    return Obx(
      ()=> ScaleAnimatedWidget.tween(
        enabled: splashCon.animation1Started.value,
        duration: Duration(seconds: 3),
        scaleDisabled: 0.0,
        scaleEnabled: 1,
        child: Center(
          child: Container(
            height: 180,
            width: 180,
            child: Image.asset('assets/logo.png',fit: BoxFit.fill,),
          ),
        ),
      ),
    );
  }
}