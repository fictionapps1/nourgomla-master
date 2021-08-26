import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends ChangeNotifier {
  int id;

  @JsonKey(defaultValue: 0, name: 'minimum_order')
  int minimumOrder;

  @JsonKey(defaultValue: 0, name: 'max_order')
  int maxOrder;

  @JsonKey(defaultValue: 0)
  int special;

  @JsonKey(defaultValue: 0)
  int points;

  @JsonKey(defaultValue: 0, name: 'package_1_count')
  int package1Count;

  @JsonKey(defaultValue: 0, name: 'package_1_stock')
  int package1Stock;

  @JsonKey(defaultValue: 0, name: 'package_1_price')
  num package1Price;

  @JsonKey(defaultValue: 0, name: 'price_1_sale')
  num price1Sale;

  @JsonKey(defaultValue: 0, name: 'package_2_count')
  int package2Count;

  @JsonKey(defaultValue: 0, name: 'package_2_stock')
  int package2Stock;

  @JsonKey(defaultValue: 0, name: 'package_2_price')
  num package2Price;

  @JsonKey(defaultValue: 0, name: 'price_2_sale')
  num price2Sale;

  @JsonKey(defaultValue: 0, name: 'package_3_count')
  int package3Count;

  @JsonKey(defaultValue: 0, name: 'package_3_stock')
  int package3Stock;

  @JsonKey(defaultValue: 0, name: 'package_3_price')
  num package3Price;

  @JsonKey(defaultValue: 0, name: 'price_3_sale')
  num price3Sale;

  @JsonKey(defaultValue: 0, name: 'like_product')
  int likeProduct;

  @JsonKey(defaultValue: '', name: 'name_ar')
  String nameAr;

  @JsonKey(defaultValue: '', name: 'name_en')
  String nameEn;

  @JsonKey(defaultValue: '', name: 'description_ar')
  String descriptionAr;

  @JsonKey(defaultValue: '', name: 'description_en')
  String descriptionEn;

  @JsonKey(defaultValue: '', name: 'package_1_name')
  String package1Name;

  @JsonKey(defaultValue: '', name: 'package_2_name')
  String package2Name;

  @JsonKey(defaultValue: '', name: 'package_3_name')
  String package3Name;

  @JsonKey(defaultValue: '', name: 'images_path')
  String imagesPath;
  int imageId;
  String package1Barcode;
  String package2Barcode;
  String package3Barcode;
  String rate;
  int ratersCount;
  int vendorId;

  RxBool isFavorite = false.obs;

  Product({
    this.id,
    this.minimumOrder,
    this.maxOrder,
    this.special,
    this.points,
    this.package1Count,
    this.package1Stock,
    this.package1Price,
    this.price1Sale,
    this.package2Count,
    this.package2Stock,
    this.package2Price,
    this.price2Sale,
    this.package3Count,
    this.package3Stock,
    this.package3Price,
    this.price3Sale,
    this.likeProduct,
    this.isFavorite,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.package1Name,
    this.package2Name,
    this.package3Name,
    this.imagesPath,
    this.imageId,
    this.package1Barcode,
    this.package2Barcode,
    this.package3Barcode,
    this.rate,
    this.ratersCount,
    this.vendorId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Future<void> toggleFavoriteStatus() async {
    if (likeProduct == 1) {
      likeProduct = 0;
    } else {
      likeProduct = 1;
    }

    notifyListeners();
  }
}
