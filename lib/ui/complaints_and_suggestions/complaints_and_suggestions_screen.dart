import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../common_widgets/custom_text.dart';
import '../../controllers/timer_controller.dart';
import '../../ui/user_profile/widgets/gender_radio.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../common_widgets/phone_widget.dart';
import '../../controllers/edit_profile_cotroller.dart';
import '../../controllers/phone_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../helpers/validators.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../services/api_calls/user_api_calls.dart';

class ComplaintsAndSuggestionsScreen extends StatefulWidget {
  @override
  _ComplaintsAndSuggestionsScreenState createState() =>
      _ComplaintsAndSuggestionsScreenState();
}

class _ComplaintsAndSuggestionsScreenState
    extends State<ComplaintsAndSuggestionsScreen> {
  UserApiCalls _userApiCalls = UserApiCalls.instance;
  GlobalKey<FormState> _formKey = GlobalKey();
  final PhoneController _phoneController = Get.put(PhoneController());
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final TimerController _timerCon = Get.put(TimerController());
  bool suggestionSelected = true;
  String name;
  String content;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return GetBuilder<EditProfileController>(
        init: Get.put(EditProfileController()),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text(
              'complaints_and_suggestions'.tr,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: _settingsCon.color1,
          ),
          body: SingleChildScrollView(
            child: Obx(
              ()=> Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    if (_timerCon.timerStarted.value)
                      Obx(() => Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: CustomText(
                            text: 'you_can_resend_after'.tr +
                                '  ${_timerCon.secCounter}  '),
                      )),
                    AbsorbPointer(
                      absorbing: _timerCon.timerStarted.value,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            CustomTextField(
                                onSaved: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                                keyboardType: TextInputType.name,
                                label: "name".tr,
                                validator: (val) => fnLnValidator(val)),
                            const SizedBox(height: 20),
                            Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: PhoneWidget()),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      suggestionSelected = !suggestionSelected;
                                    });
                                  },
                                  child: RadioButtonWithIcon(
                                    RadioButtonModel(
                                        "suggestion".tr,
                                        Icons.edit_outlined,
                                        suggestionSelected,
                                        1),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      suggestionSelected = !suggestionSelected;
                                    });
                                  },
                                  child: RadioButtonWithIcon(
                                    RadioButtonModel(
                                        "complaint".tr,
                                        Icons.error_outline,
                                        !suggestionSelected,
                                        2),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                                onSaved: (val) {
                                  setState(() {
                                    content = val;
                                  });
                                },
                                maxLines: 5,
                                label: suggestionSelected
                                    ? "enter_suggestion".tr
                                    : "enter_complaint".tr,
                                keyboardType: TextInputType.multiline,
                                validator: (val) =>
                                    multiLineTextValidator(val)),
                            const SizedBox(height: 20),
                            CommonButton(
                              text: 'submit'.tr,
                              containerColor: _timerCon.timerStarted.value
                                  ? Colors.grey
                                  : _settingsCon.color1,
                              width: 150,
                              height: 50,
                              corners: Corners(10, 10, 10, 10),
                              onTap: () {
                                _formKey.currentState.save();
                                if (_phoneController.confirmedNumber == null) {
                                  _phoneController.setErrMsg();
                                }
                                if (_formKey.currentState.validate() &&
                                    _phoneController.confirmedNumber != null) {
                                  _userApiCalls.contactUsInsert(
                                      name: name,
                                      phone: _phoneController.confirmedNumber,
                                      type: suggestionSelected ? '1' : '2',
                                      content: content);
                                  _timerCon.startTimer();
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
