import 'package:flutter/material.dart';
import '../../../common_widgets/custom_text.dart';
import 'package:get/get.dart';
class DetailsRow extends StatelessWidget {
  final String title;
  final String cost;
  final Color textColor;
  final double hPadding;
  final double vPadding;
  final bool freeShipping;
  final num discountVal;

  DetailsRow(
      {this.title,
      this.cost,
      this.hPadding,
      this.vPadding,
      this.freeShipping = false, this.discountVal, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? 20, vertical: vPadding ?? 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, size: 18, weight: FontWeight.w500),
          if (freeShipping)
            CustomText(
              text: cost,
              size: 14,
              decoration: TextDecoration.lineThrough,
              color: Colors.red[400],
            ),
          if(discountVal!=null)
            CustomText(
              text: "discount".tr+" $discountVal "+" % " + " = ",
              size: 14,
              color: Colors.green[400],
            ),
          CustomText(text: freeShipping ? 'free_shipping'.tr : cost, size: 17,color: textColor,),
        ],
      ),
    );
  }
}
