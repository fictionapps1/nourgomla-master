import 'package:get/get.dart';
import '../../../controllers/language_controller.dart';
import '../../../models/category.dart';

import '../products_page.dart';
Future navigateToNextCategory({Category category,String categoryImage,String vendorId}) {
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