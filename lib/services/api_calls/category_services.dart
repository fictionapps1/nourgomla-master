import 'package:flutter/cupertino.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../models/category.dart';
import '../../models/category_type.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';

class CategoryServices {
  CategoryServices._internal();

  static final CategoryServices _categoryServices =
      CategoryServices._internal();

  static CategoryServices get instance => _categoryServices;

  final APIService _apiService = APIService();

  Future<Map<String, dynamic>> getCategories({
    @required String type,
    @required String parentId,
    @required String queryName,
    @required String vendorId,
  }) async {
    Map<String, dynamic> categoriesData = {};
    List<Category> categories = [];
    List<Category> companiesFilterData = [];
    List<Category> trademarksFilterData = [];
    List<Category> typesFilterData = [];
    try {

      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.CategoriesSelect,
        body: {
          'name': queryName,
          'parent_id': parentId,
          'status': '1',
          'type': type,
          'created_by': '',
          'created_at': '',
          'vendor_id': '',
        },
      );

      List<dynamic> json = data['data'];
      List<dynamic> filter1 = data['filter_1'];
      List<dynamic> filter2 = data['filter_2'];
      List<dynamic> filter3 = data['filter_3'];
      categories.addAll(json.map((e) => Category.fromJson(e)).toList());
      companiesFilterData
          .addAll(filter1.map((e) => Category.fromJson(e)).toList());
      trademarksFilterData
          .addAll(filter2.map((e) => Category.fromJson(e)).toList());
      typesFilterData.addAll(filter3.map((e) => Category.fromJson(e)).toList());

      categoriesData['categories'] = categories;
      categoriesData['listType'] = data['listType'];
      categoriesData['showName'] = data['showName'];
      categoriesData['companies_filter'] = companiesFilterData;
      categoriesData['trademarks_filter'] = trademarksFilterData;
      categoriesData['types_filter'] = typesFilterData;

      return categoriesData;
    } catch (e) {
      print(
          '{===================Err In Categories ======================> $e}');
      showErrorDialog('Error Loading Categories');

      return categoriesData;
    }
  }

  Future<List<CategoryType>> getCategoriesType() async {
    List<CategoryType> categoriesTypes = [];

    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.SelectCategoriesType,
        body: {},
      );
      List<dynamic> json = data['data'];
      categoriesTypes
          .addAll(json.map((e) => CategoryType.fromJson(e)).toList());
      print('CATEGORIES TYPES DATA====================>  $json');
      return categoriesTypes;
    } catch (e) {
      showErrorDialog('Error Loading Categories Types');
      return categoriesTypes;
    }
  }
}
