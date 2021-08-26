import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/product_card_2.dart';
import '../../../common_widgets/product_list_card_2.dart';
import '../../../controllers/settings_controller.dart';
import '../../../controllers/categories_view_controller.dart';
import '../../../models/product.dart';

import '../product_details_screen.dart';

class ProductBuilder2 extends StatelessWidget {
  final List<Product> products;

  ProductBuilder2({@required this.products});

  final CategoriesViewController controller =
      Get.find<CategoriesViewController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();
  double _gridHeightRatio() {
    switch (_settingsCon.availablePackaging) {
      case 1:
        return .67;
      case 2:
        return .61;
      case 3:
        return .55;
      default:
        return .55;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: controller.isList.value ? 1 : 2,
          childAspectRatio: controller.isList.value?1.5:_gridHeightRatio()
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          if (controller.isList.value) {
            return ChangeNotifierProvider.value(
              value: product,
              child: ProductListCard2(
                product: product,
                onAddToCartPressed: () {},
                onCardPressed: () => Get.to(
                  () => ProductDetailsScreen(product: product),
                ),
              ),
            );
          } else {
            return ChangeNotifierProvider.value(
              value: product,
              child: ProductCard2(
                product: product,
                onCardPressed: () => Get.to(
                  () => ProductDetailsScreen(product: product),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
