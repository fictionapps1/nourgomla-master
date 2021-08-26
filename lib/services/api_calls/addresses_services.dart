import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/address_model.dart';
import '../../models/area_model.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
import 'package:get/get.dart';

class AddressesServices {
  AddressesServices._internal();
  final UserController _userController = Get.find<UserController>();
  final LanguageController _langController = Get.find<LanguageController>();

  static final AddressesServices _addressesServices =
      AddressesServices._internal();

  static AddressesServices get instance => _addressesServices;

  final APIService _apiService = APIService();

  Future<List<AddressModel>> getUserAddresses() async {
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.usersAddressSelect,
        body: {
          'user_id': _userController.currentUser.id,
        },
      );
      List<dynamic> json = data['data'];
      print("ADDRESSES ==============>  $json");
      if (json.isNotEmpty) {
        return json.map((e) => AddressModel.fromJson(e)).toList();
      }
    } catch (e) {
      showErrorDialog('Error Loading Addresses');
    }
    return null;
  }

  Future<List<AreaModel>> getAreas(String areaName) async {
    List<AreaModel> areas = [];
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.areaSelect,
        body: {
          'area_name': areaName,
        },
      );
      List<dynamic> json = data['data'];
      print('=======================AREAS DATA=====================> $json');
      if (json.isNotEmpty) {
        areas.addAll(json.map((e) => AreaModel.fromJson(e)).toList());
        return areas;
      }
    } catch (e) {
      print('=========================================================> $e');
      showErrorDialog('Error Loading Shipping Data');
      return areas;
    }
    return areas;
  }

  insertArea({String areaName,  String shippingCost,List<Map>polygons} ) async {
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.areaInsert,
        body: {
          'language_id':1,
          'area_name_ar': areaName,
          'area_name_en': areaName,
          'area_shipping': shippingCost,
          'area_latitude': '',
          'area_longitude': '',
          'radius':jsonEncode(polygons),
        },
      );
      print('==========================================> $data');
      if(data!=null&&data['message']!=null){
        showNormalDialog(title:data['message'],msg: '');
      }
    } catch (e) {
      print('=========================================================> $e');
      showErrorDialog('Error Insert Area Data');
    }
  }

  deleteAddress({@required int addressId}) async {
    try {
      await _apiService.postData(
        endpoint: Endpoints.usersAddressDelete,
        body: {
          'user_id': _userController.currentUser.id,
          'address_id': addressId,
          'language_id': _langController.langId(),
        },
      );
    } catch (e) {
      showErrorDialog('Error Deleting Address');
    }
  }

  Future addNewAddress({
    @required String address,
    @required double latitude,
    @required double longitude,
    @required int areaId,
    int userId,
  }) async {
    // print('LANG ID FROM USER DATA======> ${_userController.currentUser.languageId}');
    // print('LANG ID FROM LANGUAGE CONTROLLER ======> ${_langController.langId()}');
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.addressInsert,
        body: {
          'user_id': _userController.currentUser.id,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
          'area_id': areaId,
          'language_id': _langController.langId(),
        },
      );

      print("Data=============>  $data");
    } catch (e) {
      showErrorDialog('Error Adding Address');
    }
  }

  Future updateAddress({
    @required String address,
    @required double latitude,
    @required double longitude,
    @required int areaId,
    @required int addressId,
    int userId,
  }) async {
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.usersAddressUpdate,
        body: {
          'user_id': _userController.currentUser.id,
          'address': address,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'area_id': areaId,
          'language_id': _langController.langId(),
          'id': addressId
        },
      );

      print("Data=============>  $data");
    } catch (e) {
      showErrorDialog('Error Updating Address');
    }
  }
}
