import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'custom_text.dart';
import '../consts/user_profile_consts.dart';
import 'package:get/get.dart';
import '../controllers/phone_controller.dart';

class PhoneWidget extends StatelessWidget {
  final String initPhone;

  PhoneWidget({this.initPhone});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneController>(
        init: Get.put(PhoneController()),
        builder: (con) {
          return Column(
            children: [
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: .5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InternationalPhoneInput(
                  decoration: InputDecoration.collapsed(
                    hintText: 'phone'.tr,
                  ),
                  onPhoneNumberChange: con.onPhoneNumberChange,
                  initialSelection: con.phoneIsoCode,
                  showCountryCodes: false,
                  showCountryFlags: true,
                  initialPhoneNumber: initPhone,
                  enabledCountries: enabledCountryCodes,
                ),
              ),
              if (con.phoneErrMsg != null)
                CustomText(
                  text: con.phoneErrMsg,
                  size: 14,
                  color: Colors.red,
                ),
            ],
          );
        });
  }
}
