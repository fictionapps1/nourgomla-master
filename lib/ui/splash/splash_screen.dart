import 'package:flutter/material.dart';
import 'package:nourgomla/common_widgets/custom_text.dart';
import '../../controllers/splash_controller.dart';
import '../../config/local_cofig.dart';
import 'widgets/text_animations/animated_widgets/text_colorize.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _splashCon = Get.put(SplashController());

    return Scaffold(
      backgroundColor: LocalConfig.splashBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _splashCon.animation1Started.value =
                  !_splashCon.animation1Started.value;
              Future.delayed(Duration(microseconds: 300), () {
                _splashCon.animation2Started.value =
                    !_splashCon.animation2Started.value;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  const SizedBox(height: 200),
                  Obx(
                    () => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedContainer(
                                curve: Curves.easeInCubic,
                                duration: Duration(
                                  milliseconds: 500,
                                ),
                                width: _splashCon.animation1Started.value ? 220 : 96,
                                height: 93,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    )),
                              ),
                              AnimatedPositioned(
                                curve: Curves.easeInCubic,
                                duration: Duration(
                                  milliseconds: 500,
                                ),
                                left: _splashCon.animation1Started.value ? 105 : 0,
                                height: 92,
                                child: Image.asset('assets/2.png'),
                              ),
                              AnimatedPositioned(
                                curve: Curves.easeInCubic,

                                duration: Duration(
                                  milliseconds: 500,
                                ),
                                left: 0,
                                height: 96,
                                // width: _splashCon.animateText.value ? 200 : 101,
                                child: Image.asset(
                                  'assets/1.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom:0,
                          right: 0,
                          child: CustomText(text:'TM',color: Colors.white,weight: FontWeight.bold,size: 10,),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Container(child: LogoAnimationBuilder()),
                  TextColorizeAnimation(
                    text: 'اصل الجملة',
                    fontFamily: 'Rakkas',
                    fontSize: 40,
                  ),
                  TextColorizeAnimation(
                    text: 'ــــــ منذ 1968 ـــــــ',
                    fontSize: 15,
                  ),
                ]),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Powered by:  ',
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                    TextSpan(
                      text: 'fictionapps.com',
                      style: TextStyle(color: Colors.blue[200]),
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '  Version:${LocalConfig.appVersion}  ',
                    style: TextStyle(color: Colors.grey[300], fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   Get.put(SplashController());
  //   return Scaffold(
  //     backgroundColor: LocalConfig.splashBgColor,
  //     body: ResponsiveBuilder(
  //       builder: (context, sizingInfo) => Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: [
  //           Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SizedBox(height: sizingInfo.screenHeight / 5),
  //               Container(child: LogoAnimationBuilder()),
  //               // const SizedBox(height: 20,),
  //               Container(child: TextAnimationBuilder()),
  //             ],
  //           ),
  //           Center(
  //             child: Column(
  //               children: [
  //                 RichText(
  //                     text: TextSpan(
  //                   children: [
  //                     TextSpan(
  //                       text: 'Powered by:  ',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                     TextSpan(
  //                       text: 'fictionapps.com',
  //                       style: TextStyle(color: Colors.blue),
  //                     ),
  //                   ],
  //                 )),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     '  Version:${LocalConfig.appVersion}  ',
  //                     style: TextStyle(color: Colors.grey[500], fontSize: 14),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
