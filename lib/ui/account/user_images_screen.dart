import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../common_widgets/images_gallery.dart';
import '../../common_widgets/loading_view.dart';
import '../../common_widgets/cached_image.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../consts/colors.dart';
import '../../controllers/images_controller.dart';
import '../../controllers/settings_controller.dart';

class UserImagesScreen extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return GetX<ImagesController>(
      init: Get.put(ImagesController()),
      builder: (controller) => Scaffold(
        backgroundColor: APP_BG_COLOR,
        appBar: AppBar(
          backgroundColor: _settingsCon.color1,
          title: Text("select_images".tr),
        ),
        body: Column(
          children: [
            controller.loading.value
                ? Expanded(child: Center(child: LoadingView()))
                : Expanded(
                    child: Stack(
                      children: [
                        GridView.builder(
                          controller: controller.scrollController,
                          padding:
                              const EdgeInsets.only(top: 20, left: 10, right: 10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: controller.userImages.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Get.to(ImagesGallery(
                                    initialPage: index,
                                    photosUrl: controller.userImages,
                                  ));
                                },
                                child: CachedImage(
                                  controller.userImages[index],
                                  radius: 20,
                                ));
                          },
                        ),
                        if(controller.loadingMore.value)
                          Positioned(bottom: 0,left:0,right:0,child: LoadingView(),)
                      ],
                    ),
                  ),
            Padding(
              padding: EdgeInsets.all(14),
              child: Center(
                child: CommonButton(
                  text: 'tack_image'.tr,
                  containerColor: _settingsCon.color2,
                  width: 150,
                  height: 50,
                  corners: Corners(10, 10, 10, 10),
                  onTap: () {
                    Get.defaultDialog(
                        title: "select_images".tr,
                        content: Column(
                          children: [
                            CommonButton(
                                text: 'gallery'.tr,
                                containerColor:  _settingsCon.color2,
                                width: 150,
                                height: 50,
                                corners: Corners(10, 10, 10, 10),
                                onTap: () {
                                  controller.pickImage(ImageSource.gallery);

                                  Get.back();
                                }),
                            SizedBox(height: 10),
                            CommonButton(
                                text: 'camera'.tr,
                                containerColor:  _settingsCon.color2,
                                width: 150,
                                height: 50,
                                corners: Corners(10, 10, 10, 10),
                                onTap: () {
                                  controller.pickImage(ImageSource.camera);

                                  Get.back();
                                }),
                          ],
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
