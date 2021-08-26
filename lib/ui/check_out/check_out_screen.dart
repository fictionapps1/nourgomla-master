import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_text.dart';
import '../../consts/colors.dart';
import '../../controllers/adresses_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/orders_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../ui/cart/widgets/cart_tile_widget.dart';
import '../../ui/check_out/widgets/bill_widget.dart';
import '../../ui/check_out/widgets/bounus_widget.dart';
import '../../ui/user_addresses/widgets/address_row.dart';

import 'widgets/bill_mini_product_widget.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final TextEditingController _textController = TextEditingController();
  final ordersController = Get.put<OrdersController>(OrdersController());
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_COLOR,
      appBar: AppBar(
        title: Text('my_order'.tr, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: _settingsCon.color1,
      ),
      body: ResponsiveBuilder(builder: (context, sizingInfo) {
        return GetBuilder<CartController>(
            init: Get.find(),
            builder: (cartController) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: GetBuilder<AddressesController>(
                          init: Get.find(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        cartController.cartProducts.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        _settingsCon.billProductWidget == '1'
                                            ? CartItemWidget(
                                                cart: cartController
                                                    .cartProducts[index],
                                                editDisabled: true,
                                              )
                                            : BillMiniProductWidget(
                                                cartController
                                                    .cartProducts[index]),
                                  ),
                                ),
                                Container(
                                  height: 140,
                                  child: AddressRow(
                                    checkOutMood: true,
                                    cost: controller.selectedAddress.cost
                                        .toString(),
                                    addressName:
                                        controller.selectedAddress.address,
                                    area: controller.selectedAddress.areaNameEn,
                                    addressModel: controller.selectedAddress,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: BonusWidget(
                                    title: 'coupon'.tr,
                                    buttonText: 'activate_coupon'.tr,
                                    hint: 'enter_your_coupon'.tr,
                                    onButtonTapped: (text) {
                                      if (text != '') {
                                        print(text);
                                        cartController.activateCoupon(
                                            coupon: text,
                                            amount: cartController
                                                .cartTotalPrices
                                                .toInt());
                                      }
                                    },
                                  ),
                                ),
                                if (_settingsCon.pointsEnabled)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: BonusWidget(
                                      title: 'the_points'.tr,
                                      buttonText: 'use_points'.tr,
                                      hint:
                                          'use_your_points_to_get_discount'.tr,
                                      pointsInfo: 'you_have'.tr +
                                          '  ${cartController.totalPoints}   ' +
                                          'points'.tr,
                                      onButtonTapped: (text) {
                                        if (text != '') {
                                          // cartController.activateCoupon(
                                          //     coupon: text,
                                          //     amount: cartController
                                          //         .userCoupon.couponValue);
                                        }
                                      },
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: BillWidget(
                                    shippingCost:
                                        controller.selectedAddress.cost,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: NotesWidget(
                                    title: 'notes'.tr,
                                    hint: 'enter_your_notes'.tr,
                                    textController: _textController,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print(cartController.cartProducts[0].product.vendorId);
                      await ordersController.placeOrder(
                          productsCart: cartController.cartProducts,
                          orderComment: _textController.text,
                          userCoupon: cartController.userCoupon);
                    },
                    child: Container(
                      height: 50,
                      width: sizingInfo.screenWidth,
                      decoration: BoxDecoration(color: Colors.green),
                      child: Center(
                        child: CustomText(
                          text: 'place_order'.tr,
                          weight: FontWeight.w500,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}
