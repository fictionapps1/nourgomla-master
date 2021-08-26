
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../controllers/drop_down_controller.dart';
import '../models/cart.dart';
import '../models/coupon.dart';
import '../models/order_history.dart';
import '../services/api_calls/order_services.dart';

class OrdersController extends GetxController {
  OrderServices _ordersServices = OrderServices.instance;
  ScrollController scrollController = ScrollController();
  final dropDownController = Get.find<DropDownController>();
  List<OrderHistory> orders = [];
  RxBool orderSent = false.obs;
  RxBool loadingMore = false.obs;
  RxBool isLoading = false.obs;
  int itemsPerPage = 10;
  int startIndex = 0;
  int totalCount = 0;

  @override
  onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreOrders();
      }
    });
    getUserOrders();
    super.onInit();
  }

  onClose() {
    scrollController.dispose();
    super.onClose();
  }

  placeOrder(
      {List<CartItem> productsCart,
      String orderComment,
      Coupon userCoupon}) async {
    SettingsController settingsCon = Get.find<SettingsController>();
    List<Map> orderProducts = [];
    productsCart.forEach((cart) {
      orderProducts.add({
        'product_id': cart.product.id,
        'local_id': cart.product.id,
        'name_ar': cart.product.nameAr,
        'name_en': cart.product.nameEn,
        'package_name': cart.selectedPackagingName,
        'package_price': cart.selectedPrice,
        'package_count': cart.selectedPackagingCount,
        'package_type': cart.type,
        'product_count': cart.quantity,
        'price_discount': cart.selectedSalePrice,
        'points': cart.cartItemPoints,
        'image_id': cart.product.imageId,
        'image_path': cart.product.imagesPath,
        'barcode': cart.selectedBarcode,
        'is_gift': cart.cartIsGift,
      });
    });
    print("ORDER PRODUCTS=========================>  $orderProducts");
    final int vendorId = productsCart[0].product.vendorId;



    return await _ordersServices.placeOrder(
        vendorId: settingsCon.isMultiVendor ? vendorId.toString() : '',
        ordersList: orderProducts,
        coupon: userCoupon,
        vendorShipping: '',
        orderComment: orderComment);
  }

  getUserOrders() async {
    startIndex = 0;

    isLoading.value = true;
    final Map<String, dynamic> ordersData = await _ordersServices.getUserOrders(
        itemsPerPage: itemsPerPage,
        startIndex: startIndex,
        sortBy: dropDownController.selectedItem.values);
    orders.assignAll(ordersData['orders']);
    totalCount = ordersData['total_count'];

    isLoading.value = false;
    startIndex = startIndex + itemsPerPage;
    update();
  }

  getMoreOrders() async {
    if (startIndex < totalCount) {
      loadingMore.value = true;
      final Map<String, dynamic> ordersData =
          await _ordersServices.getUserOrders(
              itemsPerPage: itemsPerPage,
              startIndex: startIndex,
              sortBy: dropDownController.selectedItem.values);
      orders.addAll(ordersData['orders']);
      startIndex = startIndex + itemsPerPage;
      loadingMore.value = false;
      update();
    }
  }

  getUserOrderProducts(int id) async {
    return await _ordersServices.getUserOrderProducts(id);
  }
}
