import 'package:get/get.dart';

class PhoneController extends GetxController {
  String phoneIsoCode = 'EG';

  String confirmedNumber;
  String phoneErrMsg;


  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneIsoCode = isoCode;
    confirmedNumber = internationalizedPhoneNumber;
    if (internationalizedPhoneNumber == '') {
      phoneErrMsg = 'enter_correct_phone_number'.tr;
    } else {
      phoneErrMsg = null;
    }
    print('PHONE    === $internationalizedPhoneNumber');
    update();
  }

  setErrMsg() {
    phoneErrMsg = 'enter_correct_phone_number'.tr;
    update();
  }
}
