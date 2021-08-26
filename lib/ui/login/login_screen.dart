import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../common_widgets/phone_widget.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../consts/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/phone_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/validators.dart';
import '../../models/user.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../services/api_calls/user_api_calls.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserApiCalls _userApiCalls = UserApiCalls.instance;
  final PhoneController _phoneController = Get.put(PhoneController());
  final SettingsController _settingsCon = Get.find<SettingsController>();

  String password;

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_COLOR,
      appBar: AppBar(
        backgroundColor: _settingsCon.color1,
        title: Text('log_in'.tr,style: TextStyle(color: Colors.black),),
      ),
      body: ResponsiveBuilder(builder: (context, sizingInfo) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: PhoneWidget()),
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
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "forget_password".tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  Text(
                                    '  ' + "press_here".tr + '  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 40),
                              GetBuilder<UserController>(
                                  init: Get.find(),
                                  builder: (con) {
                                    return GetBuilder<CartController>(
                                        init: Get.find(),
                                        builder: (cartController) {
                                          return CommonButton(
                                            text: 'log_in'.tr,
                                            onTap: () async {
                                              _formKey.currentState.save();
                                              if (_phoneController
                                                      .confirmedNumber ==
                                                  null) {
                                                _phoneController.setErrMsg();
                                              }
                                              if (_formKey.currentState
                                                      .validate() &&
                                                  _phoneController
                                                          .confirmedNumber !=
                                                      null) {
                                                User user = await _userApiCalls
                                                    .userLogin(
                                                        _phoneController
                                                            .confirmedNumber,
                                                        password);
                                                if (user != null) {

                                                  user.password=password;
                                                  con.setUserData(user);
                                                  con.getUserData();
                                                }
                                              }
                                            },
                                            corners: Corners(40, 40, 40, 40),
                                            width: 200,
                                            height: 45,
                                            fontSize: 20,
                                            containerColor: _settingsCon.color2,
                                          );
                                        });
                                  }),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
