import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/product_card_1.dart';
import '../../../common_widgets/product_list_card_1.dart';
import '../../../controllers/categories_view_controller.dart';
import '../../../models/product.dart';
import '../product_details_screen.dart';

class ProductBuilder1 extends StatelessWidget {
  final List<Product> products;

  ProductBuilder1({@required this.products});

  final CategoriesViewController controller =
      Get.find<CategoriesViewController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: controller.isList.value ? 2 : 2,
        staggeredTileBuilder: (index) {
          return StaggeredTile.fit(controller.isList.value ? 2 : 1);
        },
        // crossAxisCount: controller.isGrid.value ? 1 : 1,
        // staggeredTileBuilder: (index) {
        //   return StaggeredTile.extent(1, 200);
        // },
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          if (controller.isList.value) {
            return ChangeNotifierProvider.value(
              value: product,
              child: ProductListCard1(
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
              child: ProductCard1(
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
