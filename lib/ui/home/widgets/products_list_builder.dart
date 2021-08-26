import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/product_card_1.dart';
import '../../../models/product.dart';
import 'package:get/get.dart';
import '../../../ui/products/product_details_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsListBuilder extends StatelessWidget {
  final bool isVertical;
  final List<Product> products;
  ProductsListBuilder({this.isVertical, this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isVertical ? null : 550,
      child: GridView.builder(
          physics: isVertical ? NeverScrollableScrollPhysics() : null,
          scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: isVertical ? 0.33 : 3.3,
            crossAxisCount: isVertical ? 2 : 1,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];
            return ChangeNotifierProvider.value(
              value: product,
              child: ProductCard1(
                isFromHomeScreen: true,
                product: product,
                onCardPressed: () => Get.to(
                  () => ProductDetailsScreen(product: product),
                ),

              ),
            );
          }),
    );
  }
}

class ProductsListBuilderVertical extends StatelessWidget {
  final List<Product> products;
  ProductsListBuilderVertical({this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.countBuilder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,

          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          staggeredTileBuilder: (index) {
            return StaggeredTile.fit(1);
          },
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];
            return ChangeNotifierProvider.value(
              value: product,
              child: ProductCard1(

                product: product,
                onCardPressed: () => Get.to(
                  () => ProductDetailsScreen(product: product),
                ),

              ),
            );
          }),
    );
  }
}
