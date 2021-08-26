import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/user_controller.dart';
import '../ui/user_profile/widgets/gender_radio.dart';

class GenderController extends GetxController {
  int gender = 1;

  List<RadioButtonModel> genders;

  final UserController _userController = Get.find<UserController>();

  @override
  onInit() {
    initSelectedGender();
    super.onInit();
  }

  bool selected(int genderNum, String userGender) {
    if (genderNum == 1 && userGender == 'male') {
      return true;
    } else if (genderNum == 2 && userGender == 'female') {
      return true;
    } else if (genderNum == 3 && userGender == 'others') {
      return true;
    } else {
      return false;
    }
  }

  initSelectedGender() {
    gender = _userController.loggedIn ? _userController.currentUser.gender : 1;
    genders = [
      RadioButtonModel("male".tr, MdiIcons.genderMale, selected(gender, 'male'), 1),
      RadioButtonModel("female".tr, MdiIcons.genderFemale, selected(gender, 'female'), 2),
      RadioButtonModel("others".tr, MdiIcons.genderTransgender,
          selected(gender, 'others'), 3)
    ];
    update();
  }

  selectGender(index) {
    genders.forEach((gender) => gender.isSelected = false);
    genders[index].isSelected = true;
    gender = genders[index].genderNum;

    print(genders[index].genderNum);
    update();
  }
}
