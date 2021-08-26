import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../controllers/settings_controller.dart';
import '../../ui/login/login_screen.dart';
import '../../ui/login/sign_up_screen.dart';
import '../../consts/colors.dart';
class LoginOptionsScreen extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: APP_BG_COLOR,
      appBar: AppBar(
        backgroundColor: _settingsCon.color1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 350,
              decoration: BoxDecoration(
                color: _settingsCon.color2,
                // border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'if_you_have_an_account'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: CommonButton(
                      height: 55,
                      text: 'log_in'.tr,
                      containerColor:  Colors.white,
                      width: 300,
                      textColor: "000000",
                      corners: Corners(35, 35, 35, 35),
                      fontSize: 22,
                      onTap: () {
                        Get.off(() => LoginScreen());
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'or_register'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: CommonButton(
                      height: 55,
                      text: 'sign_up'.tr,
                      containerColor:  Colors.white,
                      textColor: "000000",
                      width: 300,
                      corners: Corners(35, 35, 35, 35),
                      fontSize: 22,
                      onTap: () => Get.to(SignUp()),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
