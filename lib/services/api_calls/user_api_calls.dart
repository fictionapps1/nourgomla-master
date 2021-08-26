
import 'package:get/get.dart';
import 'package:nourgomla/controllers/fcm_controller.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/user.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
import '../../ui/screen_navigator/screen_navigator.dart';

import 'phone_auth_services.dart';

class UserApiCalls {
  final APIService _apiService = APIService();
  UserApiCalls._internal();
  static final UserApiCalls _userApiCalls = UserApiCalls._internal();
  static UserApiCalls get instance => _userApiCalls;

  SettingsController _settingsController = Get.find<SettingsController>();

  Future<User> userSignUp(User user) async {
    bool forceVerify = _settingsController.phoneAuthRequired;
    try {
      print(
          "FCM TOKEN ===========================> ${user.fcmToken}");
      showLoadingDialog();
      final Map<String, dynamic> userResponse = await _apiService.postData(
          endpoint: Endpoints.registration, body: user.toJsonResister());
      print('USER SIGN UP RESPONSE=========> $userResponse');
      String message = userResponse["message"];
      bool success = userResponse["success"];
      if (userResponse.isNotEmpty && userResponse['data'] != null) {
        Get.back();
        showNormalDialog(
            dismissible: false,
            msg: message,
            title: '',
            onTapped: () {
              if (success) {
                Get.back();
                if (forceVerify) {
                  showPhoneAuthDialog(phone: user.phone);
                } else {
                  Get.offAll(() => ScreenNavigator());
                }
              } else {
                Get.back();
              }
            });
        return User.fromJson(userResponse['data'][0]);
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<User> userLogin(String phone, String password,
      [bool fromSplash = false]) async {
    try {
      if (!fromSplash) {
        showLoadingDialog();
      }
      FcmController fcmCon=Get.find<FcmController>();
      print(
          "FCM TOKEN ===========================> ${fcmCon.token}");
      final Map<String, dynamic> userResponse =
      await _apiService.postData(endpoint: Endpoints.login, body: {
        'phone': phone,
        'password': password,
        'token': fcmCon.token,
      });
      print("USER LOGIN RESPONSE=========> $userResponse");
      String message = userResponse["message"];
      bool success = userResponse["success"];
      bool showSurvey = userResponse["survey"];
      UserController _userController = Get.find<UserController>();
      _userController.showSurvey = showSurvey;

      if (userResponse.isNotEmpty && userResponse['data'] != null) {
        if (!fromSplash) {
          Get.back();
          showNormalDialog(
              msg: message,
              title: '',
              onTapped: () {
                if (success) {
                  Get.back();
                  Get.offAll(() => ScreenNavigator());
                } else {
                  Get.back();
                }
              });
        }
        return User.fromJson(userResponse['data'][0]);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<User> updateProfile(User user,
      [bool isForPhoneVerification = false]) async {
    try {
      showLoadingDialog();
      final Map<String, dynamic> userResponse = await _apiService.postData(
          endpoint: Endpoints.userUpdate, body: user.toJsonUpdateProfile());
      print("USER UPDATE PROFILE RESPONSE=========> $userResponse");

      String message = userResponse["message"];
      if (userResponse.isNotEmpty && userResponse['data'] != null) {
        Get.back();
        if (isForPhoneVerification) {
          showNormalDialog(
              msg: 'your_account_activated_successfully'.tr,
              title: '',
              onTapped: () {
                Get.offAll(() => ScreenNavigator());
              });
        } else {
          showNormalDialog(
              msg: message,
              title: '',
              onTapped: () {
                Get.back();
              });
        }

        return User.fromJson(userResponse['data'][0]);
      }
      return null;
    } catch (error) {
      showErrorDialog('Error Updating Profile');
      return null;
    }
  }

  Future<bool> resetPassword(
      {int userId, String oldPassword, String newPassword}) async {
    try {
      showLoadingDialog();

      final Map<String, dynamic> userResponse = await _apiService
          .postData(endpoint: Endpoints.userResetPassword, body: {
        'user_id': userId,
        'password': oldPassword,
        'password_new': newPassword,
      });
      print("USER UPDATE PROFILE RESPONSE=========> $userResponse");

      String message = userResponse["message"];
      bool success = userResponse["success"];
      if (userResponse.isNotEmpty) {
        Get.back();
        showNormalDialog(
            msg: message,
            title: '',
            onTapped: () {
              Get.back();
            });
        if (success) {
          return true;
        }
      } else {
        return false;
      }
      return false;
    } catch (error) {
      showErrorDialog('Error Updating Password');
      return false;
    }
  }

  showPhoneAuthDialog({String phone}) async {
    showTwoButtonsDialog(
        title: 'you_have_to_activate_your_phone'.tr,
        okText: 'ok'.tr,
        onOkTapped: () async {
          Get.back();
          PhoneAuthServices _auth = PhoneAuthServices.instance;
          await _auth.verifyPhoneNumber(
            number: phone,
          );
        },
        cancelText: 'later'.tr,
        onCancelTapped: () {
          Get.back();
        });
  }

  contactUsInsert(
      {String phone, String name, String type, String content}) async {
    try {
      UserController _userCon = Get.find<UserController>();
      final Map<String, dynamic> userResponse = await _apiService
          .postData(endpoint: Endpoints.contactUsInsert, body: {
        'phone': phone,
        'name': name,
        'type': type,
        'created_by': _userCon.loggedIn ? _userCon.currentUser.id : '',
        'content': content,
        'language_id': '1',
      });
      print("USER CONTACT US RESPONSE=========> $userResponse");

      if (userResponse.isNotEmpty) {
        String message = userResponse["message"];
        bool success = userResponse["success"];

        showNormalDialog(
            msg: message,
            title: '',
            onTapped: () {
              if (success) {
                Get.back();
                Get.offAll(() => ScreenNavigator());
              } else {
                Get.back();
              }
            });
      }
    } catch (error) {
      return null;
    }
  }
}
