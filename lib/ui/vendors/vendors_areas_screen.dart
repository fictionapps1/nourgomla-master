import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/language_controller.dart';

import '../../controllers/vendors_areas_controller.dart';
import '../../models/vendor_area.dart';

import '../../common_widgets/custom_text.dart';
import '../../consts/colors.dart';
import '../../controllers/settings_controller.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../common_widgets/loading_view.dart';

class VendorAreasScreen extends StatelessWidget {
  final vendorsAreasCon = Get.put(VendorsAreasController());

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
          ),
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
                            FocusScope.of(context).unfocus();
                            vendorsAreasCon.getVendorsAreas();
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
                            controller: vendorsAreasCon.textController,
                            onSubmitted: (val) {
                                vendorsAreasCon.getVendorsAreas();
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: settingsCon.color2),
                              hintText: "search_for_area".tr,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ListView.builder(
                          controller: vendorsAreasCon.scrollController,
                          itemCount: vendorsAreasCon.vendorsAreasData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // shrinkWrap: true,
                            final vendorData =
                                vendorsAreasCon.vendorsAreasData[index];
                            return GetBuilder<VendorsAreasController>(
                                init: Get.find<VendorsAreasController>(),
                                builder: (con) {
                                  return VendorAreaTileWidget(vendorData);
                                });
                          },
                        ),
                      ),
                      if (vendorsAreasCon.vendorsAreasData.isEmpty &&
                          vendorsAreasCon.isLoading.value) ...{
                        Align(alignment: Alignment.center, child: LoadingView())
                      } else if (vendorsAreasCon.isLoading.value) ...{
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

class VendorAreaTileWidget extends StatelessWidget {
  final VendorArea vendorArea;
  final LanguageController langCon = Get.find<LanguageController>();
  VendorAreaTileWidget(this.vendorArea);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<VendorsAreasController>().selectVendor(vendorArea.id);
        Get.back();
      },
      child: Card(
        elevation: .5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: langCon.lang == 'ar'
                      ? vendorArea.nameAr
                      : vendorArea.nameEn),
              if (vendorArea.isSelected)
                CircleAvatar(
                  child: Icon(Icons.check),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                )
            ],
          ),
        ),
      ),
    );
  }
}
