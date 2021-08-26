class Coupon {
  int id;
  String couponCode;
  String couponDescription;
  int cartMinimum;
  int cartMaximum;
  String endDate;
  int withOffer;
  int freeShipping;
  int useMaximum;
  int userUse;
  int createdBy;
  String createdAt;
  int updatedBy;
  String updatedAt;
  int couponValue;
  int couponType;

  Coupon(
      {this.id,
      this.couponCode,
      this.couponDescription,
      this.cartMinimum,
      this.cartMaximum,
      this.endDate,
      this.withOffer,
      this.freeShipping,
      this.useMaximum,
      this.userUse,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.couponValue,
      this.couponType});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponCode = json['coupon_code'];
    couponDescription = json['coupon_description'];
    cartMinimum = json['cart_minimum'];
    cartMaximum = json['cart_maximum'];
    endDate = json['end_date'];
    withOffer = json['with_offer'];
    freeShipping = json['free_shipping'];
    useMaximum = json['use_maximum'];
    userUse = json['user_use'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    couponValue = json['coupon_value'];
    couponType = json['coupon_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_code'] = this.couponCode;
    data['coupon_description'] = this.couponDescription;
    data['cart_minimum'] = this.cartMinimum;
    data['cart_maximum'] = this.cartMaximum;
    data['end_date'] = this.endDate;
    data['with_offer'] = this.withOffer;
    data['free_shipping'] = this.freeShipping;
    data['use_maximum'] = this.useMaximum;
    data['user_use'] = this.userUse;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['coupon_value'] = this.couponValue;
    data['coupon_type'] = this.couponType;
    return data;
  }
}
