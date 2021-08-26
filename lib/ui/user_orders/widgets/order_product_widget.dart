import 'package:flutter/material.dart';
import '../../../common_widgets/cached_image.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/language_controller.dart';
import '../../../models/order_product.dart';

import '../../../responsive_setup/responsive_builder.dart';
import '../../../ui/check_out/widgets/details_row.dart';
import 'package:get/get.dart';

class OrderProductWidget extends StatelessWidget {
  final OrderProduct orderProduct;
  OrderProductWidget({
    this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
          child: Column(
            children: [
              Container(
                height: 40,
                width: sizingInfo.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.grey[400]),
                child: Center(
                  child: GetBuilder<LanguageController>(
                      init: Get.find(),
                      builder: (langCon) {
                        return CustomText(
                          text:
                              ' ${langCon.lang == 'en' ? orderProduct.nameEn : orderProduct.nameAr}',
                          weight: FontWeight.w500,
                          size: 18,
                        );
                      }),
                ),
              ),
              CachedImage(
                orderProduct.imagePath,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
                radius: 10,
              ),
              DetailsRow(
                  title: 'package_price'.tr,
                  cost: orderProduct.packagePrice.toString()),
              Divider(),
              DetailsRow(
                title: 'product_count'.tr,
                cost: orderProduct.productCount.toString(),
              ),
              Divider(),
              DetailsRow(
                title: 'package_name'.tr,
                cost: orderProduct.packageName,
              ),
              if (orderProduct.isGift == 1) ...{
                Container(
                  height: 40,
                  width: sizingInfo.screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: Colors.green[400]),
                  child: CustomText(
                    text: 'free_gift'.tr,
                    weight: FontWeight.w500,
                    size: 18,
                  ),
                ),
              } else ...{
                Divider(),
                DetailsRow(
                  title: 'points'.tr,
                  cost: orderProduct.points.toString(),
                ),
                Divider(),
                DetailsRow(
                  title: 'price_discount'.tr,
                  cost: orderProduct.priceDiscount.toString(),
                ),

              }
            ],
          ),
        ),
      );
    });
  }
}
