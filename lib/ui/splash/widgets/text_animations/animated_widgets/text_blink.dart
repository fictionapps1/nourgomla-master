import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import '../../../../../controllers/splash_controller.dart';
import '../../../../../config/local_cofig.dart';
import 'package:get/get.dart';
class TextBlinkAnimation extends StatelessWidget {
final _splashCon=Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Container(
        height: 100,
        child: Stack(
          children: [
            if(_splashCon.animation1Started.value)
              Center(
                child: SizedBox(
                  width: 200.0,
                  child: Center(
                    child: Text(
                      LocalConfig.splashText,

                      style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.black,
                        fontFamily: 'Rakkas',
                      ),
                    ),
                  ),
                ),
              ),
            if(_splashCon.animation2Started.value)
              Center(
                child: SizedBox(
                  width: 200.0,
                  child: Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontFamily: 'Rakkas',
                        shadows: [
                          Shadow(
                            blurRadius: 7.0,
                            color: Colors.white70,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: BlinkText(
                        LocalConfig.splashText,
                        style: TextStyle(
                          fontSize: 60.0,
                          fontFamily: 'Rakkas',
                        ),
                        beginColor: Colors.black,
                        endColor: LocalConfig.splashTextColor,
                        times: 10,
                        duration: Duration(milliseconds: 2),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
