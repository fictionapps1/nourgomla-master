import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/splash_controller.dart';
import '../../../../config/local_cofig.dart';
import 'animated_widgets/text_blink.dart';
import 'animated_widgets/text_colorize.dart';
import 'animated_widgets/text_type_writing.dart';

class TextAnimationBuilder extends StatelessWidget {

  final SplashController _splashCon = Get.find<SplashController>();


  @override
  Widget build(BuildContext context) {
    return buildTextAnimation();
  }

  buildTextAnimation() {
    switch (LocalConfig.splashTextAnimation) {
      case TextAnimations.blink:
        return TextBlinkAnimation();
        break;
      case TextAnimations.typeWriting:
        return TextTypeWritingAnimation(_splashCon.animation1Started.value, _splashCon.animation2Started.value);
        break;
      case TextAnimations.colorize:
        return TextColorizeAnimation(fontSize: 60,fontFamily: 'Rakkas',);
        break;
    }
  }
}
