import '../controllers/settings_controller.dart';
import '../models/product.dart';
import '../models/vendor_category.dart';
import 'package:get/get.dart';
import '../ui/screen_navigator/screen_navigator.dart';
import '../common_widgets/dialogs_and_snacks.dart';
import '../models/cart.dart';
import '../models/coupon.dart';
import '../services/api_calls/cart_services.dart';
import '../services/local_storage/cart_db.dart';
import 'bottom_nav_bar_controller.dart';
import 'vendor_controller.dart';

class CartController extends GetxController {
  RxList<CartItem> cartProducts = [].cast<CartItem>().obs;
  CartServices _cartServices = CartServices.instance;

  RxBool isLoading = false.obs;
  bool dataUpdated = false;
  RxBool editMood = false.obs;
  RxDouble cartTotalPrices = 0.0.obs;
  CartDetails cartDetails;
  Coupon userCoupon;
  int totalPoints = 0;
  String vendorShipping;

  @override
  onInit() {
    getAllProducts();
    super.onInit();
  }

  Future<bool> updateCartData() async {
    if (cartProducts.isNotEmpty) {
      isLoading.value = true;
      List<Map> cartJson = [];
      cartProducts.forEach((cart) {
        if (cart.cartIsGift != 1) {
          cartJson.add(cart.toJson());
        }
      });

      final cartData = await _cartServices.cartUpdate(
          cartJson: cartJson, vendorId: cartProducts[0].product.vendorId);

      if (cartData.isNotEmpty) {
        cartTotalPrices.value = 0.0;
        cartProducts.assignAll(cartData['cart_list']);
        cartDetails = cartData['cart_details'];
        isLoading.value = false;

        editMood.value = false;
        dataUpdated = true;
        cartProducts.forEach((cart) {
          calculatePrice(cart);
          if (cart.cartIsGift != 1) {
            cartTotalPrices.value += cart.totalPrice;
          }
        });
        calculateTotalPoints();

        return true;
      }
      update();
    }
    return false;
  }

  addToCart(CartItem cart) async {
    var dbHelper = CartDbHelper.db;
    if (isProductInCart(cart.product.id)) {
      return;
    }
    if (!isFromTheSameVendor(cart.product.vendorId)) {
      showTwoButtonsDialog(
        title: 'you_cant_add_items_from_different_shops'.tr,
        msg: 'complete_your_previous_order_or_clear_cart'.tr,
        onOkTapped: () {
          Get.offAll(() => ScreenNavigator());
          Future.delayed(Duration.zero, () {
            Get.find<BottomNavBarController>().currentIndex(2);
          });
        },
        onCancelTapped: () {
          clearCart();
          Get.back();
          update();
        },
        cancelText: 'clear_cart'.tr,
        okText: 'complete_previous_order'.tr,
      );

      return;
    }
    final settingsCon = Get.find<SettingsController>();

    if (settingsCon.isMultiVendor) {
      cart.vendorShipping = getVendorShipping(cart.product);
      vendorShipping = cart.vendorShipping;
    }
    subscribeToFcmTopic();
    await dbHelper.insertProduct(cart);

    cartProducts.add(cart);
    calculateTotalPoints();
    changeTotalPrice();
    Get.back();
    refresh();
  }

  getAllProducts() async {
    isLoading.value = true;
    var dbHelper = CartDbHelper.db;
    cartProducts.assignAll(await dbHelper.getAllProducts());
    if(cartProducts.isNotEmpty){
    vendorShipping = cartProducts[0].vendorShipping;
    print(' :::::::::::::::::::::::::::::::::::::::::::::::::::$vendorShipping');
    }
    calculateTotalPoints();
    isLoading.value = false;
    changeTotalPrice();
    refresh();
  }

  subscribeToFcmTopic() {
    // final FirebaseMessaging _fcm = FirebaseMessaging();
    // _fcm.subscribeToTopic('add_to_cart');
    // _fcm.unsubscribeFromTopic('add_to_cart');
  }


  String getVendorShipping(Product product) {
    try {
      final VendorCategory vendor = Get.find<VendorController>()
          .vendorData
          .firstWhere((e) => e.id == product.vendorId);
      print('CART SHIPPING ID ===============> ${vendor.shipping}');
      return vendor.shipping.toString();
    } catch (e) {
      return '';
    }
  }

  deleteFromCart(int productId) {
    CartItem cart = getCartById(productId);
    var dbHelper = CartDbHelper.db;
    cartProducts.remove(cart);
    if (cartProducts.isEmpty) {
      editMood.value = false;
    }
    calculateTotalPoints();
    changeTotalPrice();
    dbHelper.deleteProduct(cart);
    refresh();
  }

  bool isProductInCart(int productId) {
    return cartProducts.isNotEmpty && getCartById(productId) != null;
  }

  void changeQuantity(int productId, int quantity) {
    CartItem cart = getCartById(productId);
    var dbHelper = CartDbHelper.db;
    cart.quantity = quantity;

    calculatePrice(cart);
    calculateTotalPoints();
    dbHelper.updateProductQuantity(cart.quantity, cart.product.id);
    changeTotalPrice();
    refresh();
  }

