import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../common_widgets/image_button.dart';
import '../../../controllers/language_controller.dart';
import '../../../models/category.dart';
import '../../../responsive_setup/responsive_builder.dart';
import '../../../ui/products/widgets/product_pages_navigator.dart';
//
class HorizontalListOneLine extends StatelessWidget {
  final controller;
  final List<Category> categories;
  final String categoryImage;
  final String vendorId;

  HorizontalListOneLine(
      {this.categories,
      this.categoryImage,
      this.vendorId,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ResponsiveBuilder(builder: (context, sizingInfo) {
        final height = sizingInfo.screenHeight;
        return Container(
          height: controller.showName ? height / 4.3 : height / 5.2,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 1,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              Category category = categories[index];
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: ImageButton(
                        height: height / 6,
                        width: height / 6,
                        padding: 5,
                        borderRadius: 20,
                        imageUrl: category.imagesPath,
                        onPressed: () => navigateToNextCategory(
                            category: category,
                            vendorId: vendorId,
                            categoryImage: category.bannerImagePath),
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    if (controller.showName)
                      GetBuilder<LanguageController>(
                          init: Get.find(),
                          builder: (langCon) {
                            return CustomText(
                              text: langCon.lang == 'ar'
                                  ? category.nameAr
                                  : category.nameEn,
                              size: 17,
                            );
                          }),
                    //CustomText(text: val.categories[index].nameEn),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
