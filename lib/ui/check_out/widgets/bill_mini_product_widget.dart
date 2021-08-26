import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/language_controller.dart';
import '../../../models/cart.dart';
import 'package:get/get.dart';

class BillMiniProductWidget extends StatelessWidget {
  final CartItem cart;

  BillMiniProductWidget(this.cart);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Column(
            children: [
              GetBuilder<LanguageController>(
                  init: Get.find(),
                  builder: (langCon) {
                    return CustomText(
                      text: langCon.lang == 'ar'
                          ? cart.product.nameAr
                          : cart.product.nameEn,
                      size: 17,
                      weight: FontWeight.w500,
                    );
                  }),
              if (cart.cartIsGift == 1) ...{
                Container(
                  width: 360,
                  color: Colors.green[100],
                  child: CustomText(text: 'free_gift'.tr),
                )
              } else ...{
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: ' ${cart.selectedPrice} ' + 'egp'.tr),
                    CustomText(text: ' * '),
                    CustomText(text: ' ${cart.quantity} '),
                    // CustomText(
                    //     text: ' ${cart.quantity} ' +
                    //         ' ${cart.selectedPackagingName} '),
                    CustomText(text: ' = '),
                    CustomText(text: '  ${cart.totalPrice}  ' + 'egp'.tr),
                  ],
                ),
              }
            ],
          )),
    );
  }
}
