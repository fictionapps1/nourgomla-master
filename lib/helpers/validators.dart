import 'package:get/get.dart';
final validCharactersEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

// final validCharacters = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
String emailValidator(String val) {
  if (val == null || val == '') {
    return "required_field".tr;
  }
  if (!val.contains(validCharactersEmail)) {
    return "Email not valid";
  }
  if (val.length > 100) {
    return "must_be_less_than_100_letters".tr;
  }
  return null;
}

String fnLnValidator(String val) {
  if (val == null || val == '') {
    return "required_field".tr;
  }
  // if (!val.contains(validCharacters)) {
  //   return "Enter Letters only";
  // }
  if (val.length > 50) {
    return "must_be_less_than_50_letters".tr;
  }
  return null;
}

String multiLineTextValidator(String val) {
  if (val == null || val == '') {
    return "required_field".tr;
  }
  // if (val.contains(validCharacters)) {
  //   return "Enter Letters only";
  // }
  if (val.length > 200) {
    return "must_be_less_than_200_letters".tr;
  }
  return null;
}

String passwordValidator(String val) {
  if (val == null || val == '') {
    return "required_field".tr;
  }
  if (val.length < 6) {
    return "password_must_be_more_than_5_letters".tr;
  }
  if (val.length > 50) {
    return "must_be_less_than_50_letters".tr;
  }
  return null;
}

String confirmPasswordValidator(String val, String password) {
  print(val);
  print(password);
  if (val == null || val == '') {
    return "required_field".tr;
  }
  if (val != password) {
    return "password_doesnt_match".tr;
  }
  return null;
}
