import 'package:json_annotation/json_annotation.dart';
import '../models/product.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartItem {
  Product product;
  int quantity;
  int type;
  double totalPrice;
  String selectedPackagingName;
  String selectedBarcode;
  num selectedPrice;
  num selectedSalePrice;
  int cartItemPoints;
  int selectedPackagingCount;
  int selectedPackagingStock;
  int cartIsGift;
  String vendorShipping;

  CartItem({
    this.product,
    this.quantity,
    this.type,
    this.totalPrice,
    this.selectedPackagingName,
    this.selectedPrice,
    this.selectedSalePrice,
    this.cartItemPoints = 0,
    this.selectedPackagingCount,
    this.selectedBarcode,
    this.selectedPackagingStock,
    this.cartIsGift,
    this.vendorShipping,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'product_id': this.product.id,
      'package_type': this.type,
      'price_type': this.type,
      'product_count': this.quantity,
    };
    print(json);
    return json;
  }
}

class CartDetails {
  int offerCartMinimum;
  int offerCartMaximum;
  int offerCartDiscount;
  int offerDiscountType;
  num cartDiscount;
  num totalPrice;
  num totalPriceWithDiscount;

  CartDetails.fromJson(Map json) {
    this.offerCartMinimum = json['offer_cart_minimum'];
    this.offerCartMaximum = json['offer_cart_maximum'];
    this.offerCartDiscount = json['offer_cart_discount'];
    this.offerDiscountType = json['offer_discount_type'];
    this.cartDiscount = json['cart_discount'];
    this.totalPrice = json['subtotal_price'];
    this.totalPriceWithDiscount = json['total_price'];
  }
}