  void calculatePrice(CartItem cart) {
    switch (cart.type) {
      case 1:
        if (cart.selectedSalePrice != null && cart.selectedSalePrice > 0) {
          cart.totalPrice = double.parse(
              (cart.quantity * cart.selectedSalePrice).toStringAsFixed(2));
        } else {
          cart.totalPrice = double.parse(
              (cart.quantity * cart.product.package1Price).toStringAsFixed(2));
        }
        break;
      case 2:
        if (cart.selectedSalePrice != null && cart.selectedSalePrice > 0) {
          cart.totalPrice = double.parse(
              (cart.quantity * cart.selectedSalePrice).toStringAsFixed(2));
        } else {
          cart.totalPrice =
              (cart.quantity * cart.product.package2Price).toDouble();
        }
        break;
      case 3:
        if (cart.selectedSalePrice != null && cart.selectedSalePrice > 0) {
          cart.totalPrice = double.parse(
              (cart.quantity * cart.selectedSalePrice).toStringAsFixed(2));
        } else {
          cart.totalPrice = double.parse(
              (cart.quantity * cart.product.package3Price).toStringAsFixed(2));
        }
        break;
    }
  }

  void setValues(CartItem cart, int selectedQuantity, int selectedType) {
    cart.quantity = selectedQuantity;
    cart.type = selectedType;
    //cart.totalPrice = (3 * selectedQuantity).toDouble();

    switch (selectedType) {
      case 1:
        cart.selectedPackagingName = cart.product.package1Name;
        cart.selectedPrice = cart.product.package1Price;
        cart.selectedSalePrice = cart.product.price1Sale;
        cart.selectedPackagingStock = cart.product.package1Stock;

        break;
      case 2:
        cart.selectedPackagingName = cart.product.package2Name;
        cart.selectedPrice = cart.product.package2Price;
        cart.selectedSalePrice = cart.product.price2Sale;
        cart.selectedPackagingStock = cart.product.package2Stock;

        break;
      case 3:
        cart.selectedPackagingName = cart.product.package3Name;
        cart.selectedPrice = cart.product.package3Price;
        cart.selectedSalePrice = cart.product.price3Sale;
        cart.selectedPackagingStock = cart.product.package3Stock;

        break;
    }
    calculatePrice(cart);
  }

  CartItem getCartById(int productId) {
    try {
      return cartProducts.firstWhere(
        (element) => element.product.id == productId,
      );
    } catch (e) {
      return null;
    }
  }

  bool isFromTheSameVendor(int vendorId) {
    if (cartProducts.isEmpty) return true;
    try {
      CartItem cart = cartProducts
          .firstWhere((element) => element.product.vendorId == vendorId);
      if (cart != null) return true;
    } catch (e) {
      return false;
    }

    return false;
  }

  changeTotalPrice() {
    cartTotalPrices.value = 0.0;
    cartProducts.forEach((cart) {
      if (cart.cartIsGift != 1) {
        cartTotalPrices.value += cart.totalPrice;
      }
    });
    print(cartTotalPrices.value);
  }

  activateCoupon({String coupon, int amount}) async {
    final activatedCoupon = await _cartServices.activateCoupon(
        coupon: coupon,
        amount: amount,
        hasDiscount: hasDiscount,
        vendorId: cartProducts[0].product.vendorId);

    userCoupon = activatedCoupon;
    update();
  }

  bool get freeShipping => userCoupon != null && userCoupon.freeShipping == 1;
  num couponVal() {
    if (userCoupon != null) {
      if (userCoupon.couponType == 1) {
        return cartTotalPrices * userCoupon.couponValue / 100;
      }
      return userCoupon.couponValue;
    }
    return 0.0;
  }

  String billAmount(int shippingCost) {
    String totalAmount = '';
    if (hasDiscount) {
      totalAmount = ((freeShipping ? 0 : shippingCost) +
              cartDetails.totalPriceWithDiscount -
              couponVal())
          .toStringAsFixed(2);
    } else {
      totalAmount = ((freeShipping ? 0 : shippingCost) +
              cartTotalPrices.value -
              couponVal())
          .toStringAsFixed(2);
    }
    return totalAmount;
  }

  calculateTotalPoints() {
    if (cartProducts.isNotEmpty) {
      totalPoints = 0;

      cartProducts.forEach((cartItem) {
        totalPoints = totalPoints += cartItemPoints(cartItem);
        cartItem.cartItemPoints = cartItemPoints(cartItem);
      });

      update();
    }
  }

  int cartItemPoints(CartItem cart) {
    if (cart.product.points > 0 && cart.quantity > 0) {
      switch (cart.type) {
        case 1:
          return cart.product.package1Count *
              cart.quantity *
              cart.product.points;
          break;
        case 2:
          return cart.product.package1Count *
              cart.product.package2Count *
              cart.quantity *
              cart.product.points;
          break;

        case 3:
          return cart.product.package1Count *
              cart.product.package2Count *
              cart.product.package3Count *
              cart.quantity *
              cart.product.points;
          break;
        default:
          return 1;
      }
    }
    return 0;
  }

  clearCart() {
    var dbHelper = CartDbHelper.db;
    dbHelper.clearCart();
    cartProducts.clear();
    userCoupon = null;
    dataUpdated = false;
    cartDetails = null;
    totalPoints = 0;
    cartTotalPrices.value = 0;
    update();
  }

  bool get hasDiscount =>
      cartDetails != null &&
      cartDetails.cartDiscount != null &&
      cartDetails.cartDiscount != 0;
}
