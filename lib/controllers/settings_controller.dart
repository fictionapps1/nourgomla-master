import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../controllers/vendors_section_controller.dart';
import '../models/settings_model.dart';
import '../services/api_calls/settings_services.dart';
import 'categories_controller.dart';

class SettingsController extends GetxController {
  SettingsServices _homeServices = SettingsServices.instance;
  Settings settingsData;

  HexColor get color1 => hasValue(settingsData.color1)
      ? HexColor(settingsData.color1)
      : HexColor('FFFF9800');
  HexColor get color2 => hasValue(settingsData.color2)
      ? HexColor(settingsData.color2)
      : HexColor('FFFF9800');
  HexColor get color3 => hasValue(settingsData.color3)
      ? HexColor(settingsData.color3)
      : HexColor('FFFF9800');
  HexColor get color4 => hasValue(settingsData.color4)
      ? HexColor(settingsData.color4)
      : HexColor('FFFF9800');
  HexColor get color5 => hasValue(settingsData.color5)
      ? HexColor(settingsData.color5)
      : HexColor('FFFF9800');
  HexColor get color6 => hasValue(settingsData.color6)
      ? HexColor(settingsData.color6)
      : HexColor('FFFF9800');
  HexColor get color7 => hasValue(settingsData.color7)
      ? HexColor(settingsData.color7)
      : HexColor('FFFF9800');
  HexColor get color8 => hasValue(settingsData.color8)
      ? HexColor(settingsData.color8)
      : HexColor('FFFF9800');
  HexColor get color9 => hasValue(settingsData.color9)
      ? HexColor(settingsData.color9)
      : HexColor('FFFF9800');
  HexColor get color10 => hasValue(settingsData.color10)
      ? HexColor(settingsData.color10)
      : HexColor('FFFF9800');

  HexColor get loadingIconColor => hasValue(settingsData.loadingIconColor)
      ? HexColor(settingsData.loadingIconColor)
      : HexColor('FFFF9800');

  String get loadingIcon => hasValue(settingsData.loadingIcon)
      ? settingsData.loadingIcon
      : 'RotatingPlain';

  String get productBuilderType => hasValue(settingsData.productBuilderType)
      ? settingsData.productBuilderType
      : '1';

  bool get pointsEnabled => hasValue(settingsData.pointsEnabled)
      ? isEnabled(settingsData.pointsEnabled)
      : false;

  bool get activationRequired => hasValue(settingsData.activationRequired)
      ? isEnabled(settingsData.activationRequired)
      : false;

  bool get uploadImageRequired => hasValue(settingsData.uploadImageRequired)
      ? isEnabled(settingsData.uploadImageRequired)
      : false;

  bool get phoneAuthRequired => hasValue(settingsData.phoneAuthRequired)
      ? isEnabled(settingsData.phoneAuthRequired)
      : false;

  bool get filter1barEnabled => hasValue(settingsData.filter1Bar)
      ? isEnabled(settingsData.filter1Bar)
      : false;

  bool get filter2barEnabled => hasValue(settingsData.filter2Bar)
      ? isEnabled(settingsData.filter2Bar)
      : false;

  bool get filter3barEnabled => hasValue(settingsData.filter3Bar)
      ? isEnabled(settingsData.filter3Bar)
      : false;

  bool get filter1pageEnabled => hasValue(settingsData.filter1Page)
      ? isEnabled(settingsData.filter1Page)
      : false;

  bool get filter2pageEnabled => hasValue(settingsData.filter2Page)
      ? isEnabled(settingsData.filter2Page)
      : false;

  bool get filter3pageEnabled => hasValue(settingsData.filter3Page)
      ? isEnabled(settingsData.filter3Page)
      : false;

  bool get reviewEnabled => hasValue(settingsData.reviewEnabled)
      ? isEnabled(settingsData.reviewEnabled)
      : false;

  bool get isMultiVendor => hasValue(settingsData.multiVendor)
      ? isEnabled(settingsData.multiVendor)
      : false;

  bool get forceUpdate => hasValue(settingsData.forceUpdate)
      ? isEnabled(settingsData.forceUpdate)
      : false;

  String get billProductWidget => hasValue(settingsData.billProductWidget)
      ? settingsData.billProductWidget
      : '1';

  int get availablePackaging =>
      hasValue(settingsData.availablePackaging.toString())
          ? settingsData.availablePackaging
          : 3;
  int get version =>
      hasValue(settingsData.version.toString()) ? settingsData.version : 1;

  AnimationController animationController(TickerProvider ticker) =>
      AnimationController(
          duration: Duration(milliseconds: 1000), vsync: ticker);

  Animation<double> animation(AnimationController controller) =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval((1 / 4) * 2, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );

  bool hasValue(String value) =>
      settingsData != null && value != null && value != '';

  bool isEnabled(String val) => val == 'true' ? true : false;

  @override
  onInit() async {
    await getHomeData();
    if (isMultiVendor) {
      Get.put(VendorsSectionController());
    } else {
      Get.put(CategoriesController());
    }
    super.onInit();
  }

  getHomeData() async {
    settingsData = await _homeServices.getAppSettings();
    update();
  }
}
