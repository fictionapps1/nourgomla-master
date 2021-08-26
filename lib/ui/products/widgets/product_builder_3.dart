import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/product_card_3.dart';
import '../../../common_widgets/product_list_card_3.dart';
import '../../../controllers/settings_controller.dart';
import '../../../controllers/categories_view_controller.dart';
import '../../../models/product.dart';

import '../product_details_screen.dart';

class ProductBuilder3 extends StatelessWidget {
  final List<Product> products;

  ProductBuilder3({@required this.products});

  final CategoriesViewController controller =
      Get.find<CategoriesViewController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();

  double _gridHeightRatio() {
    switch (_settingsCon.availablePackaging) {
      case 1:
        return .6;
      case 2:
        return .51;
      case 3:
        return .45;
      default:
        return .45;
    }
  }
  double _listHeightRatio() {
    switch (_settingsCon.availablePackaging) {
      case 1:
        return 1.5;
      case 2:
        return 1.5;
      case 3:
        return 1.29;
      default:
        return 1.29;
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
            childAspectRatio: controller.isList.value ? _listHeightRatio() : _gridHeightRatio()),
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          if (controller.isList.value) {
            return ChangeNotifierProvider.value(
              value: product,
              child: ProductListCard3(
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
              child: ProductCard3(
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
