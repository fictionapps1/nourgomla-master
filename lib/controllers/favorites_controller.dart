import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controllers/drop_down_controller.dart';
import '../controllers/user_controller.dart';
import '../models/product.dart';
import '../models/favorite.dart';
import '../services/api_calls/favourite_service.dart';

class FavoritesController extends GetxController {
  ScrollController scrollController = ScrollController();
  UserController _userController = Get.find<UserController>();
  DropDownController dropDownController = Get.find<DropDownController>();
  FavouriteService _favouriteService = FavouriteService.instance;
  List<Product> favorites = [];

  RxBool loadingMore = false.obs;
  RxBool isLoading = false.obs;
  int itemsPerPage = 10;
  int startIndex = 0;
  int totalCount = 0;


  @override
  onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreFavorites();
      }
    });
    getUserFavorites();
    super.onInit();
  }
  onClose() {
    scrollController.dispose();
    super.onClose();
  }

  getUserFavorites() async {
    startIndex = 0;
    Favorite favItemsBody = Favorite(
        itemsPerPage: itemsPerPage,
        startIndex: startIndex,
        userId: _userController.currentUser.id,
        userRoleId: _userController.currentUser.role,
        languageId: 1,
        sortBy: dropDownController.selectedItem.values);

    isLoading.value = true;
    final Map<String, dynamic> ordersData =
        await _favouriteService.getFavoriteItems(favItemsBody);
    favorites.assignAll(ordersData['favorites']);
    totalCount = ordersData['total_count'];
    isLoading.value = false;
    startIndex = startIndex + itemsPerPage;
    update();
  }

  getMoreFavorites() async {
    Favorite favItemsBody = Favorite(
        itemsPerPage: itemsPerPage,
        startIndex: startIndex,
        userId: _userController.currentUser.id,
        userRoleId: _userController.currentUser.role,
        languageId: 1,
        sortBy: dropDownController.selectedItem.values);
    if (startIndex < totalCount) {
      loadingMore.value = true;
      final Map<String, dynamic> ordersData =
          await _favouriteService.getFavoriteItems(favItemsBody);
      favorites.addAll(ordersData['favorites']);
      startIndex = startIndex + itemsPerPage;
      loadingMore.value = false;
      update();
    }
  }
}
