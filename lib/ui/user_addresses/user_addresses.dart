import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/location_controller.dart';
import '../../common_widgets/empty_view.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/custom_text.dart';
import '../../common_widgets/loading_view.dart';
import '../../consts/colors.dart';
import '../../controllers/adresses_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../ui/check_out/check_out_screen.dart';
import '../../ui/user_addresses/map_screen.dart';
import '../../ui/user_addresses/widgets/address_row.dart';

class UserAddressesScreen extends StatelessWidget {
  final bool isInOrderMood;

  UserAddressesScreen({this.isInOrderMood = false});

  final CartController cartController = Get.find<CartController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressesController>(
      init: Get.put<AddressesController>(AddressesController()),
      builder: (controller) => Scaffold(
        backgroundColor: APP_BG_COLOR,
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              bottom: isInOrderMood && controller.addressesData.isNotEmpty
                  ? 50.0
                  : 0),
          child: Container(
            width: 150,
            height: 40,
            child: FloatingActionButton(
              backgroundColor: _settingsCon.color2,
              onPressed: () {
                controller.clearSelectedAddress();
                checkForLocationPermission();
              },
              isExtended: true,
              child: FittedBox(child: CustomText(text: 'add_new_address'.tr)),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            'my_addresses'.tr,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: _settingsCon.color1,
        ),
        body: ResponsiveBuilder(builder: (context, sizingInfo) {
          return controller.isLoading.value
              ? LoadingView()
              : controller.addressesData.isEmpty
                  ? EmptyView(text: 'no_addresses_added_yet'.tr)
                  : Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: 'select_your_shipping_address'.tr,
                              size: 17,
                              weight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 100),
                                itemCount: controller.addressesData.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      controller.selectAddress(index);
                                    },
                                    child: AddressRow(
                                      index: index,
                                      cost: controller.addressesData[index].cost
                                          .toString(),
                                      addressName: controller
                                          .addressesData[index].address,
                                      area: controller
                                          .addressesData[index].areaNameEn,
                                      addressModel:
                                          controller.addressesData[index],
                                    ),
                                  );
                                }),
                          ),
                          if (isInOrderMood)
                            CommonButton(
                                width: sizingInfo.screenWidth,
                                height: 45,
                                containerColor: _settingsCon.color2,
                                text: 'continue_to_check_out'.tr,
                                fontSize: 17,
                                onTap: () {
                                  Get.to(() => CheckOutScreen());
                                })
                        ],
                      ),
                    );
        }),
      ),
    );
  }

  checkForLocationPermission() {
    LocationController _locationCon = Get.find<LocationController>();
    if (_locationCon.userLocation == null) {
      showTwoButtonsDialog(
          barrierDismissible: false,
          title: 'you_must_give_location_permission'.tr,
          msg: 'we_need_your_location_to_add_it_to_your_shipping_address'.tr,
          okText: 'give_location'.tr,
          onOkTapped: () async {
            await _locationCon.getUserLocation();
            if (_locationCon.userLocation != null) {
              Get.back();
              Get.to(MapScreen());
            }
          });
    } else {
      Get.to(MapScreen());
    }
  }

}
