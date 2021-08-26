import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:get/get.dart';

class PackagingInfoWidget1Lines extends StatelessWidget {
  final String packagingName;
  final String unitName;
  final String packagingCount;
  final String price;
  final String salePrice;

  PackagingInfoWidget1Lines({
    this.packagingName,
    this.packagingCount,
    this.price,
    this.salePrice,
    this.unitName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(text: '$packagingName'),
        const SizedBox(width: 10),
        CustomText(
            text:
                salePrice == null || salePrice == '0' ? '$price' : '$salePrice',
            color: Colors.green[300]),
        const  SizedBox(width: 5),
        CustomText(text: "egp".tr),
        if (salePrice != null && salePrice != '0') Spacer(),
        if (salePrice != null && salePrice != '0')
          Text(
            "$price",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.red[300],
            ),
          ),
      ],
    );
  }
}
