import 'package:flutter/material.dart';
import '../../models/rate.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/product.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
import 'package:get/get.dart';

class ProductsService {
  APIService _apiService = APIService();
  ProductsService._internal();
  static final ProductsService _productsService = ProductsService._internal();
  static ProductsService get instance => _productsService;

  final LanguageController _langController = Get.find<LanguageController>();
  final UserController _userController = Get.find<UserController>();

  Future<Map<String, dynamic>> getProducts({
    @required int startIndex,
    @required int categoryId,
    @required String sortBy,
    @required String company,
    @required String trademark,
    @required String type,
    @required int itemsPerPage,
    int userId,
  }) async {
    Map<String, dynamic> productsData = {};
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.ProductsSelect,
        body: {
          'itemsPerPage': itemsPerPage,
          'startIndex': startIndex,
          'category_id': categoryId,
          'user_role_id':
              _userController.loggedIn ? _userController.currentUser.role : 1,
          'language_id': _langController.langId(),
          'user_id':
              _userController.loggedIn ? _userController.currentUser.id : '',
          'sort_by': sortBy,
          'filter_1': company,
          'filter_2': trademark,
          'filter_3': type,
        },
      );
      List<dynamic> json = data['data'];
      print("PRODUCTS=======>   $data");
      productsData['products'] = json.map((e) => Product.fromJson(e)).toList();
      productsData['total_count'] = data['totalCount'];
    } catch (e) {
      print('Error Loading Products=================>$e');
      showErrorDialog('Error Loading Products');
      return productsData;
    }

    return productsData;
  }

  Future<Map<String, dynamic>> getProductDetails({
    @required String type,
    @required int productId,
  }) async {
    Map<String, dynamic> productsData = {};
    List<String> imagesPaths = [];
    List<Rate> rates = [];
    print('ENDPOINT====================> ${Endpoints.productDetailsSelect}');
    print('type====================> $type');
    print('product Id====================> $productId');
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.productDetailsSelect,
        body: {
          'id': productId,
          'user_role_id':
              _userController.loggedIn ? _userController.currentUser.role : 1,
          'user_id':
              _userController.loggedIn ? _userController.currentUser.id : '',
          'type': type,
        },
      );
      List imagesData = data['images'];
      List details = data['data'];
      List ratingData = data['rate'];

      imagesData.forEach((image) {
        imagesPaths.add(image['path']);
      });
      ratingData.forEach((element) {
        rates.add(Rate.fromJson(element));
      });

      print("PRODUCTS=======>   $data");
      if (details.isNotEmpty) {
        productsData['details'] = Product.fromJson(details[0]);
      }
      print('RATES=======================>$rates');
      productsData['images'] = imagesPaths;
      productsData['rates'] = rates;
    } catch (e) {
      showErrorDialog('Error Loading Product Details');
      print('Error Loading Product Details ==========> $e');
      return productsData;
    }

    return productsData;
  }


}
