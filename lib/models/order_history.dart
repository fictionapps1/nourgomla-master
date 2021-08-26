class OrderHistory {
  int id;
  int userId;
  String userFirstName;
  String userLastName;
  String userPhone;
  String userEmail;
  int userGender;
  int addressId;
  String addressLongitude;
  String addressLatitude;
  String addressAddress;
  int areaId;
  String areaNameAr;
  String areaNameEn;
  int areaShipping;
  String areaLatitude;
  String areaLongitude;
  int couponId;
  String couponCode;
  int couponType;
  int couponValue;
  int couponWithOffer;
  int couponFreeShipping;
  int couponCartMaximum;
  int couponCartMinimum;
  int createdBy;
  String createdAt;
  Null updatedBy;
  String updatedAt;
  int ordersStatusHistoryId;
  String ordersStatusHistoryNameAr;
  String ordersStatusHistoryNameEn;
  String ordersStatusHistoryColor;
  String ordersStatusHistoryComment;

  OrderHistory(
      {this.id,
        this.userId,
        this.userFirstName,
        this.userLastName,
        this.userPhone,
        this.userEmail,
        this.userGender,
        this.addressId,
        this.addressLongitude,
        this.addressLatitude,
        this.addressAddress,
        this.areaId,
        this.areaNameAr,
        this.areaNameEn,
        this.areaShipping,
        this.areaLatitude,
        this.areaLongitude,
        this.couponId,
        this.couponCode,
        this.couponType,
        this.couponValue,
        this.couponWithOffer,
        this.couponFreeShipping,
        this.couponCartMaximum,
        this.couponCartMinimum,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.ordersStatusHistoryId,
        this.ordersStatusHistoryNameAr,
        this.ordersStatusHistoryNameEn,
        this.ordersStatusHistoryColor,
        this.ordersStatusHistoryComment});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userFirstName = json['user_first_name'];
    userLastName = json['user_last_name'];
    userPhone = json['user_phone'];
    userEmail = json['user_email'];
    userGender = json['user_gender'];
    addressId = json['address_id'];
    addressLongitude = json['address_longitude'];
    addressLatitude = json['address_latitude'];
    addressAddress = json['address_address'];
    areaId = json['area_id'];
    areaNameAr = json['area_name_ar'];
    areaNameEn = json['area_name_en'];
    areaShipping = json['area_shipping'];
    areaLatitude = json['area_latitude'];
    areaLongitude = json['area_longitude'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    couponType = json['coupon_type'];
    couponValue = json['coupon_value'];
    couponWithOffer = json['coupon_with_offer'];
    couponFreeShipping = json['coupon_free_shipping'];
    couponCartMaximum = json['coupon_cart_maximum'];
    couponCartMinimum = json['coupon_cart_minimum'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    ordersStatusHistoryId = json['orders_status_history_id'];
    ordersStatusHistoryNameAr = json['orders_status_history_name_ar'];
    ordersStatusHistoryNameEn = json['orders_status_history_name_en'];
    ordersStatusHistoryColor = json['orders_status_history_color'];
    ordersStatusHistoryComment = json['orders_status_history_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_first_name'] = this.userFirstName;
    data['user_last_name'] = this.userLastName;
    data['user_phone'] = this.userPhone;
    data['user_email'] = this.userEmail;
    data['user_gender'] = this.userGender;
    data['address_id'] = this.addressId;
    data['address_longitude'] = this.addressLongitude;
    data['address_latitude'] = this.addressLatitude;
    data['address_address'] = this.addressAddress;
    data['area_id'] = this.areaId;
    data['area_name_ar'] = this.areaNameAr;
    data['area_name_en'] = this.areaNameEn;
    data['area_shipping'] = this.areaShipping;
    data['area_latitude'] = this.areaLatitude;
    data['area_longitude'] = this.areaLongitude;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['coupon_type'] = this.couponType;
    data['coupon_value'] = this.couponValue;
    data['coupon_with_offer'] = this.couponWithOffer;
    data['coupon_free_shipping'] = this.couponFreeShipping;
    data['coupon_cart_maximum'] = this.couponCartMaximum;
    data['coupon_cart_minimum'] = this.couponCartMinimum;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['orders_status_history_id'] = this.ordersStatusHistoryId;
    data['orders_status_history_name_ar'] = this.ordersStatusHistoryNameAr;
    data['orders_status_history_name_en'] = this.ordersStatusHistoryNameEn;
    data['orders_status_history_color'] = this.ordersStatusHistoryColor;
    data['orders_status_history_comment'] = this.ordersStatusHistoryComment;
    return data;
  }
}