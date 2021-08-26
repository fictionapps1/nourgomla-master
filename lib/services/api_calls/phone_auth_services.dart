import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../ui/login/phone_auth.dart';
import '../../services/api_calls/user_api_calls.dart';
import '../../common_widgets/dialogs_and_snacks.dart';

class PhoneAuthServices {
  PhoneAuthServices._internal();
  static PhoneAuthServices _phoneAuthServices = PhoneAuthServices._internal();
  static PhoneAuthServices get instance => _phoneAuthServices;

  static FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  String errorMsg = "";
  String errorMessage = '';

  verifyPhoneNumber({String number}) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
      print('VER ID==============> $verificationId');
      Get.back();
      Get.to(
        PhoneAuthScreen(verId: verId, phone: number),
      );
      return verificationId;
    };
    try {
      showLoadingDialog();
      await _auth.verifyPhoneNumber(
        phoneNumber: number.trim(),
        verificationCompleted: (AuthCredential credential) async {
          UserCredential credentialData =
              await _auth.signInWithCredential(credential);
          User user = credentialData.user;
          if (user != null) {
            activateUserAccount(number);
          }
        },
        verificationFailed: (FirebaseAuthException exception) {
          print("${exception.message}  SOME THING WENT WRONG");
        },
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: (verId) {
          verificationId = verId;
        },
        // autoRetrievedSmsCodeForTesting: '123456',
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      Get.back();
      print(e);
    }
  }

  signInWithPhone({String smsOTP, String verId, String phone}) async {
    print('signInWithPhone    VER ID==============> $verificationId');
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: smsOTP,
      );
      print("=========================================>  OTP   $smsOTP");
      print("=========================================>  verId   $verId");
      final authResult = await _auth.signInWithCredential(credential);
      if (authResult != null) {
        activateUserAccount(phone);
      }
    } catch (e) {
      print("************************************************* $e");
    }
  }

  activateUserAccount(String phone) {
    UserApiCalls _userApiCalls = UserApiCalls.instance;
    UserController _userController = Get.find<UserController>();
    final currentUser = _userController.currentUser;
    currentUser.phoneVerified = 1;
    currentUser.phone = phone;
    _userApiCalls.updateProfile(currentUser, true);
    print(
        'USER***********************************************>  ${currentUser.toJson()}');
  }
}
