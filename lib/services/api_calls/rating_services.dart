
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/language_controller.dart';
import '../../models/rate.dart';
import '../../common_widgets/dialogs_and_snacks.dart';

import '../../controllers/user_controller.dart';

import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';


class RatingServices {
  RatingServices._internal();
  static final RatingServices _ratingServices = RatingServices._internal();
  static RatingServices get instance => _ratingServices;

  final APIService _apiService = APIService();
  final UserController _userController = Get.find<UserController>();
  final LanguageController _langController = Get.find<LanguageController>();

  Future <Map<String,dynamic>> getRates(
      {int itemsPerPage,
      int startIndex,
      int productId,
      bool isUserRates = false}) async {
    Map<String,dynamic> ratesData = {};
    try {
      final response = await _apiService
          .postData(endpoint: Endpoints.productReviewSelect, body: {
        'itemsPerPage': itemsPerPage,
        'startIndex': startIndex,
        'user_id': isUserRates ? _userController.currentUser.id : '',
        'id': isUserRates ? '' : productId,
      });

      print(response);
      final List data = response['data'];
      ratesData['rates_data'] = data.map((e) => Rate.fromJson(e)).toList();
      ratesData['total_count'] = response['totalCount'];

      return ratesData;
    } catch (e) {
      print('================> Error Loading Rates Data ===============>$e');
      showErrorDialog('Error Loading Rates Data');
      return ratesData;
    }
  }


  updateRate(Rate rate)async{
    Map reviewData = {
      'success': false,
      'message': 'error',
    };
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.productReviewUpdate,
        body: {
          'id':rate.id,
          'rate':rate.rate,
          'comment':rate.comment,
          'language_id':_langController.langId(),
        },
      );
      print("RATE DATA==========================>   $data");

      if (data != null) {
        reviewData['success'] = data['success'];
        reviewData['message'] = data['message'];
        return reviewData;
      } else {
        return reviewData;
      }
    } catch (e) {
      showErrorDialog('Error Rating Product');
      print('Error Rating Product================> $e');
      return reviewData;
    }
  }
  Future<Map> reviewProduct({
    @required int rate,
    @required String comment,
    @required int productId,
  }) async {
    print('ENDPOINT====================> ${Endpoints.productDetailsSelect}');
    print('type====================> $rate');
    print('product Id====================> $productId');
    Map reviewData = {
      'success': false,
      'message': 'error',
    };
    try {
      Map<String, dynamic> data = await _apiService.postData(
        endpoint: Endpoints.productReviewInsert,
        body: {
          'product_id': productId,
          'user_id': _userController.currentUser.id,
          'comment': comment,
          'rate': rate,
          'language_id': _langController.langId(),
        },
      );
      print("RATE DATA==========================>   $data");

      if (data != null) {
        reviewData['success'] = data['success'];
        reviewData['message'] = data['message'];
        return reviewData;
      } else {
        return reviewData;
      }
    } catch (e) {
      showErrorDialog('Error Rating Product');
      print('Error Rating Product================> $e');
      return reviewData;
    }
  }
}
