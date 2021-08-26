import 'package:flutter/cupertino.dart';
import 'package:geodesy/geodesy.dart' as geo;
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/address_model.dart';
import '../models/location_model.dart';
import '../models/area_model.dart';
import '../services/api_calls/addresses_services.dart';

class AddressesController extends GetxController {
  LatLng currentLatLng;
  AddressesServices _addressesServices = AddressesServices.instance;
  // RxString queryName = ''.obs;
  List<AreaModel> shippingData = [];
  List<AreaModel> filteredShippingData = [];
  List<AddressModel> addressesData = [];
  AddressModel selectedAddress;
  AddressModel addressToUpdate;
  LocationModel locationData;
  bool updateMode = false;
  String writtenAddress;
  RxBool isLoading = false.obs;

  @override
  onInit() async {
    await getUserAddresses();
    // debounce(queryName, (val) {
    //   filterShippingData();
    // }, time: Duration(milliseconds: 50));
    super.onInit();
  }



  // filterShippingData() {
  //   filteredShippingData.clear();
  //   shippingData.forEach((shippingModel) {
  //     if (shippingModel.areaNameEn.toLowerCase().contains(queryName) ||
  //         shippingModel.areaNameEn.contains(queryName)) {
  //       filteredShippingData.add(shippingModel);
  //     }
  //   });
  //   update();
  // }

  getUserAddresses() async {
    isLoading.value = true;
    final data = await _addressesServices.getUserAddresses();
    if (data != null && data.isNotEmpty) {
      addressesData.assignAll(data);
      print('ADDRESSES=================================> $addressesData');
      selectAddress(0);
    }

    isLoading.value = false;
    update();
  }

  Future<int> getUserAreaId({String areaName, LatLng latLng}) async {
    int areaId;
    shippingData = await _addressesServices.getAreas(areaName);
    final geo.Geodesy geodesy = geo.Geodesy();

    for (int i = 0; i < shippingData.length; i++) {
      if (shippingData[i].polygon.isNotEmpty) {
        bool isGeoPointInPolygon = geodesy.isGeoPointInPolygon(
            geo.LatLng(latLng.latitude, latLng.longitude),
            shippingData[i].polygon);
        if (isGeoPointInPolygon) {
          print(
              'AREA MATCH============================================> ID =${shippingData[i].id}');
          areaId = shippingData[i].id;
          break;
        }
      }
    }

    return areaId == null ? shippingData[0].id : areaId;
  }



  addNewAddress({
    @required String address,
    @required double lat,
    @required double lng,
    @required int areaId,
  }) async {
    await _addressesServices.addNewAddress(
      // address: locationData.stringAddress(),
      address: address,
      latitude: lat,
      longitude: lng,
      areaId: areaId,
    );
    getUserAddresses();
  }

  updateAddress({
    @required String writtenAddress,
    @required int addressId,
    @required int areaId,
    @required double lat,
    @required double lng,
  }) async {
    await _addressesServices.updateAddress(
        // address: locationData.stringAddress(),
        address: writtenAddress,
        latitude: lat,
        longitude: lng,
        areaId: areaId,
        addressId: addressId);
    getUserAddresses();
    update();
  }

  deleteAddress({int addressId}) async {
    addressesData.clear();    await _addressesServices.deleteAddress(addressId: addressId);
    getUserAddresses();
    update();
  }

  switchToUpdateMode({AddressModel address}) {
    updateMode = true;
    addressToUpdate = address;
    writtenAddress = address.address;
    // selectedArea = AreaModel(
    //     areaNameEn: address.areaNameEn,
    //     cost: address.cost,
    //     id: shippingData[index].id);
    update();
  }

  clearSelectedAddress() {
    updateMode = false;
    writtenAddress = null;
    update();
  }

  selectAddress(int index) {
    if (addressesData != null) {
      addressesData.forEach((address) {
        address.selected = false;
      });
      addressesData[index].selected = true;
      selectedAddress = addressesData[index];
      print("ADDRESS DATA NAME EN======================================>> ${selectedAddress.areaNameEn}");
      print("ADDRESS DATA NAME AR======================================>> ${selectedAddress.areaNameAr}");
      update();
    }
  }

  changeCurrentLatLng(LatLng latLng) {
    currentLatLng = latLng;
    update();
  }
}
