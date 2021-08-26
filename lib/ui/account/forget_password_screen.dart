import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../consts/colors.dart';
import '../../controllers/settings_controller.dart';
import '../../helpers/hex_color.dart';

class ForgetPassword extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_COLOR,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: HexColor("D6D6D6"),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          // SignFields(
                          //   signTextData: 'Mobile Number',
                          //   hint: 'Please Enter Your Mobile Number',
                          //   containerColor: 'FFFFFF',
                          //   textHeight: 1,
                          //   height: 80,
                          //   fontSize: 18,
                          //   corners: Corners(10, 10, 10, 10),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Please enter the user phone number as a SMS will be sent to reset the password '),
                          ),
                          Center(
                            child: CommonButton(
                              text: 'Forgot Your Password ?',
                              onTap: () {},
                              corners: Corners(10, 10, 10, 10),
                              width: 350,
                              height: 60,
                              fontSize: 22,
                              containerColor: _settingsCon.color2,
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 40),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
