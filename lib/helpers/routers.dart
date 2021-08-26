import 'package:get/get.dart';
import '../ui/vendors/vendor_categories_screen.dart';

import '../ui/products/product_details_screen.dart';
import '../ui/products/products_page.dart';

homeRouter({int index, List typesData, List routsIds}) {
  if (typesData[index] == 'category') {
    Get.to(ProductsPage(
      categoryId: routsIds[index],
      title: 'Category',

    ));
  } else if (typesData[index] == 'product') {
    Get.to(ProductDetailsScreen(
      productId: routsIds[index],
      type: '1',
    ));
  }else if (typesData[index] == 'vendor') {
    Get.to(() => VendorCategoriesScreen(
      vendorCategoryId: routsIds[index],
    ));
  }
}
