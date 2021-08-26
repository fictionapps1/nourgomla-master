class OrderProduct {
  int id;
  int orderId;
  int productId;
  int userId;
  int userRoleId;
  int localId;
  String nameAr;
  String nameEn;
  String packageName;
  num packagePrice;
  int packageCount;
  int packageType;
  int productCount;
  num priceDiscount;
  int points;
  int imageId;
  String imagePath;
  int createdBy;
  String createdAt;
  int isGift;

  OrderProduct({
    this.id,
    this.orderId,
    this.productId,
    this.userId,
    this.userRoleId,
    this.localId,
    this.nameAr,
    this.nameEn,
    this.packageName,
    this.packagePrice,
    this.packageCount,
    this.packageType,
    this.productCount,
    this.priceDiscount,
    this.points,
    this.imageId,
    this.imagePath,
    this.createdBy,
    this.createdAt,
    this.isGift,
  });

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    isGift = json['is_gift'];
    productId = json['product_id'];
    userId = json['user_id'];
    userRoleId = json['user_role_id'];
    localId = json['local_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    packageName = json['package_name'];
    packagePrice = json['package_price'];
    packageCount = json['package_count'];
    packageType = json['package_type'];
    productCount = json['product_count'];
    priceDiscount = json['price_discount'];
    points = json['points'];
    imageId = json['image_id'];
    imagePath = json['image_path'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['is_gift'] = this.isGift;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['user_role_id'] = this.userRoleId;
    data['local_id'] = this.localId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['package_name'] = this.packageName;
    data['package_price'] = this.packagePrice;
    data['package_count'] = this.packageCount;
    data['package_type'] = this.packageType;
    data['product_count'] = this.productCount;
    data['price_discount'] = this.priceDiscount;
    data['points'] = this.points;
    data['image_id'] = this.imageId;
    data['image_path'] = this.imagePath;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}
