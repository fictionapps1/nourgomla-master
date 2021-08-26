
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nourgomla/controllers/fcm_controller.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../common_widgets/phone_widget.dart';
import '../../common_widgets/corners.dart';
import '../../consts/colors.dart';
import '../../controllers/gender_controller.dart';
import '../../controllers/phone_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/validators.dart';
import '../../models/user.dart';
import '../../services/api_calls/user_api_calls.dart';
import '../../ui/user_profile/widgets/gender_radio.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserApiCalls _userApiCalls = UserApiCalls.instance;
  final PhoneController _phoneController = Get.put(PhoneController());
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final GenderController _genderController = Get.put(GenderController());

  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmNewPassword;

  @override
  Widget build(BuildContext context) {
    final con = Get.put(UserController());
    return Scaffold(
      backgroundColor: APP_BG_COLOR,
      appBar: AppBar(
        title: Text('sign_up'.tr, style: TextStyle(color: Colors.black)),
        backgroundColor: _settingsCon.color1,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        onSaved: (val) {
                          setState(() {
                            firstName = val;
                          });
                        },
                        keyboardType: TextInputType.name,
                        label: "first_name".tr,
                        validator: (val) => fnLnValidator(val),
                        autoFocus: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                          onSaved: (val) {
                            setState(() {
                              lastName = val;
                            });
                          },
                          keyboardType: TextInputType.name,
                          label: "last_name".tr,
                          validator: (val) => fnLnValidator(val)),
                      const SizedBox(height: 20),
                      CustomTextField(
                          onSaved: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          label: "email".tr,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => emailValidator(val)),
                      const SizedBox(height: 20),
                      PhoneWidget(),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("choose_gender".tr),
                      ),
                      Center(
                        child: Container(
                          height: 90,
                          child: GetBuilder<GenderController>(
                              init: _genderController,
                              builder: (genderController) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: genderController.genders.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        splashColor: Colors.pinkAccent,
                                        onTap: () => genderController
                                            .selectGender(index),
                                        child: RadioButtonWithIcon(
                                            genderController.genders[index]),
                                      );
                                    });
                              }),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        onSaved: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        label: "password".tr,
                        validator: (val) => passwordValidator(val),
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        onSaved: (val) {
                          setState(() {
                            confirmNewPassword = val;
                          });
                        },
                        label: "confirm_password".tr,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) =>
                            confirmPasswordValidator(val, password),
                        isPassword: true,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: CommonButton(
                          text: 'sign_up'.tr,
                          onTap: () async {
                            _formKey.currentState.save();
                            if (_phoneController.confirmedNumber == null) {
                              _phoneController.setErrMsg();
                            }
                            if (_formKey.currentState.validate() &&
                                _phoneController.confirmedNumber != null) {
                              User user = User(
                                firstName: firstName,
                                lastName: lastName,
                                gender: _genderController.gender,
                                phone: _phoneController.confirmedNumber,
                                email: email,
                                password: password,
                                languageId: 1,
                                fcmToken: Get.find<FcmController>().token,
                              );

                              User userData =
                              await _userApiCalls.userSignUp(user);
                              if (userData != null) {
                                userData.password = password;
                                con.setUserData(userData);
                                con.getUserData();
                              }
                            }
                          },
                          corners: Corners(40, 40, 40, 40),
                          width: 200,
                          height: 50,
                          fontSize: 18,
                          containerColor: _settingsCon.color2,
                        ),
                      ),
                      SizedBox(height: 50)
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
