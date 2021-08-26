import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../common_widgets/image_button.dart';
import '../../../controllers/language_controller.dart';
import '../../../models/category.dart';
import '../../../responsive_setup/responsive_builder.dart';
import '../../../ui/products/widgets/product_pages_navigator.dart';

class VerticalListOneInLine extends StatelessWidget {
  final controller;
  final List<Category> categories;
  final String categoryImage;
  final String vendorId;


  VerticalListOneInLine(
      {this.categories,
      this.categoryImage,
      this.vendorId,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ResponsiveBuilder(builder: (context, sizingInfo) {
        return Container(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: categories.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 0),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: controller.showName ? 2.2 : 2.7,
              crossAxisCount: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              Category category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Container(
                  // color: Colors.green,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // color: Colors.red,
                        child: ImageButton(
                          height: sizingInfo.screenWidth / 3,
                          width: sizingInfo.screenWidth,
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
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
