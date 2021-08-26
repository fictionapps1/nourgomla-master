import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/devider_row.dart';
import '../../common_widgets/corners.dart';
import '../../consts/colors.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../ui/splash/splash_screen.dart';
import '../../controllers/bottom_nav_bar_controller.dart';
import '../../controllers/splash_controller.dart';

class SettingsScreen extends StatelessWidget {
  final navController = Get.find<BottomNavBarController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_COLOR,
      appBar: AppBar(
        title: Text('app_settings'.tr),
        centerTitle: true,
        backgroundColor: _settingsCon.color1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            DividerRow('languages'.tr),
            const SizedBox(height: 20),
            GetBuilder<LanguageController>(
                init: Get.find(),
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonButton(
                        text: 'العربية',
                        containerColor: _settingsCon.color2,
                        height: 40,
                        corners: Corners(10, 10, 10, 10),
                        onTap: () {
                          navController.currentIndex.value = 0;
                          controller.toggleLanguage('ar');
                          Get.updateLocale(Locale('ar'));
                          Get.offAll(() => SplashScreen());
                          Get.find<SplashController>().navigateToApp();
                        },
                      ),
                      CommonButton(
                        text: 'English',
                        containerColor: _settingsCon.color2,
                        height: 40,
                        corners: Corners(10, 10, 10, 10),
                        onTap: () {
                          navController.currentIndex.value = 0;
                          controller.toggleLanguage('en');
                          Get.updateLocale(Locale('en'));
                          Get.offAll(() => SplashScreen());
                          Get.find<SplashController>().navigateToApp();
                        },
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
