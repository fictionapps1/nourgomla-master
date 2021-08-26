import 'package:get/get.dart';
import '../common_widgets/dialogs_and_snacks.dart';

import '../models/user.dart';
import '../services/local_storage/user_db.dart';

class UserController extends GetxController {
  User currentUser = User();
  bool loggedIn = false;
  bool showSurvey = false;
  int get userRole => currentUser != null ? currentUser.role : 1;
  String get userId => currentUser != null ? currentUser.id.toString() : '';

  setUserData(User user) {
    var dbHelper = UserDbHelper.db;
    dbHelper.insertUserData(user);
    currentUser = user;
    if (user.id != null) {
      loggedIn = true;
    }
    update();
    print("CURRENT USER ID=============>  ${currentUser.id}");
  }

  updateUserData(User user) {
    var dbHelper = UserDbHelper.db;
    dbHelper.updateUserData(user);
    currentUser = user;
    if (user.id != null) {
      loggedIn = true;
    }
    update();
    print("CURRENT USER ID=============>  ${currentUser.id}");
  }

  updatePassword(String password) {
    var dbHelper = UserDbHelper.db;
    dbHelper.updatePassword(currentUser.id.toString(), password);
    dbHelper.getUserData();
    update();
    print("CURRENT USER ID=============>  ${currentUser.password}");
  }

  Future<User> getUserData() async {
    var dbHelper = UserDbHelper.db;
    currentUser = await dbHelper.getUserData();

    if (currentUser.id != null) {
      loggedIn = true;
    }
    update();
    print(
        "CURRENT USER Get================================================>  ${currentUser.toJson()}");
    return currentUser;
  }

  logOut() async {
    var dbHelper = UserDbHelper.db;
    currentUser = await dbHelper.deleteUserData(currentUser);
    loggedIn = false;

    print("CURRENT USER =============>  $currentUser");

    showSnack('logged_out_successfully'.tr);
    update();
  }
}
