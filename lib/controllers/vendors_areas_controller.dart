import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controllers/location_controller.dart';
import '../models/vendor_area.dart';

import '../services/api_calls/vendors_services.dart';

class VendorsAreasController extends GetxController {
  List<VendorArea> vendorsAreasData = [];
  VendorsServices _vendorsServices = VendorsServices.instance;
  ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  int itemsPerPage = 10;
  int startIndex = 0;
  int totalCount = 0;
  RxBool isLoading = false.obs;
  RxBool loadingMore = false.obs;

  @override
  void onInit() {
    initVendorData();
    super.onInit();
  }

  onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  initVendorData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreVendorsAreas();
      }
    });

    getVendorsAreas();

    super.onInit();
  }

  getVendorsAreas() async {
    startIndex = 0;
    isLoading.value = true;
    final Map<String, dynamic> data = await _vendorsServices.getVendorsAreas(
        itemsPerPage: itemsPerPage,
        startIndex: startIndex,
        searchName: textController.text);
    if (data != null && data.isNotEmpty) {
      print('ddddddddddddddddddddddddddddddddddddddddddddddddddddd $data');
      vendorsAreasData.assignAll(data['vendor_data']);
      totalCount = data['total_count'];
      startIndex = startIndex + itemsPerPage;
    }

    isLoading.value = false;

    update();
  }

  getMoreVendorsAreas() async {
    if (startIndex < totalCount) {
      loadingMore.value = true;
      final Map<String, dynamic> data = await _vendorsServices.getVendorsAreas(
          itemsPerPage: itemsPerPage,
          startIndex: startIndex,
          searchName: textController.text);
      vendorsAreasData.addAll(data['vendor_data']);
      startIndex = startIndex + itemsPerPage;
      loadingMore.value = false;
      update();
    }
  }

  selectVendor(int vendorId) {
    vendorsAreasData.forEach((element) {
      if (element.id == vendorId) {
        element.isSelected = true;
        Get.find<LocationController>().chooseLocation(element);

      } else {
        element.isSelected = false;
      }
    });

    update();
  }
}
