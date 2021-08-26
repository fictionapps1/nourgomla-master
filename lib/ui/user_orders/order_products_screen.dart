import 'package:flutter/material.dart';
import '../../common_widgets/devider_row.dart';
import '../../common_widgets/custom_text.dart';
import '../../consts/colors.dart';
import '../../controllers/settings_controller.dart';
import '../../helpers/hex_color.dart';
import '../../models/status_history.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../services/api_calls/order_services.dart';
import '../../ui/user_orders/widgets/order_product_widget.dart';
import '../../common_widgets/loading_view.dart';
import 'package:get/get.dart';

class OrderProductsScreen extends StatelessWidget {
  final OrderServices _ordersServices = OrderServices.instance;
  final int id;
  final SettingsController _settingsCon = Get.find<SettingsController>();

  OrderProductsScreen(this.id);
  //
  // List<StatusHistory> history = [
  //   StatusHistory(
  //     color: 'FFE0E0E0',
  //     nameEn: 'Pending',
  //   ),
  //   StatusHistory(
  //     color: 'FFFFCC80',
  //     nameEn: 'On The Way',
  //   ),
  //   StatusHistory(
  //     color: 'FFA5D6A7',
  //     nameEn: 'Delivered',
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_COLOR,
      appBar: AppBar(
          title: Text(
            'order_products'.tr,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: _settingsCon.color1),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _ordersServices.getUserOrderProducts(id),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return ResponsiveBuilder(builder: (context, sizingInfo) {
              return Container(
                width: sizingInfo.screenWidth,
                height: sizingInfo.screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),
                      DividerRow('order_status'.tr),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  snapshot.data['orders_status_history'].length,
                              itemBuilder: (context, index) {
                                return snapshot
                                            .data['orders_status_history']
                                                [index]
                                            .nameEn !=
                                        null
                                    ? StatusHistoryWidget(
                                        statusHistory: snapshot
                                                .data['orders_status_history']
                                            [index],
                                        isLast: snapshot
                                                    .data[
                                                        'orders_status_history']
                                                    .length -
                                                1 ==
                                            index,
                                      )
                                    : Container();
                              }),
                        ),
                      ),
                      const SizedBox(height: 30),
                      DividerRow('order_products'.tr),
                      const SizedBox(height: 10),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data['orders_products'].length,
                          itemBuilder: (context, index) {
                            return OrderProductWidget(
                              orderProduct: snapshot.data['orders_products']
                                  [index],
                            );
                          }),
                    ],
                  ),
                ),
              );
            });
          }
          return LoadingView();
        },
      ),
    );
  }
}

class StatusHistoryWidget extends StatelessWidget {
  final StatusHistory statusHistory;
  final bool isLast;

  StatusHistoryWidget({this.statusHistory, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    print(isLast);
    return Column(
      children: [
        ResponsiveBuilder(builder: (context, sizingInfo) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: sizingInfo.screenWidth,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor(statusHistory.color),
              ),
              child: CustomText(
                  text: statusHistory.nameEn,
                  size: 17,
                  weight: FontWeight.w400),
            ),
          );
        }),
        if (!isLast)
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Icon(Icons.arrow_downward_rounded),
            Icon(Icons.arrow_downward_rounded),
          ]),
      ],
    );
  }
}
