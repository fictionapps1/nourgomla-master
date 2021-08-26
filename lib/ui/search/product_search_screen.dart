import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/product_list_card_1.dart';
import '../../common_widgets/custom_text.dart';
import '../../consts/colors.dart';
import '../../controllers/drop_down_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../models/drop_down_list_data.dart';

import '../../responsive_setup/responsive_builder.dart';
import '../../ui/products/product_details_screen.dart';
import'../../common_widgets/loading_view.dart';import '../../controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final searchController = Get.put(SearchController());
  final dropDownController = Get.find<DropDownController>();
  final settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: APP_BG_COLOR,
          appBar: AppBar(
              backgroundColor: settingsCon.color1,
              title: CustomText(
                text: 'search'.tr,
                size: 18,
                weight: FontWeight.w500,
              ),
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
                              dropdownColor: settingsCon.color2,
                              underline: SizedBox(),
                              isDense: true,
                              value: dropController.selectedItem,
                              items: dropController.dropdownMenuItems,
                              onChanged: (value) async {
                                dropController.selectedItem = value;
                                dropController.update();
                                searchController.getProducts();
                              }),
                        ),
                      );
                    }),
                SizedBox(width: 30),
                IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    searchController.scanBarcode();
                  },
                ),
              ]),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      InkWell(
                        onTap: () {
                          if (searchController.textController.text != '') {
                            FocusScope.of(context).unfocus();
                            searchController.getProducts();
                          }
                        },
                        child: Container(
                          height: 43,
                          width: 50,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              color: settingsCon.color1),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 43,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: searchController.textController,
                            onSubmitted: (val) {
                              if (val != '') {
                                searchController.getProducts();
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: settingsCon.color2),
                              hintText: "search_for_product".tr,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: searchController.scrollController,
                        itemCount: searchController.searchList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // shrinkWrap: true,
                          return ChangeNotifierProvider.value(
                            value: searchController.searchList[index],
                            child: ProductListCard1(
                              buttonText: "Add To Cart",
                              product: searchController.searchList[index],
                              onCardPressed: () {
                                Get.to(() => ProductDetailsScreen(
                                      product:
                                          searchController.searchList[index],
                                    ));
                              },
                            ),
                          );
                        },
                      ),
                      if (searchController.searchList.isEmpty &&
                          searchController.loading.value) ...{
                        Align(alignment: Alignment.center, child: LoadingView())
                      } else if (searchController.loading.value) ...{
                        Positioned(
                            bottom: 0, left: 0, right: 0, child: LoadingView())
                      }
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
