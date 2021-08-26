import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../ui/vendors/vendor_screen.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../common_widgets/image_button.dart';
import 'package:get/get.dart';
import '../../../controllers/language_controller.dart';

class VendorsListBuilder extends StatelessWidget {
  final bool isVertical;
  final List images;
  final List routsIds;
  final List titlesAr;
  final List titlesEn;
  final bool showTitles;

  VendorsListBuilder(
      {this.isVertical,
      this.images,
      this.titlesAr,
      this.showTitles,
      this.titlesEn,
      this.routsIds});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isVertical
          ? null
          : showTitles
              ? 270
              : 240,
      child: StaggeredGridView.countBuilder(
          physics: isVertical ? NeverScrollableScrollPhysics() : null,
          scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
          shrinkWrap: true,
          crossAxisSpacing: showTitles ? 30 : 0,
          mainAxisSpacing: 0,
          crossAxisCount: 2,
          staggeredTileBuilder: (index) {
            return StaggeredTile.fit(1);
          },
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GetBuilder<LanguageController>(
                init: Get.find(),
                builder: (langCon) {
                  return Column(
                    children: [
                      ImageButton(
                        padding: 8,
                        boxFit: BoxFit.cover,
                        onPressed: () {
                          Get.to(() => VendorScreen(
                                vendorId: routsIds[index],
                                title: langCon.lang == 'ar'
                                    ? titlesAr[index]
                                    : titlesEn[index],
                              ));
                        },
                        imageUrl: images[index],
                        // height: 150,
                        // width: 200,
                        borderRadius: 20,
                      ),
                      if (showTitles)
                        CustomText(
                          text: langCon.lang == 'ar'
                              ? titlesAr[index]
                              : titlesEn[index],
                          size: 17,
                          weight: FontWeight.w500,
                        ),
                    ],
                  );
                });
          }),
    );
  }
}
