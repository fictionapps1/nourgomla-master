import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/drawer.dart';
import '../../common_widgets/nav_animation_state.dart';
import '../../common_widgets/image_button.dart';
import '../../consts/colors.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/categories_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../models/category.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../ui/products/products_page.dart';
import '../../ui/sections/widgets/sections_header.dart';

class SectionsScreen extends StatefulWidget {
  final int categoryIndex;

  SectionsScreen(this.categoryIndex);

  @override
  _SectionsScreenState createState() => _SectionsScreenState();
}

class _SectionsScreenState extends NavAnimationState<SectionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SettingsController _settingsCon = Get.find<SettingsController>();
  final LanguageController _langCon = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return GetBuilder<CategoriesController>(
        init: Get.put(CategoriesController()),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: APP_BG_COLOR,
              drawer: AppDrawer(),
              key: _scaffoldKey,
              appBar: CustomAppBar(
                scaffoldKey: _scaffoldKey,
                centerWidget: Container(
                  height: 35,
                  width: sizingInfo.screenWidth * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white54,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: controller.queryName.value,
                          onChanged: (value) =>
                              controller.queryName.value = value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            hintStyle: TextStyle(
                                fontSize: 16, color: _settingsCon.color4),
                            hintText: "search".tr,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.search, color: _settingsCon.color4),
                      )
                    ],
                  ),
                ),
              ),
              body: AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget child) {
                  return FadeTransition(
                      opacity: animation,
                      child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 100 * (1.0 - animation.value), 0.0),
                          child: child));
                },
                child: Column(
                  children: [
                    SectionsHeader(),
                    const SizedBox(height: 2),
                    Expanded(
                      child: controller.obx(
                        (categories) {
                          return GridView.builder(
                            padding: const EdgeInsets.only(bottom: 30),
                            itemCount: categories.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              Category category = categories[index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: ImageButton(
                                      width: 300,
                                      height: 100,
                                      borderRadius: 20,
                                      imageUrl: category.imagesPath,
                                      onPressed: () {
                                        Get.to(() => ProductsPage(
                                              categoryId: category.id,
                                              vendorId: controller
                                                  .categoryType.value
                                                  .toString(),
                                              title: _langCon.lang == 'ar'
                                                  ? category.nameAr
                                                  : category.nameEn,
                                              categoryImage:
                                                  category.bannerImagePath,
                                            ));
                                      },
                                      boxFit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  GetBuilder<LanguageController>(
                                      init: Get.find(),
                                      builder: (con) {
                                        return Text(con.lang == 'ar'
                                            ? category.nameAr
                                            : category.nameEn);
                                      }),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
