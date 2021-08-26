import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/spin_widget.dart';
import '../../../common_widgets/cached_image.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../models/cart.dart';

class CartItemWidget extends GetView<CartController> {
  CartItemWidget({
    this.cart,
    this.editDisabled = false,
  });
  final CartItem cart;
  final bool editDisabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: CachedImage(
                    cart.product.imagesPath,
                    radius: 10,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: cart.selectedSalePrice == null ||
                                      cart.selectedSalePrice == 0
                                  ? '${cart.selectedPrice} ' + 'egp'.tr
                                  : '${cart.selectedSalePrice}  ' + 'egp'.tr,
                              color: cart.cartIsGift == 1
                                  ? Colors.red[200]
                                  : Colors.green[400],
                              decoration: cart.cartIsGift == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            CustomText(
                              text: cart.selectedSalePrice != null &&
                                      cart.selectedSalePrice > 0
                                  ? '${cart.selectedPrice}  ' + 'egp'.tr
                                  : '',
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red[200],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'total_price'.tr,
                              color: Colors.black87,
                            ),
                            CustomText(
                              text: '${cart.totalPrice}  ' + 'egp'.tr,
                              color: cart.cartIsGift == 1
                                  ? Colors.red[200]
                                  : Colors.green[400],
                              decoration: cart.cartIsGift == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            editDisabled || cart.cartIsGift == 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: cart.quantity.toString(), size: 17),
                        const SizedBox(width: 30),
                        CustomText(text: cart.selectedPackagingName, size: 17),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red[300],
                            size: 35,
                          ),
                          onPressed: () {
                            controller.deleteFromCart(cart.product.id);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: SpinWidget(
                          onChanged: (value) =>
                              controller.changeQuantity(cart.product.id, value),
                          packageType: cart.selectedPackagingName ?? '',
                          value: cart.quantity,
                          max: cart.product.maxOrder,
                          min: cart.product.minimumOrder,
                          stock: cart.selectedPackagingStock,
                        ),
                      ),
                    ],
                  ),
            if (cart.cartIsGift == 1)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                height: 40,
                width: double.infinity,
                child: Center(
                  child: CustomText(
                    text: 'free_gift'.tr,
                    size: 18,
                    weight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
//
// class AddRemoveWidget extends StatelessWidget {
//   final Function onAddPressed;
//   final Function onRemovePressed;
//   final int quantity;
//   final String packagingName;
//
//   AddRemoveWidget({
//     this.onAddPressed,
//     this.onRemovePressed,
//     this.quantity,
//     this.packagingName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           InkWell(
//             onTap: onAddPressed,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(Icons.add),
//             ),
//           ),
//           CustomText(text: "$quantity"),
//           CustomText(text: "$packagingName"),
//           InkWell(
//             onTap: onRemovePressed,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(10)),
//               child: Icon(Icons.remove),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
