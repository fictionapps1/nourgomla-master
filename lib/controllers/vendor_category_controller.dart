import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_calls/vendors_services.dart';
import '../models/category.dart';


class VendorCategoryController extends GetxController {
  VendorsServices _vendorsServices = VendorsServices.instance;
  final vendorCategoryId;
  List<Category> vendorCategories = [];

  VendorCategoryController(this.vendorCategoryId);

  String listType = 'horizontalTwoInLine';
  String _showName = 'true';
  RxBool isList = false.obs;
  bool isLoading=false;

  onInit() async {
    getVendorCategories(parentId: vendorCategoryId);
    super.onInit();
  }

  Future<List<Category>> getVendorCategories(
      {int type, @required int parentId}) async {
    // final filterController = Get.find<FilterController>();
    isLoading=true;
    final categoriesData = await _vendorsServices.getVendorCategory(
        vendorCategoryId: vendorCategoryId);
    listType = categoriesData['listType'];
    _showName = categoriesData['showName'];
    isLoading=false;
    // filterController.initFilter(
    //   companiesList: categoriesData['companies_filter'],
    //   trademarksList: categoriesData['trademarks_filter'],
    //   typesList: categoriesData['types_filter'],
    // );
    vendorCategories = categoriesData['vendor_data'];
    print('VENDOR CATEGORIES========================> $vendorCategories');
    update();
    return categoriesData['vendor_data'];
  }

  bool get isVerticalOneInLine => listType == 'verticalOneInLine';
  bool get isVerticalTwoInLine => listType == 'verticalTwoInLine';
  bool get isHorizontalOneInLine => listType == 'horizontalOneInLine';
  bool get isHorizontalTwoInLine => listType == 'horizontalTwoInLine';
  bool get showName => _showName == 'true';
}
