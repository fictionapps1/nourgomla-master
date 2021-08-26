import 'package:get/get.dart';

class EditProfileController extends GetxController {
  RxBool editMood = false.obs;
  RxBool uploading = false.obs;
  RxBool passwordEditMood = false.obs;

  void toggle() {
    editMood.value = !editMood.value;

    update();
  }

  void togglePasswordEditMode() {
    passwordEditMood.value = !passwordEditMood.value;
    update();
  }
}
