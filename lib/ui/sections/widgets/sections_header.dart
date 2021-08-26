import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/loading_view.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/categories_controller.dart';
import '../../../controllers/settings_controller.dart';
import '../../../models/category_type.dart';

class SectionsHeader extends GetView<CategoriesController> {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return controller.categoriesTypes.length > 0
        ? Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.separated(
                  itemCount: controller.categoriesTypes.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                  itemBuilder: (context, index) {
                    CategoryType categoryType =
                        controller.categoriesTypes[index];
                    return Obx(() {
                      bool isSelected =
                          controller.categoryType.value == categoryType.id;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              isSelected ? _settingsCon.color4 : Colors.white,
                        ),
                        width: 120,
                        child: TextButton(
                          onPressed: () =>
                              controller.categoryType.value = categoryType.id,
                          child: GetBuilder<LanguageController>(
                              init: Get.find(),
                              builder: (con) {
                                return Text(con.lang == 'ar'
                                    ? categoryType.nameAr
                                    : categoryType.nameEn);
                              }),
                          style: TextButton.styleFrom(
                            primary: isSelected ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
          )
        : LoadingView();
  }
}
