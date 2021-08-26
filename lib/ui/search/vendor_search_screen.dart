import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/vendor_controller.dart';
import '../../ui/vendors/vendor_screen.dart';
import '../../common_widgets/custom_text.dart';
import '../../consts/colors.dart';
import '../../controllers/settings_controller.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../common_widgets/loading_view.dart';

class VendorSearchScreen extends StatelessWidget {
  final searchController = Get.put(VendorController(isFromSearch: true));

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
                          if (searchController.textController.text != '') {
                            FocusScope.of(context).unfocus();
                            searchController.getVendors();
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
                                searchController.getVendors();
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: settingsCon.color2),
                              hintText: "search_for_vendor".tr,
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
                          controller: searchController.scrollController,
                          itemCount: searchController.vendorData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // shrinkWrap: true,
                            final vendorData = searchController.vendorData[index];
                            return VendorTileWidget(vendorData);
                          },
                        ),
                      ),
                      if (searchController.vendorData.isEmpty &&
                          searchController.isLoading.value) ...{
                        Align(alignment: Alignment.center, child: LoadingView())
                      } else if (searchController.isLoading.value) ...{
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
