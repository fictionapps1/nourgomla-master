import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class LogoShakeAnimation extends StatelessWidget {
  final bool animateLogo;

  LogoShakeAnimation(this.animateLogo);
  @override
  Widget build(BuildContext context) {
    return ShakeAnimatedWidget(
      enabled: animateLogo,
      duration: Duration(milliseconds: 1000),
      shakeAngle: Rotation.deg(z: 10),
      curve: Curves.linear,
      child: Center(
        child: Container(
          height: 150,
          width: 150,
          child: Image.asset('assets/logo.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
