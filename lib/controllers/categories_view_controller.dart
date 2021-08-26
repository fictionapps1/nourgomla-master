import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/filter_contoller.dart';
import '../models/category.dart';

import '../services/api_calls/category_services.dart';

class CategoriesViewController extends GetxController {
  final CategoryServices _categoryServices = CategoryServices.instance;

  String productListType = 'horizontalTwoInLine';
  String _showName = 'true';
  RxBool isList = false.obs;

  Future<List<Category>> getCategories(
      {int type, @required int parentId,@required vendorId}) async {
    final filterController = Get.find<FilterController>();
    final categoriesData = await _categoryServices.getCategories(
      type: '',
      parentId: parentId.toString(),
      queryName: '',
      vendorId:vendorId,
    );
    productListType = categoriesData['listType'];
    _showName = categoriesData['showName'];
    filterController.initFilter(
      companiesList: categoriesData['companies_filter'],
      trademarksList: categoriesData['trademarks_filter'],
      typesList: categoriesData['types_filter'],
    );

    update();
    return categoriesData['categories'];
  }

  bool get isVerticalOneInLine => productListType == 'verticalOneInLine';
  bool get isVerticalTwoInLine => productListType == 'verticalTwoInLine';
  bool get isHorizontalOneInLine => productListType == 'horizontalOneInLine';
  bool get isHorizontalTwoInLine => productListType == 'horizontalTwoInLine';
  bool get showName => _showName == 'true';
}
