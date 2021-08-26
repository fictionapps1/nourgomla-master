import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/cart_controller.dart';
import '../../../responsive_setup/responsive_builder.dart';

import 'details_row.dart';

class BillWidget extends StatelessWidget {
  final int shippingCost;
  final int  couponPercentage;

  const BillWidget({
    @required this.shippingCost, this.couponPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        child: GetBuilder<CartController>(
            init: Get.find(),
            builder: (con) {
              return Column(
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
                      child: CustomText(
                        text: 'bill_details'.tr,
                        weight: FontWeight.w500,
                        size: 18,
                      ),
                    ),
                  ),
                  DetailsRow(
                      title: 'sub_total'.tr,
                      cost: con.cartTotalPrices.toString()),
                  Divider(),
                  DetailsRow(
                      title: 'shipping_cost'.tr,
                      cost: '$shippingCost',
                      freeShipping: con.freeShipping),
                  if (con.hasDiscount) ...{
                    Divider(),
                    DetailsRow(
                      title: 'bill_discount'.tr,
                      cost: '${con.cartDetails.cartDiscount}',
                    ),
                  },
                  Divider(),
                  DetailsRow(
                      title: 'coupon'.tr,
                      discountVal: con.userCoupon!=null&&con.userCoupon.couponType==1?con.userCoupon.couponValue:null,
                      cost: con.userCoupon != null
                          ? con.couponVal().toStringAsFixed(2)
                          : '0'),
                  Container(
                      height: 40,
                      width: sizingInfo.screenWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: Colors.grey[400]),
                      child: DetailsRow(
                        hPadding: 20,
                        vPadding: 0,
                        title: 'total'.tr, cost: "${con.billAmount(shippingCost)}  ${'egp'.tr}",
                        // cost:
                        //     '${((con.freeShipping ? 0 : shippingCost) + con.cartDetails.totalPriceWithDiscount - (con.couponVal())).roundToDouble()}',
                      )),
                ],
              );
            }),
      );
    });
  }
}
