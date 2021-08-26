import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../models/rate.dart';
import '../services/api_calls/rating_services.dart';

class RatingController extends GetxController {
  final int productId;
  final bool isUSerRates;
  Rate rateToUpdate;
  RatingController({this.productId, this.isUSerRates = false});
  RatingServices _ratingServices = RatingServices.instance;
  ScrollController scrollController = ScrollController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RxDouble rating = 1.0.obs;
  RxString comment = ''.obs;
  RxBool success = false.obs;
  RxString msg = ''.obs;
  List<Rate> rates = [];
  RxBool loadingMore = false.obs;
  RxBool isLoading = false.obs;
  int itemsPerPage = 10;
  int startIndex = 0;
  int totalCount = 0;

  initRatingPageData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreRating();
      }
    });
    getRates(isUSerRates);
    super.onInit();
  }

  onClose() {
    print('closed');
    scrollController?.dispose();
    super.onClose();
  }

  changeRating(double newRating) {
    rating.value = newRating;
  }

  updateRating() async {
    final Map reviewData=await _ratingServices.updateRate(Rate(
        id: rateToUpdate.id,
        comment: comment.value,
        rate: rating.value));
    if (reviewData['success'] == true) {
      btnController.success();
      success(true);
      msg.value = reviewData['message'];
      getRates(true);
    } else {
      btnController.error();
      success(false);
      msg.value = reviewData['message'];
    }
  }




  submitRating(int productId) async {
    Map reviewData = await _ratingServices.reviewProduct(
      rate: rating.value.toInt(),
      comment: comment.value,
      productId: productId,
    );
    print(reviewData);
    if (reviewData['success'] == true) {
      btnController.success();
      success(true);
      msg.value = reviewData['message'];
    } else {
      btnController.error();
      success(false);
      msg.value = reviewData['message'];
    }
  }

  getRates(bool isUserRates) async {
    startIndex = 0;

    isLoading.value = true;
    final Map<String, dynamic> ratesData = await _ratingServices.getRates(
      itemsPerPage: itemsPerPage,
      startIndex: startIndex,
      productId: productId,
      isUserRates: isUserRates,
    );
    rates.assignAll(ratesData['rates_data']);
    totalCount = ratesData['total_count'];

    isLoading.value = false;
    startIndex = startIndex + itemsPerPage;
    update();
  }

  getMoreRating() async {
    if (startIndex < totalCount) {
      loadingMore.value = true;
      final Map<String, dynamic> ratesData = await _ratingServices.getRates(
        itemsPerPage: itemsPerPage,
        startIndex: startIndex,
        productId: productId,
        isUserRates: isUSerRates,
      );
      rates.addAll(ratesData['rates_data']);
      startIndex = startIndex + itemsPerPage;
      loadingMore.value = false;
      update();
    }
  }
}
