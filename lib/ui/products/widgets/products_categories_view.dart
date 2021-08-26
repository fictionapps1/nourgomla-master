import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/image_button.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/categories_view_controller.dart';
import '../../../models/category.dart';
import '../../../responsive_setup/responsive_builder.dart';
import '../../../ui/products/products_page.dart';
import '../../../ui/products/widgets/horizontal_list_one_line.dart';
import '../../../ui/products/widgets/horizontal_list_two_line.dart';
import '../../../ui/products/widgets/vertical_list_one_in_line.dart';
import '../../../ui/products/widgets/vertical_list_two_in_line.dart';

class ProductsCategoriesView extends GetView<CategoriesViewController> {
  final String vendorId;
  final int categoryId;
  final String categoryImage;
  final List<Category> categories;
  const ProductsCategoriesView({
    @required this.categories,
    @required this.vendorId,
    @required this.categoryId,
    @required this.categoryImage,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (categoryImage != null)
            ImageButton(
              padding: 5,
              width: sizingInfo.screenWidth,
              height: sizingInfo.screenWidth / 3,
              borderRadius: 20,
              imageUrl: categoryImage,
              onPressed: () {},
              boxFit: BoxFit.fill,
            ),
          if (controller.isHorizontalTwoInLine) ...{
            HorizontalListTwoLine(
              categories: categories,
              categoryImage: categoryImage,
              controller: controller,
            )
          },
          if (controller.isHorizontalOneInLine) ...{
            HorizontalListOneLine(
              categories: categories,
              categoryImage: categoryImage,
              controller: controller,
            )
          },
          if (controller.isVerticalOneInLine) ...{
            VerticalListOneInLine(
              categories: categories,
              categoryImage: categoryImage,
              controller: controller,
            )
          },
          if (controller.isVerticalTwoInLine) ...{
            VerticalListTwoInLine(
              categories: categories,
              categoryImage: categoryImage,
              controller: controller,
            )
          },
        ],
      );
    });
  }

  Future navigateToNext(Category category) {
    return Get.to(
      () => GetBuilder<LanguageController>(
          init: Get.find(),
          builder: (con) {
            return ProductsPage(
              categoryImage: categoryImage,
              categoryId: category.id,
              vendorId: vendorId,
              title: con.lang == 'ar' ? category.nameAr : category.nameEn,
            );
          }),
      preventDuplicates: false,
    );
  }
}
