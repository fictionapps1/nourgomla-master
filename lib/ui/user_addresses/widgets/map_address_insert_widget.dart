import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../config/api_links.dart';
import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/corners.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/adresses_controller.dart';
import '../../../controllers/settings_controller.dart';
import '../../../external_packages/place_picker/src/models/pick_result.dart';
import '../../../helpers/validators.dart';
import '../../../responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';

class AddressInsertWidget extends StatefulWidget {
  final PickResult selectedPlace;

  AddressInsertWidget({this.selectedPlace});

  @override
  _AddressInsertWidgetState createState() => _AddressInsertWidgetState();
}

class _AddressInsertWidgetState extends State<AddressInsertWidget> {
  final formKey = GlobalKey<FormState>();
  final addressesController = Get.find<AddressesController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      final width = sizingInfo.screenWidth;
      final height = sizingInfo.screenHeight;
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          height: height / 3.3,
          width: width * .95,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: widget.selectedPlace != null
                      ? widget.selectedPlace.formattedAddress
                      : '',
                  size: 15,
                ),
                Container(
                  height: height / 8,
                  width: width * .85,
                  child: Form(
                    key: formKey,
                    child: CustomTextField(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      validator: (val) => multiLineTextValidator(val),
                      initVal: addressesController.updateMode
                          ? addressesController.addressToUpdate.address
                          : "",
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      label: "write_your_full_address".tr,
                      onSaved: (value) {
                        print(value);
                        addressesController.writtenAddress = value;
                      },
                    ),
                  ),
                ),
                CommonButton(
                  corners: Corners(20, 20, 20, 20),
                  width: 150,
                  height: 40,
                  text: addressesController.updateMode
                      ? 'update_address'.tr
                      : 'confirm_address'.tr,
                  onTap: () async {
                    formKey.currentState.save();
                    if (formKey.currentState.validate()) {
                      addressesController.changeCurrentLatLng(LatLng(
                          widget.selectedPlace.geometry.location.lat,
                          widget.selectedPlace.geometry.location.lng));
                      final int areaId = await _getUserArea();
                      if (areaId != null) {
                        print(
                            'ID ?????????????????????????????????????  $areaId');
                        onSaveAddressPressed(areaId);
                      }
                    }
                  },
                  containerColor: _settingsCon.color2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  onSaveAddressPressed(int areaId) async {
    if (addressesController.updateMode) {
      print(
          'WRITEN ADDRESS TO UPDATE=============> ${addressesController.writtenAddress}');
      addressesController.updateAddress(
        lat: addressesController.currentLatLng.latitude,
        lng: addressesController.currentLatLng.longitude,
        writtenAddress: addressesController.writtenAddress,
        addressId: addressesController.addressToUpdate.id,
        areaId: areaId,
      );
      Get.back();
    } else {
      addressesController.addNewAddress(
        address: addressesController.writtenAddress,
        lat: addressesController.currentLatLng.latitude,
        lng: addressesController.currentLatLng.longitude,
        areaId: areaId,
      );
      Get.back();
    }
  }

  Future<int> _getUserArea() async {
    String adminArea;
    String subAdminArea;
    final coordinates = new Coordinates(
        addressesController.currentLatLng.latitude,
        addressesController.currentLatLng.longitude);
    final locationDetails =
    Geocoder.google(ApiLinks.googleApiKey,language: 'en');

    final addresses=await locationDetails.findAddressesFromCoordinates(coordinates);
    adminArea = addresses[1].adminArea;
    subAdminArea = addresses[1].subAdminArea;
    return await addressesController.getUserAreaId(
        areaName: '$adminArea' '_' '$subAdminArea',
        latLng: addressesController.currentLatLng);
  }
}
