import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../../../../config/local_cofig.dart';

class TextColorizeAnimation extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  TextColorizeAnimation({this.text, this.fontFamily, this.fontSize});
  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    final colorizeTextStyle = TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
    );
    return SizedBox(
      width: 250.0,
      height: 50,
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              text ?? LocalConfig.splashText,
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
