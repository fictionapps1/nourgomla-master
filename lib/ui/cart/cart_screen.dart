import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_appbar.dart';
import '../../common_widgets/drawer.dart';
import '../../common_widgets/empty_view.dart';
import '../../common_widgets/nav_animation_state.dart';
import '../../common_widgets/custom_text.dart';
import '../../ui/user_profile/profile_screen.dart';
import '../../common_widgets/loading_view.dart';
import '../../consts/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/user_controller.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../ui/account/login_options_screen.dart';
import '../../ui/cart/widgets/cart_tile_widget.dart';
import '../../ui/user_addresses/user_addresses.dart';
import '../../common_widgets/dialogs_and_snacks.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends NavAnimationState<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final CartController controller = Get.find<CartController>();
  final UserController userController = Get.find<UserController>();
  final SettingsController _settingsCon = Get.find<SettingsController>();

  @override
  void initState() {

    if (userController.loggedIn) {
      Future.delayed(Duration.zero, () {
        controller.updateCartData().then((value) {
          if (value == true) {
            controller.dataUpdated = true;
          }
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final width = sizeConfig.screenWidth;
      return SafeArea(
        child: Scaffold(
          backgroundColor: APP_BG_COLOR,
          key: _scaffoldKey,
          drawer: AppDrawer(),
          appBar: CustomAppBar(
            scaffoldKey: _scaffoldKey,
            centerWidget: CustomText(
                text: 'my_cart'.tr, size: 18, weight: FontWeight.w500),
            rightWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () => controller.isLoading.value
                    ? LoadingView()
                    : InkWell(
                        onTap: () {
                          controller.editMood.toggle();
                          if (!controller.editMood.value &&
                              userController.loggedIn) {
                            controller.updateCartData().then((value) {
                              if (value == true) {
                                controller.dataUpdated = true;
                              }
                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1,
                                  color: controller.editMood.value
                                      ? Colors.white
                                      : Colors.transparent)),
                          child: Icon(
                            controller.editMood.value
                                ? Icons.check
                                : Icons.edit,
                            color: controller.editMood.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        )),
              ),
            ),
          ),
          // AppBar(title: Text('My Cart'), centerTitle: true),
          body: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return FadeTransition(
                  opacity: animation,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 100 * (1.0 - animation.value), 0.0),
                      child: child));
            },
            child: GetBuilder<CartController>(builder: (cartController) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Obx(
                        () => cartController.isLoading.value
                            ? LoadingView()
                            : cartController.cartProducts.isEmpty
                                ? EmptyView(
                                    text: 'cart_is_empty'.tr,
                                    image: 'assets/empty_cart.png',
                                  )
                                : Column(
                                    children: [
                                      if (_settingsCon.pointsEnabled &&
                                          cartController.totalPoints > 0)
                                        Container(
                                          width: sizeConfig.widgetWidth,
                                          height: 30,
                                          color: Colors.grey[300],
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                  text:
                                                      'complete_this_order_to_get'
                                                          .tr,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: CustomText(
                                                    text: cartController
                                                        .totalPoints
                                                        .toString(),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                CustomText(
                                                  text: 'points'.tr,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (cartController.hasDiscount)
                                        Container(
                                          width: sizeConfig.widgetWidth,
                                          height: 30,
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                  text: 'you_got_bill_discount'
                                                      .tr,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: CustomText(
                                                    text: cartController
                                                        .cartDetails
                                                        .cartDiscount
                                                        .toStringAsFixed(2),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                CustomText(
                                                  text: 'egp'.tr,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: cartController
                                              .cartProducts.length,
                                          itemBuilder: (context, index) {
                                            return Obx(
                                              () => CartItemWidget(
                                                editDisabled:
                                                    !controller.editMood.value,
                                                cart: cartController
                                                    .cartProducts[index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: InkWell(
                      onTap: () {
                        onOrderButtonPressed(cartController);
                      },
                      child: AnimatedContainer(
                        child: Center(
                          child: cartController.hasDiscount
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomText(
                                        text: controller.dataUpdated
                                            ? 'place_order'.tr
                                            : 'confirm_cart'.tr,
                                        size: 17),
                                    CustomText(
                                        text: controller.cartDetails.totalPrice
                                            .toStringAsFixed(2),
                                        decoration: TextDecoration.lineThrough,
                                        size: 17),
                                    CustomText(
                                        text: controller
                                            .cartDetails.totalPriceWithDiscount
                                            .toStringAsFixed(2),
                                        size: 17),
                                    CustomText(text: 'egp'.tr, size: 17),
                                  ],
                                )
                              : CustomText(
                                  text: controller.dataUpdated
                                      ? 'place_order'.tr +
                                          '  ${controller.cartDetails.totalPrice.toStringAsFixed(2)}  ' +
                                          'egp'.tr
                                      : 'confirm_cart'.tr +
                                          '  ${controller.cartTotalPrices.toStringAsFixed(2)}  ' +
                                          'egp'.tr,
                                  size: 17),
                        ),
                        color: controller.dataUpdated
                            ? Color(0xFF66BB6A)
                            : Color(0xFFFFB74D),
                        width: width,
                        height: controller.cartProducts.isEmpty ||
                                controller.editMood.value
                            ? 0
                            : 45,
                        duration: Duration(milliseconds: 300),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }

  onOrderButtonPressed(CartController cartController) {
    if (cartController.dataUpdated && userController.loggedIn) {
      if (_settingsCon.activationRequired) {
        if (userController.currentUser.isActivated == 1) {
          Get.to(UserAddressesScreen(isInOrderMood: true));
        } else {
          showNormalDialog(
              title: 'you_need_to_activate_your_account'.tr,
              msg: 'click_button_below_and_send_required_documents'.tr,
              buttonText: 'send_documents'.tr,
              onTapped: () {
                Get.back();
                Get.to(ProfileScreen());
              });
        }
      } else {
        Get.to(UserAddressesScreen(isInOrderMood: true));
      }
    } else if (cartController.dataUpdated && !userController.loggedIn) {
      Get.to(LoginOptionsScreen());
    } else if (!cartController.dataUpdated && !userController.loggedIn) {
      Get.to(LoginOptionsScreen());
    } else if (!cartController.dataUpdated && userController.loggedIn) {
      cartController.updateCartData();
    }
  }
}
