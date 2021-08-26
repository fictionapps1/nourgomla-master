import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../../../../config/local_cofig.dart';
class TextTypeWritingAnimation extends StatelessWidget {
  final bool animateLogo;
  final bool animateText;
  TextTypeWritingAnimation(this.animateLogo, this.animateText);
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          LocalConfig.splashText,
          textStyle: const TextStyle(
              fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white,fontFamily:'Rakkas' ),
          speed: const Duration(milliseconds: 200),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}