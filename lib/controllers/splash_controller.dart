import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../config/local_cofig.dart';
import '../controllers/home_controller.dart';
import '../common_widgets/dialogs_and_snacks.dart';
import '../controllers/location_controller.dart';
import '../controllers/settings_controller.dart';
import '../ui/screen_navigator/screen_navigator.dart';
import '../models/user.dart';
import '../services/api_calls/user_api_calls.dart';
import 'bottom_nav_bar_controller.dart';
import 'user_controller.dart';

class SplashController extends GetxController {
  RxBool animation1Started = false.obs;
  RxBool animation2Started = false.obs;

  UserController _userController = Get.find<UserController>();
  UserApiCalls _userApiCalls = UserApiCalls.instance;
  SettingsController _settingsCon = Get.find<SettingsController>();
  LocationController _locationCon = Get.find<LocationController>();
  @override
  void onInit() {
    checkIfUserLoggedIn();
    setAppConfig();
    super.onInit();
  }

  checkIfUserLoggedIn() async {
    final User currentUser = await _userController.getUserData();
    if (_userController.loggedIn) {
      final User userData = await _userApiCalls.userLogin(
          currentUser.phone, currentUser.password, true);
      userData.password = currentUser.password;
      if (userData != null) {
        _userController.setUserData(userData);
        print(
            'USER DATA FROM SPLASH=========================> ${userData.toJson()}');
      }
    }
  }

  setAppConfig() {
    Future.delayed(Duration(seconds: 1), () {
      animateLogo();
    }).then((_) {
      Future.delayed(Duration(seconds: 3), () {
        Get.put<BottomNavBarController>(
          BottomNavBarController(),
        );
        checkForNewVersion();
      });
    });
  }

  checkForNewVersion() {
    if (_settingsCon.version > LocalConfig.appVersion) {
      if (_settingsCon.forceUpdate) {
        showTwoButtonsDialog(
          barrierDismissible: false,
          title: 'new_version_available'.tr,
          msg: 'you_must_update_to_proceed'.tr,
          cancelText: 'close_app'.tr,
          okText: 'update_now'.tr,
          onOkTapped: () {},
          onCancelTapped: () {
            SystemNavigator.pop();
          },
        );
      } else {
        showTwoButtonsDialog(
          barrierDismissible: false,
          title: 'new_version_available'.tr,
          msg: '',
          cancelText: 'later'.tr,
          okText: 'update_now'.tr,
          onOkTapped: () {},
          onCancelTapped: () {
            Get.back();
            setMultiVendorConfig();
          },
        );
      }
    } else {
      setMultiVendorConfig();
    }
  }

  setMultiVendorConfig() {
    if (_settingsCon.isMultiVendor) {
      if (_locationCon.userLocation == null) {
        showTwoButtonsDialog(
            barrierDismissible: false,
            title: 'you_must_give_location_permission'.tr,
            msg: 'we_need_your_location_to_show_you_vendors_in_your_area'.tr,
            cancelText: 'close_app'.tr,
            okText: 'give_location'.tr,
            onOkTapped: () async {
              await _locationCon.getUserLocation();
              if (_locationCon.userLocation != null) {
                Get.back();
                navigateToApp();
              }
            },
            onCancelTapped: () {
              SystemNavigator.pop();
            });
      } else {
        navigateToApp();
      }
    } else {
      Get.put<HomeController>(HomeController(), permanent: true);
      navigateToApp();
    }
  }

  animateLogo() {
    Future.delayed(Duration(seconds: 2), () {
      animation1Started.toggle();
    });
    Future.delayed(Duration(seconds: 2), () {
      animation2Started.toggle();
    });
  }

  navigateToApp() async {
    await animateLogo();
    Future.delayed(Duration(seconds: 4), () {
      Get.offAll(() => ScreenNavigator(),
          transition: Transition.fadeIn, duration: Duration(seconds: 1));
    });
  }
}
