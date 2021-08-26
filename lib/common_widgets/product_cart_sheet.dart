import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../common_widgets/spin_widget.dart';
import 'custom_text.dart';
import '../controllers/cart_controller.dart';
import '../models/cart.dart';
import '../models/product.dart';

class ProductCartSheet extends StatefulWidget {
  final Product product;

  ProductCartSheet({@required this.product});

  @override
  _ProductCartSheetState createState() => _ProductCartSheetState();
}

class _ProductCartSheetState extends State<ProductCartSheet> {
  final CartItem cart = CartItem();
  final CartController controller = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    cart.product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final SettingsController _settingsCon = Get.find<SettingsController>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: isSelected(packageType: 1)
                    ? Colors.grey[200]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(
                    text: widget.product.package1Name,
                    size: 20,
                  ),
                ),
                CustomText(
                  text: widget.product.price1Sale == 0 ||
                          widget.product.price1Sale == null
                      ? '${widget.product.package1Price}  ' + 'egp'.tr
                      : '${widget.product.price1Sale}  ' + 'egp'.tr,
                  color: Colors.green[400],
                  size: 20,
                ),
                Expanded(
                  child: SpinWidget(
                    onChanged: (value) => setValue(value, 1),
                    value: isSelected(packageType: 1) ? cart.quantity : 0,
                    max: cart.product.maxOrder,
                    min: cart.product.minimumOrder,
                    stock: cart.product.package1Stock,
                  ),
                ),
              ],
            ),
          ),
          if (widget.product.package2Name != null &&
              widget.product.package2Name != '' &&
              _settingsCon.availablePackaging > 1) ...{
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: isSelected(packageType: 2)
                      ? Colors.grey[200]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomText(
                      text: widget.product.package2Name,
                      size: 20,
                    ),
                  ),
                  CustomText(
                    text: widget.product.price2Sale == 0 ||
                            widget.product.price2Sale == null
                        ? '${widget.product.package2Price}  ' + 'egp'.tr
                        : '${widget.product.price2Sale}  ' + 'egp'.tr,
                    color: Colors.green,
                    size: 20,
                  ),
                  Expanded(
                    child: SpinWidget(
                      onChanged: (value) => setValue(value, 2),
                      value: isSelected(packageType: 2) ? cart.quantity : 0,
                      max: cart.product.maxOrder,
                      min: cart.product.minimumOrder,
                      stock: cart.product.package2Stock,
                    ),
                  ),
                ],
              ),
            ),
          },
          if (widget.product.package3Name != null &&
              widget.product.package3Name != '' &&
              _settingsCon.availablePackaging > 2) ...{
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: isSelected(packageType: 3)
                      ? Colors.grey[200]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomText(
                      text: widget.product.package3Name,
                      size: 20,
                    ),
                  ),
                  CustomText(
                    text: widget.product.price3Sale == 0 ||
                            widget.product.price3Sale == null
                        ? '${widget.product.package3Price}  ' + 'egp'.tr
                        : '${widget.product.price3Sale}  ' + 'egp'.tr,
                    color: Colors.green,
                    size: 20,
                  ),
                  Expanded(
                    child: SpinWidget(
                      onChanged: (value) => setValue(value, 3),
                      value: isSelected(packageType: 3) ? cart.quantity : 0,
                      max: cart.product.maxOrder,
                      min: cart.product.minimumOrder,
                      stock: cart.product.package3Stock,
                    ),
                  ),
                ],
              ),
            ),
          },
          const SizedBox(height: 10),
          IgnorePointer(
            ignoring: cart.type == null,
            child: Container(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {
                  controller.addToCart(cart);
                },
                color: _settingsCon.color2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.add_shopping_cart),
                    CustomText(
                      text: 'add_to_cart'.tr,
                      color: Colors.black,
                      size: 18,
                    ),
                    CustomText(
                      text: '${cart.totalPrice ?? ''}  ' + 'egp'.tr,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void setValue(int selectedQuantity, int selectedType) {
    setState(() => controller.setValues(cart, selectedQuantity, selectedType));
  }

  bool isSelected({@required int packageType}) {
    return cart.type != null && cart.type == packageType;
  }
}
