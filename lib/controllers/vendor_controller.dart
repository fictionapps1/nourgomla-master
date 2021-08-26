import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/vendor_area.dart';
import '../models/vendor_category.dart';
import '../services/api_calls/vendors_services.dart';

class VendorController extends GetxController {


  VendorController({
    this.vendorId,
    this.isFromSearch = false,
  });
  List<VendorCategory> vendorData = [];
  List<VendorArea> vendorsAreasData = [];
  VendorsServices _vendorsServices = VendorsServices.instance;
  ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  String vendorId = '';
  final bool isFromSearch;
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
        getMoreVendors();
      }
    });
    if (!isFromSearch) {
      getVendors();
    }
    super.onInit();
  }

  getVendors() async {
    startIndex = 0;
    isLoading.value = true;
    final Map<String, dynamic> data = await _vendorsServices.getVendors(
        itemsPerPage: itemsPerPage,
        startIndex: startIndex,
        vendorCategoryId: vendorId,
        searchName: textController.text);
    if (data != null && data.isNotEmpty) {
      print('ddddddddddddddddddddddddddddddddddddddddddddddddddddd $data');
      vendorData.assignAll(data['vendor_data']);
      totalCount = data['total_count'];
      startIndex = startIndex + itemsPerPage;
    }

    isLoading.value = false;

    update();
  }

  getMoreVendors() async {
    if (startIndex < totalCount) {
      loadingMore.value = true;
      final Map<String, dynamic> data = await _vendorsServices.getVendors(
          itemsPerPage: itemsPerPage,
          startIndex: startIndex,
          vendorCategoryId: vendorId);
      vendorData.addAll(data['vendor_data']);
      startIndex = startIndex + itemsPerPage;
      loadingMore.value = false;
      update();
    }
  }
}
