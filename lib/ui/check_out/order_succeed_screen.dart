import 'package:flutter/material.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/cached_image.dart';
import '../../common_widgets/corners.dart';
import '../../common_widgets/custom_text.dart';
import 'package:get/get.dart';
import '../../consts/colors.dart';
import '../../controllers/settings_controller.dart';
import '../screen_navigator/screen_navigator.dart';
import '../../controllers/bottom_nav_bar_controller.dart';

class OrderSucceedScreen extends StatelessWidget {
  final navController = Get.find<BottomNavBarController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_COLOR,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedImage(
              'https://cdn1.iconfinder.com/data/icons/youtuber/256/thumbs-up-like-gesture-512.png',
              height: 200,
              notFromOurApi: true,
              width: 200,
            ),
            CustomText(
                text: 'order_sent_successfully'.tr,
                size: 25,
                weight: FontWeight.bold,
                color: Colors.green),
            CommonButton(
              containerColor: _settingsCon.color2,
              width: 200,
              height: 40,
              corners: Corners(20, 20, 20, 20),
              fontSize: 17,
              onTap: () {
                navController.currentIndex.value = 1;

                Get.to(() => ScreenNavigator(categoryIndex: 1));
              },
              text: 'continue_shopping'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
