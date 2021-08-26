import 'package:flutter/material.dart';
import '../../../../controllers/splash_controller.dart';
import '../logo_animations/anmated_widgets/logo_fade.dart';
import '../../../../config/local_cofig.dart';
import 'anmated_widgets/logo_scale.dart';
import 'anmated_widgets/logo_shake.dart';
import 'package:get/get.dart';

class LogoAnimationBuilder extends StatelessWidget {
  final SplashController _splashCon = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return buildLogoAnimation();
  }

  buildLogoAnimation() {
    switch (LocalConfig.splashLogoAnimation) {
      case LogoAnimations.scale:
        return LogoScaleAnimation(_splashCon.animation1Started.value);
        break;
      case LogoAnimations.fade:
        return LogoFadeAnimation(_splashCon.animation1Started.value);
        break;
      case LogoAnimations.shake:
        return LogoShakeAnimation(_splashCon.animation1Started.value);
        break;
    }
  }
}
