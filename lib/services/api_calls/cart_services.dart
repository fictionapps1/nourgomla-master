import 'dart:convert';
import 'package:get/get.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/cart.dart';
import '../../models/coupon.dart';
import '../../models/product.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';


class CartServices {
  CartServices._internal();
  static final CartServices _cartServices = CartServices._internal();
  static CartServices get instance => _cartServices;
  final APIService _apiService = APIService();
  final UserController _userController = Get.find<UserController>();
  final LanguageController _langController = Get.find<LanguageController>();

  Future<Map<String, dynamic>> cartUpdate(
      {List<Map> cartJson, int vendorId}) async {
    print('CART DATA TO UPDATE========> $cartJson');
    print('USER ID========> ${_userController.currentUser.id}');
    print('USER ROLE========> ${_userController.currentUser.role}');
    print('USER LANG========> ${_langController.langId()}');
    final Map<String, dynamic> cartData = {};
    final List<CartItem> cartList = [];
    try {
      Map<String, dynamic> json = await _apiService.postData(
        endpoint: Endpoints.cartUpdate,
        body: {
          'user_id': _userController.currentUser.id,
          'created_by': _userController.currentUser.id,
          'source': 1,
          'user_role_id': _userController.currentUser.role,
          'language_id': _langController.langId(),
          'vendor_id': vendorId,
          'products_json': jsonEncode(cartJson),
        },
      );
      final List<dynamic> data = json['data'];
      final cartDetails = CartDetails.fromJson(json);
// print('CART DATA===============>$data');
      print("NEW CART DATA===============>    $json");
      if (data.isNotEmpty) {
        data.forEach((cartProduct) {
          final int type = cartProduct['cart_package_type'];
          final int selectedProductQuantity =
              cartProduct['package_${type}_count'];
          final num selectedProductPrice = cartProduct['package_${type}_price'];
          final num cartTotalPrice =
              selectedProductQuantity * selectedProductPrice.toDouble();
          cartList.add(CartItem(
              cartIsGift: cartProduct['cart_is_gift'],
              type: type,
              quantity: cartProduct['cart_product_count'],
              totalPrice:
                  cartProduct['cart_is_gift'] == 1 ? cartTotalPrice : 0.0,
              selectedPackagingName: cartProduct['package_${type}_name'],
              selectedPrice: cartProduct['package_${type}_price'],
              selectedSalePrice: cartProduct['price_${type}_sale'],
              selectedPackagingCount: cartProduct['package_${type}_count'],
              selectedBarcode: cartProduct['package_${type}_barcode'],
              selectedPackagingStock: cartProduct['package_${type}_stock'],
              product: Product.fromJson(cartProduct)));
        });
      }
      cartData['cart_list'] = cartList;
      cartData['cart_details'] = cartDetails;
      return cartData;
    } catch (e) {
      print("ERROR CART UPDATE       ===============>    $e");
      showErrorDialog('Error Updating Cart Data');
    }
    return cartData;
  }

  Future<Coupon> activateCoupon(
      {String coupon, int amount, bool hasDiscount, int vendorId}) async {
    try {
      print(' VENDOR ID FROM COUPON======>$vendorId');
      final Map<String, dynamic> response =
          await _apiService.postData(endpoint: Endpoints.couponSelect, body: {
        'coupon_code': coupon,
        'cart_amount': amount,
        'user_id': _userController.currentUser.id,
        'language_id': _langController.langId(),
        'vendor_id': vendorId,
      });
      if (response != null) {
        final String msg = response['message'];
        final bool success = response['success'];
        final List data = response['data'];
        print(
            '==========================COUPON RESPONSE ==================>$response');
        if (success) {
          if (data.isNotEmpty) {
            final Map<String, dynamic> couponData = data[0];
            if (hasDiscount) {
              if (couponData['with_offer'] == 0) {
                showNormalDialog(
                    title: 'error'.tr,
                    msg: "sorry_this_coupon_doesnt_work_with_discount".tr);
              } else {
                showNormalDialog(msg: msg, title: '');
                return Coupon.fromJson(couponData);
              }
            } else {
              showNormalDialog(msg: msg, title: '');
              return Coupon.fromJson(couponData);
            }
          }
        } else {
          showNormalDialog(msg: msg, title: '');
        }
      }
    } catch (e) {
      print(
          '=========================================================================>$e');
      showErrorDialog('Error Activating Coupon');
      return null;
    }
    return null;
  }
}
