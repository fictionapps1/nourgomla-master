import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_text.dart';
import '../../controllers/vendors_section_controller.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/drawer.dart';
import '../../common_widgets/nav_animation_state.dart';
import '../../common_widgets/image_button.dart';
import '../../consts/colors.dart';
import '../../controllers/language_controller.dart';
import '../../models/category.dart';
import 'vendor_screen.dart';

class AllVendorsScreen extends StatefulWidget {
  AllVendorsScreen();

  @override
  _AllVendorsScreenState createState() => _AllVendorsScreenState();
}

class _AllVendorsScreenState extends NavAnimationState<AllVendorsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LanguageController _langCon = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorsSectionController>(
      init: Get.find<VendorsSectionController>(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: APP_BG_COLOR,
            drawer: AppDrawer(),
            key: _scaffoldKey,
            appBar: CustomAppBar(
              scaffoldKey: _scaffoldKey,
              centerWidget: CustomText(
                text: 'vendors'.tr,
                size: 20,
                weight: FontWeight.bold,
              ),
              rightWidget: SizedBox(width: 40),
            ),

            body: AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget child) {
                return FadeTransition(
                  opacity: animation,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 30),
                      itemCount: controller.vendors.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        Category category = controller.vendors[index];
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
                                  Get.to(() => VendorScreen(
                                        vendorId: category.id,
                                        title: _langCon.lang == 'ar'
                                            ? category.nameAr
                                            : category.nameEn,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
