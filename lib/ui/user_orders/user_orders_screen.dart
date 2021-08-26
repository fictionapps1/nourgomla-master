import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/empty_view.dart';
import '../../consts/colors.dart';
import '../../controllers/drop_down_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../models/drop_down_list_data.dart';
import '../../ui/user_orders/order_products_screen.dart';
import '../../ui/user_orders/widgets/order_widget.dart';
import '../../common_widgets/loading_view.dart';
import '../../controllers/settings_controller.dart';

class UserOrdersScreen extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();

  final dropDownController = Get.find<DropDownController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
        init: Get.put(OrdersController()),
        builder: (orderController) {
          return Scaffold(
              backgroundColor: APP_BG_COLOR,
              appBar: AppBar(
                  title: Text('my_orders'.tr),
                  centerTitle: true,
                  actions: [
                    GetBuilder<DropDownController>(
                        init: dropDownController,
                        builder: (dropController) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: DropdownButton<ListItem>(
                                  icon: Icon(
                                    Icons.filter_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  dropdownColor: _settingsCon.color2,
                                  underline: SizedBox(),
                                  isDense: true,
                                  value: dropController.selectedItem,
                                  items: dropController.dropdownMenuItems,
                                  onChanged: (value) async {
                                    dropController.selectedItem = value;
                                    dropController.update();
                                    orderController.getUserOrders();
                                  }),
                            ),
                          );
                        }),
                  ],
                  backgroundColor: _settingsCon.color1),
              body: GetX<OrdersController>(
                init: OrdersController(),
                builder: (con) => con.isLoading.value
                    ? LoadingView()
                    : orderController.orders.isEmpty
                        ? EmptyView(text:'no_orders_added_yet'.tr)
                        : Stack(
                            children: [
                              ListView.builder(
                                  controller: orderController.scrollController,
                                  itemCount: orderController.orders.length,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          Get.to(OrderProductsScreen(
                                              orderController
                                                  .orders[index].id));
                                        },
                                        child: OrderWidget(
                                          orderHistory:
                                              orderController.orders[index],
                                        ),
                                      )),
                              if (con.loadingMore.value)
                                Positioned(
                                    bottom: 0,
                                    left: 40,
                                    right: 40,
                                    child: LoadingView())
                            ],
                          ),
              ));
        });
  }
}
