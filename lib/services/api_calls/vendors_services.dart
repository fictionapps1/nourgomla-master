import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/vendor_area.dart';
import '../../controllers/location_controller.dart';
import '../../models/category.dart';
import '../../models/vendor_category.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';

class VendorsServices {
  VendorsServices._internal();
  static final VendorsServices _vendorsServices = VendorsServices._internal();
  static VendorsServices get instance => _vendorsServices;

  final APIService _apiService = APIService();

  Future<Map<String, dynamic>> getVendors({
    @required int itemsPerPage,
    @required int startIndex,
    @required String vendorCategoryId,
    String searchName,
  }) async {
    Map<String, dynamic> vendorData = {};
    try {
      LocationController locationCon = Get.find<LocationController>();
      final response =
          await _apiService.postData(endpoint: Endpoints.vendorsSelect, body: {
        'itemsPerPage': itemsPerPage,
        'startIndex': startIndex,
        'vendor_category_id': vendorCategoryId,
        'name': searchName ?? '',
        'area_name': locationCon.chosenArea != null
            ? locationCon.chosenArea.keyArea
            : locationCon.userLocation != null
                ? locationCon.userLocation.adminArea +
                    '_' +
                    locationCon.userLocation.subAdminArea
                : '',
      });

      print('Vendor Data =======> $response');
      print('area_name =======> ${locationCon.userLocation.adminArea}');
      final List data = response['data'];
      vendorData['vendor_data'] =
          data.map((e) => VendorCategory.fromJson(e)).toList();
      vendorData['total_count'] = response['totalCount'];

      return vendorData;
    } catch (e) {
      print('================> Error Loading Vendor Data ===============>$e');
      showErrorDialog('Error Loading Vendor Data');
      return vendorData;
    }
  }

  Future<Map<String, dynamic>> getVendorsAreas({
    @required int itemsPerPage,
    @required int startIndex,
    String searchName,
  }) async {
    Map<String, dynamic> vendorsAreasData = {};
    try {
      final response = await _apiService
          .postData(endpoint: Endpoints.vendorsAreasSelect, body: {
        'itemsPerPage': itemsPerPage,
        'startIndex': startIndex,
        'name': searchName ?? '',
      });

      print('searchName =======> $searchName');
      print('VENDORS DATA=======> $response');
      final List data = response['data'];
      vendorsAreasData['vendor_data'] =
          data.map((e) => VendorArea.fromJson(e)).toList();
      vendorsAreasData['total_count'] = response['totalCount'];

      return vendorsAreasData;
    } catch (e) {
      print('================> Error Loading Vendor Data ===============>$e');
      showErrorDialog('Error Loading Vendor Data');
      return vendorsAreasData;
    }
  }

  Future<Map<String, dynamic>> getVendorCategory({
    @required int vendorCategoryId,
  }) async {
    Map<String, dynamic> vendorData = {};
    try {
      final response = await _apiService
          .postData(endpoint: Endpoints.vendorCategoriesSelect, body: {
        'name': '',
        'parent_id': '0',
        'type': '',
        'status': 1,
        'created_by': '',
        'created_at': '',
        'vendor_id': vendorCategoryId,
      });

      print(response);
      final List data = response['data'];
      vendorData['vendor_data'] =
          data.map((e) => Category.fromJson(e)).toList();
      vendorData['total_count'] = response['totalCount'];
      vendorData['listType'] = response['listType'];
      vendorData['showName'] = response['showName'];
      vendorData['filter_1'] = response['filter_1'];
      vendorData['filter_2'] = response['filter_2'];
      vendorData['filter_3'] = response['filter_3'];

      return vendorData;
    } catch (e) {
      print('================> Error Loading Vendor Data ===============>$e');
      showErrorDialog('Error Loading Vendor Data');
      return vendorData;
    }
  }

  Future<List<Category>> getAllVendors() async {
    List<Category> vendorsData = [];
    try {
      final response = await _apiService
          .postData(endpoint: Endpoints.allVendorsSelect, body: {});

      print('ALL VENDORS DATA==============> $response');
      final List data = response['data'];

      vendorsData = data.map((e) => Category.fromJson(e)).toList();
      return vendorsData;
    } catch (e) {
      print('================> Error Loading Vendors Data ===============>$e');
      showErrorDialog('Error Loading Vendor Data');
      return vendorsData;
    }
  }
}
