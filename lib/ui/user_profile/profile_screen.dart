import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../common_widgets/devider_row.dart';
import '../../common_widgets/phone_widget.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../controllers/edit_profile_cotroller.dart';
import '../../controllers/gender_controller.dart';
import '../../controllers/phone_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/hex_color.dart';
import '../../helpers/validators.dart';
import '../../models/user.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../services/api_calls/user_api_calls.dart';
import '../../ui/account/user_images_screen.dart';
import '../../ui/user_profile/widgets/gender_radio.dart';
import '../../services/api_calls/phone_auth_services.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> _profileFormKey = GlobalKey();
  GlobalKey<FormState> _passwordFormKey = GlobalKey();
  final PhoneController _phoneController = Get.put(PhoneController());
  final GenderController _genderController = Get.put(GenderController());
  final SettingsController _settingsCon = Get.find<SettingsController>();

  UserApiCalls _userApiCalls = UserApiCalls.instance;
  String firstName;
  String lastName;
  String email;
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  @override
  Widget build(BuildContext context) {

    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++{${_phoneController.confirmedNumber}}");
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return GetBuilder<EditProfileController>(
        init: Get.put(EditProfileController()),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text(
              "profile".tr,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: _settingsCon.color1,
          ),
          body: SingleChildScrollView(
            child: GetBuilder<UserController>(builder: (userController) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Form(
                      key: _profileFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 32),
                          Center(
                            child: CommonButton(
                              text: controller.editMood.value == false
                                  ? 'edit_profile'.tr
                                  : 'save_edit'.tr,
                              containerColor: controller.editMood.value
                                  ? _settingsCon.color1
                                  : HexColor('FF3B4257'),
                              width: 150,
                              height: 50,
                              corners: Corners(10, 10, 10, 10),
                              onTap: () async {
                                controller.toggle();
                                if (!controller.editMood.value) {
                                  _profileFormKey.currentState.save();
                                  if (_profileFormKey.currentState
                                      .validate()) {
                                    User user = User(
                                      id: userController.currentUser.id,
                                      lastName: lastName ??
                                          userController
                                              .currentUser.lastName,
                                      firstName: firstName ??
                                          userController
                                              .currentUser.firstName,
                                      languageId: userController
                                          .currentUser.languageId ??
                                          1,
                                      status: userController
                                          .currentUser.status,
                                      role:
                                      userController.currentUser.role,
                                      email: email ??
                                          userController
                                              .currentUser.email,
                                      gender: _genderController.gender ??
                                          userController
                                              .currentUser.gender,
                                      phone: _phoneController
                                          .confirmedNumber ??
                                          userController
                                              .currentUser.phone,
                                      phoneVerified: userController
                                          .currentUser.phoneVerified,
                                      updatedBy:
                                      userController.currentUser.id,
                                    );

                                    User userFromJson =
                                    await _userApiCalls
                                        .updateProfile(user);
                                    if (userFromJson != null) {
                                      userFromJson.password =
                                          userController
                                              .currentUser.password;
                                      userController
                                          .updateUserData(userFromJson);
                                    }
                                  } else {
                                    controller.toggle();
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              print('tapped');
                              if (!controller.editMood.value) {
                                showSnack('click_edit_profile_first'.tr);
                              }
                            },
                            child: AbsorbPointer(
                                absorbing: !controller.editMood.value,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                        onSaved: (val) {
                                          setState(() {
                                            firstName = val;
                                          });
                                        },
                                        keyboardType: TextInputType.name,
                                        initVal: userController
                                            .currentUser.firstName,
                                        label: "first_name".tr,
                                        validator: (val) => fnLnValidator(val)),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                        onSaved: (val) {
                                          setState(() {
                                            lastName = val;
                                          });
                                        },
                                        keyboardType: TextInputType.name,
                                        initVal:
                                            userController.currentUser.lastName,
                                        label: "last_name".tr,
                                        validator: (val) => fnLnValidator(val)),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                        onSaved: (val) {
                                          setState(() {
                                            email = val;
                                          });
                                        },
                                        initVal:
                                            userController.currentUser.email,
                                        label: "email".tr,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) =>
                                            emailValidator(val)),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: PhoneWidget(
                                                initPhone: userController
                                                    .currentUser.phone,
                                              )),
                                        ),
                                        if (_settingsCon.phoneAuthRequired &&
                                            userController.currentUser
                                                    .phoneVerified ==
                                                0)
                                          SizedBox(width: 10),
                                        GetBuilder<UserController>(
                                            init: Get.find(),
                                            builder: (userCon) {
                                              return _settingsCon
                                                          .phoneAuthRequired &&
                                                      userCon.currentUser
                                                              .phoneVerified ==
                                                          0
                                                  ? Expanded(
                                                      child: CommonButton(
                                                        text: 'verify'.tr,
                                                        fontSize: 17,
                                                        containerColor:
                                                            _settingsCon.color2,
                                                        height: 70,
                                                        corners: Corners(
                                                            10, 10, 10, 10),
                                                        onTap: () async {
                                                          PhoneAuthServices
                                                              _auth =
                                                              PhoneAuthServices
                                                                  .instance;
                                                          await _auth.verifyPhoneNumber(
                                                              number: _phoneController
                                                                          .confirmedNumber !=
                                                                      null
                                                                  ? _phoneController
                                                                      .confirmedNumber
                                                                  : userController
                                                                      .currentUser
                                                                      .phone);
                                                        },
                                                      ),
                                                    )
                                                  : SizedBox();
                                            })
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text("choose_gender".tr),
                                    ),
                                    Center(
                                      child: AbsorbPointer(
                                        absorbing: !controller.editMood.value,
                                        child: Container(
                                          height: 90,
                                          child: GetBuilder<GenderController>(
                                              init: Get.put(GenderController()),
                                              builder: (genderController) {
                                                return ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: genderController
                                                        .genders.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.pinkAccent,
                                                        onTap: () =>
                                                            genderController
                                                                .selectGender(
                                                                    index),
                                                        child: RadioButtonWithIcon(
                                                            genderController
                                                                    .genders[
                                                                index]),
                                                      );
                                                    });
                                              }),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (!controller.passwordEditMood.value) {
                          showSnack('click_edit_password_first'.tr);
                        }
                      },
                      child: Form(
                        key: _passwordFormKey,
                        child: AbsorbPointer(
                          absorbing: !controller.passwordEditMood.value,
                          child: Column(
                            children: [
                              DividerRow('change_password'.tr),
                              const SizedBox(height: 30),
                              CustomTextField(
                                onSaved: (val) {
                                  setState(() {
                                    oldPassword = val;
                                  });
                                },
                                label: "old_password".tr,
                                validator: (val) => passwordValidator(val),
                                keyboardType: TextInputType.visiblePassword,
                                isPassword: true,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                onSaved: (val) {
                                  setState(() {
                                    newPassword = val;
                                  });
                                },
                                label: "new_password".tr,
                                isPassword: true,
                                validator: (val) => passwordValidator(val),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                onSaved: (val) {
                                  setState(() {
                                    confirmNewPassword = val;
                                  });
                                },
                                isPassword: true,
                                label: "confirm_new_password".tr,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (val) =>
                                    confirmPasswordValidator(val, newPassword),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: CommonButton(
                        text: controller.passwordEditMood.value == false
                            ? 'change_password'.tr
                            : 'save_new_password'.tr,
                        containerColor: controller.passwordEditMood.value
                            ? _settingsCon.color1
                            : HexColor('FF3B4257'),
                        width: 150,
                        height: 50,
                        corners: Corners(10, 10, 10, 10),
                        onTap: () async {
                          controller.togglePasswordEditMode();

                          if (!controller.passwordEditMood.value) {
                            _passwordFormKey.currentState.save();

                            if (_passwordFormKey.currentState.validate()) {
                              final bool success =
                                  await _userApiCalls.resetPassword(
                                      oldPassword: oldPassword,
                                      newPassword: newPassword,
                                      userId: userController.currentUser.id);
                              if (success) {
                                userController.updatePassword(newPassword);
                                userController.getUserData();
                              }
                            } else {
                              controller.togglePasswordEditMode();
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    DividerRow('pick_your_images'.tr),
                    const SizedBox(height: 30),
                    Center(
                      child: CommonButton(
                        text: 'select_images'.tr,
                        containerColor: _settingsCon.color2,
                        width: 150,
                        height: 50,
                        corners: Corners(10, 10, 10, 10),
                        onTap: () {
                          Get.to(() => UserImagesScreen());
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
