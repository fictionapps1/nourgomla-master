import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:get/get.dart';
class PackagingInfoWidget2Lines extends StatelessWidget {
  final String packagingName;
  final String unitName;
  final String packagingCount;
  final String price;
  final String salePrice;

  PackagingInfoWidget2Lines({
    this.packagingName,
    this.packagingCount,
    this.price,
    this.salePrice,
    this.unitName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(text: '$packagingName'   +' = '+ '$packagingCount $unitName'),
        // SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text: salePrice == null || salePrice == '0'
                    ? '$price'
                    : '$salePrice',
                color: Colors.green[300]),
            CustomText(text:'   '+"egp".tr),
            if (salePrice != null && salePrice != '0') Spacer(),
            if (salePrice != null && salePrice != '0')
              Text(
                "$price  "+"egp".tr,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.red[300],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
