import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/empty_view.dart';
import '../../common_widgets/product_list_card_1.dart';
import '../../consts/colors.dart';

import '../../controllers/drop_down_controller.dart';
import '../../controllers/favorites_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../models/drop_down_list_data.dart';
import '../../common_widgets/loading_view.dart';

class FavoritesScreen extends StatelessWidget {
  final dropDownController = Get.find<DropDownController>();
  final favoritesController = Get.put(FavoritesController());
  final settingsCn = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
        init: favoritesController,
        builder: (favoritesController) {
          return Scaffold(
              backgroundColor: APP_BG_COLOR,
              appBar: AppBar(
                  title: Text('my_favorites'.tr),
                  centerTitle: true,
                  actions: [
                    GetBuilder<DropDownController>(
                        init: dropDownController,
                        builder: (dropController) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: DropdownButton<ListItem>(
                                  icon: Icon(
                                    Icons.filter_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  dropdownColor: settingsCn.color2,
                                  underline: SizedBox(),
                                  isDense: true,
                                  value: dropController.selectedItem,
                                  items: dropController.dropdownMenuItems,
                                  onChanged: (value) async {
                                    dropController.selectedItem = value;
                                    dropController.update();
                                    favoritesController.getUserFavorites();
                                  }),
                            ),
                          );
                        }),
                  ],
                  backgroundColor: settingsCn.color1),
              body: GetX<FavoritesController>(
                init: favoritesController,
                builder: (con) => con.isLoading.value
                    ? LoadingView()
                    : favoritesController.favorites.isEmpty
                        ? EmptyView(text: 'no_favorites_added_yet'.tr,)
                        : Stack(
                            children: [
                              ListView.builder(
                                  controller:
                                      favoritesController.scrollController,
                                  itemCount:
                                      favoritesController.favorites.length,
                                  itemBuilder: (context, index) =>
                                      ChangeNotifierProvider.value(
                                        value: favoritesController
                                            .favorites[index],
                                        child: ProductListCard1(
                                          product: favoritesController
                                              .favorites[index],
                                          buttonText: 'Add To Cart',
                                          onCardPressed: null,
                                          onAddToCartPressed: null,
                                        ),
                                      )),
                              if (con.loadingMore.value)
                                Positioned(
                                    bottom: 0,
                                    left: 40,
                                    right: 40,
                                    child: LoadingView())
                            ],
                          ),
              ));
        });
  }
}


