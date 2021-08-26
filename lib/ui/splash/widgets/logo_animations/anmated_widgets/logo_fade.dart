import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class LogoFadeAnimation extends StatelessWidget {
  final bool animateLogo;

  LogoFadeAnimation(this.animateLogo);
  @override
  Widget build(BuildContext context) {
    return OpacityAnimatedWidget.tween(
      opacityEnabled: 1, //define start value
      opacityDisabled: 0, //and end value
      enabled: animateLogo, //bind with the boolean
      duration: Duration(seconds: 5),

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
