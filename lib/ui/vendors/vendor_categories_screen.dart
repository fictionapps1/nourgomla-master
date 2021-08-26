import 'package:flutter/material.dart';
import '../../common_widgets/empty_view.dart';
import '../../common_widgets/loading_view.dart';
import '../../common_widgets/image_button.dart';
import '../../controllers/vendor_category_controller.dart';
import '../../consts/colors.dart';
import '../../controllers/settings_controller.dart';
import 'package:get/get.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../ui/products/widgets/horizontal_list_one_line.dart';
import '../../ui/products/widgets/horizontal_list_two_line.dart';
import '../../ui/products/widgets/vertical_list_one_in_line.dart';
import '../../ui/products/widgets/vertical_list_two_in_line.dart';

class VendorCategoriesScreen extends StatelessWidget {
  final String title;
  final String categoryImage;
  final int vendorCategoryId;
  const VendorCategoriesScreen(
      {Key key, this.title, this.vendorCategoryId, this.categoryImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController _settingsCon = Get.find<SettingsController>();
    return Scaffold(
        backgroundColor: APP_BG_COLOR,
        appBar: AppBar(
            backgroundColor: _settingsCon.color1,
            title: Text(title ?? ''),
            centerTitle: true),
        body: ResponsiveBuilder(builder: (context, sizingInfo) {
          return GetBuilder<VendorCategoryController>(
              init: Get.put(VendorCategoryController(vendorCategoryId)),
              builder: (VendorCategoryController controller) {
                return controller.isLoading
                    ? LoadingView()
                    : controller.vendorCategories.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
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
                                    categories: controller.vendorCategories,
                                    categoryImage: categoryImage,
                                    controller: controller,
                                    // vendorId:controller.vendorCategories[0].vendorId.toString(),
                                  )
                                },
                                if (controller.isHorizontalOneInLine) ...{
                                  HorizontalListOneLine(
                                    categories: controller.vendorCategories,
                                    categoryImage: categoryImage,
                                    controller: controller,
                                    // vendorId:controller.vendorCategories[0].vendorId.toString(),
                                  )
                                },
                                if (controller.isVerticalOneInLine) ...{
                                  VerticalListOneInLine(
                                    categories: controller.vendorCategories,
                                    categoryImage: categoryImage,
                                    controller: controller,
                                    // vendorId:controller.vendorCategories[0].vendorId.toString(),
                                  )
                                },
                                if (controller.isVerticalTwoInLine) ...{
                                  VerticalListTwoInLine(
                                    categories: controller.vendorCategories,
                                    categoryImage: categoryImage,
                                    controller: controller,
                                    // vendorId:controller.vendorCategories[0].vendorId.toString(),
                                  )
                                },
                              ],
                            ),
                          )
                        : EmptyView();
              });
        }));
  }
}
