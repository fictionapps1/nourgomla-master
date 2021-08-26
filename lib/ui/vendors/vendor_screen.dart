import 'package:flutter/material.dart';
import '../../ui/vendors/vendors_map_screen.dart';
import '../../common_widgets/loading_view.dart';
import '../../common_widgets/custom_text.dart';
import '../../common_widgets/image_button.dart';
import '../../consts/colors.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/vendor_controller.dart';
import '../../models/vendor_category.dart';
import 'package:get/get.dart';

import 'vendor_categories_screen.dart';

class VendorScreen extends StatelessWidget {
  final int vendorId;
  final String title;

  const VendorScreen({Key key, this.vendorId, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SettingsController _settingsCon = Get.find<SettingsController>();
    return Scaffold(
        backgroundColor: APP_BG_COLOR,
        appBar: AppBar(
          backgroundColor: _settingsCon.color1,
          title: Text(title),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                Get.to(() => VendorsMapScreen(title));
              },
            )
          ],
        ),
        body: GetBuilder<VendorController>(
            init: Get.put(VendorController(vendorId: vendorId.toString())),
            builder: (VendorController controller) {
              return controller.isLoading.value
                  ? LoadingView()
                  : Stack(
                      children: [
                        ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.vendorData.length,
                            itemBuilder: (context, index) {
                              return VendorTileWidget(
                                  controller.vendorData[index]);
                            }),
                        controller.loadingMore.value
                            ? Positioned(
                                bottom: 0,
                                left: 40,
                                right: 40,
                                child: LoadingView())
                            : SizedBox()
                      ],
                    );
            }));
  }
}

class VendorTileWidget extends StatelessWidget {
  final VendorCategory vendorCategory;

  VendorTileWidget(this.vendorCategory);
  final LanguageController langCon = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => VendorCategoriesScreen(
                title: vendorCategory.nameAr,
                categoryImage: vendorCategory.bannerImagesPath,
                vendorCategoryId: vendorCategory.id,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageButton(
                borderRadius: 15,
                imageUrl: vendorCategory.imagesPath,
                height: 100,
                width: 100,
                onPressed: null,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: langCon.lang == 'ar'
                          ? vendorCategory.nameAr
                          : vendorCategory.nameEn,
                      size: 17,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (!vendorCategory.busy && vendorCategory.closed) ...{
                          Icon(Icons.cancel, size: 15, color: Colors.red),
                        },
                        if (!vendorCategory.closed && vendorCategory.busy) ...{
                          Icon(Icons.circle, size: 12, color: Colors.orange),
                        },
                        SizedBox(width: 5),
                        CustomText(
                          text: vendorCategory.closed
                              ? 'closed'.tr
                              : vendorCategory.busy
                                  ? 'busy'.tr
                                  : '',
                          color: vendorCategory.closed
                              ? Colors.red
                              : vendorCategory.busy
                                  ? Colors.orange
                                  : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(children: [
                      Text(
                        'shipping_cost'.tr,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' : ',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        vendorCategory.shipping.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
