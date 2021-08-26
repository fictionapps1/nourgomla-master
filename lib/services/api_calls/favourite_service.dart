import 'package:flutter/material.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/product.dart';
import '../../models/favorite.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
import 'package:get/get.dart';

class FavouriteService {
  FavouriteService._internal();

  static final FavouriteService _favouriteService =
      FavouriteService._internal();

  static FavouriteService get instance => _favouriteService;
  final APIService _apiService = APIService();
  final UserController _userController = Get.find<UserController>();
  final LanguageController _langController= Get.find<LanguageController>();

  Future<Map<String, dynamic>> getFavoriteItems(Favorite favItems) async {
    favItems.userId = _userController.currentUser.id;
    favItems.languageId = int.parse(_langController.langId());

    Map<String, dynamic> favoritesData = {};
    try {
      final Map<String, dynamic> response = await _apiService.postData(
        endpoint: Endpoints.selectedFavourites,
        body: favItems.toJson(),
      );
      List<dynamic> data = response['data'];

      favoritesData['favorites'] =
          data.map((e) => Product.fromJson(e)).toList();
      favoritesData['total_count'] = response['totalCount'];
      print('Favs===================>       $favoritesData');
      return favoritesData;
    } catch (error) {
      showErrorDialog('Error Loading Favorites');
      return null;
    }
  }

  Future<void> addFavoriteItem({
    @required int productId,
  }) async {
    try {
      final Map<String, dynamic> response = await _apiService.postData(
        endpoint: Endpoints.likedProducts,
        body: {
          'product_id': productId,
          'user_id': _userController.currentUser.id,
          'language_id': _langController.langId(),
        },
      );
      print(response["message"]);
      showSnack(response["message"]);
    } catch (error) {
      showErrorDialog('Error Editing Favorite Status');
    }
  }
}

