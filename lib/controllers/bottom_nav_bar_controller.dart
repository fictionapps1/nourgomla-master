import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common_widgets/dialogs_and_snacks.dart';
import '../controllers/settings_controller.dart';
import '../controllers/user_controller.dart';
import '../ui/survey/survey_screen.dart';

class BottomNavBarController extends GetxController {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final UserController _userController = Get.find<UserController>();
  var currentIndex = 0.obs;

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      if (_userController.showSurvey) {
        showTwoButtonsDialog(
            onOkTapped: () {
              Get.back();
              Get.to(SurveyScreen('2'));

            },
            msg: 'you_have_unfinished_survey'.tr);
      }
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: _settingsCon.color2,
      statusBarBrightness: Brightness.dark,
    ));

    super.onInit();
  }
}
