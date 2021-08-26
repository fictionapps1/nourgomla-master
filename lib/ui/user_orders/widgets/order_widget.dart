import 'package:flutter/material.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/language_controller.dart';
import '../../../models/order_history.dart';
import '../../../responsive_setup/responsive_builder.dart';
import '../../../ui/check_out/widgets/details_row.dart';
import 'package:get/get.dart';
import '../../../helpers/hex_color.dart';
class OrderWidget extends StatelessWidget {
  final LanguageController _langCon = Get.find<LanguageController>();
  final OrderHistory orderHistory;
  OrderWidget({
    this.orderHistory,
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
                  child: CustomText(
                    text: 'order_code'.tr + ' ' + '  ${orderHistory.id}',
                    weight: FontWeight.w500,
                    size: 18,
                  ),
                ),
              ),
              DetailsRow(title: 'order_date'.tr, cost: orderHistory.createdAt),
              Divider(),
              // DetailsRow(title: 'total'.tr, cost: 'not specified'),
              // Divider(),
              DetailsRow(
                title: 'shipping_cost'.tr,
                cost: orderHistory.areaShipping.toString(),
                freeShipping:
                    orderHistory.couponFreeShipping == 1 ? true : false,
              ),
              Divider(),
              DetailsRow(
                title: 'order_status'.tr,
                cost: _langCon.lang == 'ar'
                    ? orderHistory.ordersStatusHistoryNameAr
                    : orderHistory.ordersStatusHistoryNameEn,
                textColor: HexColor(orderHistory.ordersStatusHistoryColor),
              ),
            ],
          ),
        ),
      );
    });
  }
}
