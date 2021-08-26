import 'dart:convert';
import '../../controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/dialogs_and_snacks.dart';
import '../../controllers/adresses_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/coupon.dart';
import '../../models/order_history.dart';
import '../../models/order_product.dart';
import '../../models/status_history.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
import '../../ui/check_out/order_succeed_screen.dart';

class OrderServices {
  OrderServices._internal();
  static final OrderServices _orderServices = OrderServices._internal();
  static OrderServices get instance => _orderServices;

  final APIService _apiService = APIService();
  final UserController _userController = Get.find<UserController>();
  final CartController _cartController = Get.find<CartController>();

  Future<Map<String, dynamic>> placeOrder({
    List<Map> ordersList,
    Coupon coupon,
    String orderComment,
    String vendorId,
    String vendorShipping,
  }) async {
    bool hasCoupon() => coupon != null;

    final AddressesController _addressesController =
        Get.find<AddressesController>();
    final SettingsController _settingsCon = Get.find<SettingsController>();

    final user = _userController.currentUser;
    final address = _addressesController.selectedAddress;
    final cartDetails = _cartController.cartDetails;
    print(ordersList);

    // print("USER ID ================================>    ${user.id}");

    try {
      final response =
          await _apiService.postData(endpoint: Endpoints.orderInsert, body: {
        'user_id': user.id,
        'user_first_name': user.firstName,
        'user_last_name': user.lastName,
        'user_phone': user.phone,
        'user_email': user.email,
        'user_gender': user.gender,
        'address_id': address.id,
        'address_longitude': address.areaLng,
        'address_latitude': address.areaLat,
        'address_address': address.address,
        'area_id': address.areaId,
        'area_name_ar': address.areaNameAr,
        'area_name_en': address.areaNameEn,
        'area_shipping': _settingsCon.isMultiVendor
            ? _cartController.vendorShipping
            : address.cost,
        'area_latitude': address.areaLat,
        'area_longitude': address.areaLng,
        'coupon_id': hasCoupon() ? coupon.id : '',
        'coupon_code': hasCoupon() ? coupon.couponCode : '',
        'coupon_type': hasCoupon() ? coupon.couponType : '',
        'coupon_value': hasCoupon() ? coupon.couponValue : '',
        'coupon_with_offer': hasCoupon() ? coupon.withOffer : '',
        'coupon_free_shipping': hasCoupon() ? coupon.freeShipping : '',
        'coupon_cart_maximum': hasCoupon() ? coupon.cartMaximum : '',
        'coupon_cart_minimum': hasCoupon() ? coupon.cartMinimum : '',
        'offer_cart_minimum':
            cartDetails != null ? cartDetails.offerCartMinimum : '',
        'offer_cart_maximum':
            cartDetails != null ? cartDetails.offerCartMaximum : '',
        'offer_cart_discount':
            cartDetails != null ? cartDetails.offerCartDiscount : '',
        'offer_discount_type':
            cartDetails != null ? cartDetails.offerDiscountType : '',
        'created_by': user.id,
        'user_role_id': user.role,
        'order_comment': orderComment,
        'vendor_id': vendorId,
        'orders_products_json': jsonEncode(ordersList),
      });
      if (response != null) {
        if (response['success'] == true) {
          Get.offAll(() => OrderSucceedScreen());
          _cartController.clearCart();
        } else {
          Get.defaultDialog(title: 'Error Placing Order', content: Text(''));
        }
      }
      return response;
    } catch (e) {
      print(e);
      showErrorDialog('Error Placing Order');
      return {};
    }
  }

  Future<Map<String, dynamic>> getUserOrders(
      {int itemsPerPage, int startIndex, String sortBy}) async {
    Map<String, dynamic> ordersData = {};
    try {
      final response =
          await _apiService.postData(endpoint: Endpoints.ordersSelect, body: {
        'itemsPerPage': itemsPerPage,
        'startIndex': startIndex,
        'user_id': _userController.currentUser.id,
        'sort_by': sortBy,
        'vendor_id': '',
      });

      final List data = response['data'];
      print(response);
      ordersData['orders'] =
          data.map((order) => OrderHistory.fromJson(order)).toList();
      ordersData['total_count'] = response['totalCount'];
      print("ORDERS DATA===========================> $data");
      return ordersData;
    } catch (e) {
      showErrorDialog('Error Loading Orders Data');
      return ordersData;
    }
  }

  Future<Map<String, dynamic>> getUserOrderProducts(int id) async {
    Map<String, dynamic> orderProductData = {};
    try {
      final response = await _apiService.postData(
          endpoint: Endpoints.ordersProductsSelect, body: {'order_id': id});

      final List ordersProducts = response['orders_products'];
      final List ordersStatusHistory = response['orders_status_history'];

      orderProductData['orders_products'] =
          ordersProducts.map((order) => OrderProduct.fromJson(order)).toList();
      orderProductData['orders_status_history'] = ordersStatusHistory
          .map((order) => StatusHistory.fromJson(order))
          .toList();
      print(ordersStatusHistory);
      return orderProductData;
    } catch (e) {
      print('================================>$e');
      showErrorDialog('Error Loading Order Products Data');
      return orderProductData;
    }
  }
}
