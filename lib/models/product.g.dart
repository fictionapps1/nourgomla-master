// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    imageId: json['images_id'] as int,
    minimumOrder: json['minimum_order'] as int ?? 0,
    maxOrder: json['max_order'] as int ?? 0,
    special: json['special'] as int ?? 0,
    points: json['points'] as int ?? 0,
    package1Count: json['package_1_count'] as int ?? 0,
    package1Stock: json['package_1_stock'] as int ?? 0,
    package1Price: json['package_1_price'] as num ?? 0,
    price1Sale: json['price_1_sale'] as num ?? 0,
    package2Count: json['package_2_count'] as int ?? 0,
    package2Stock: json['package_2_stock'] as int ?? 0,
    package2Price: json['package_2_price'] as num ?? 0,
    price2Sale: json['price_2_sale'] as num ?? 0,
    package3Count: json['package_3_count'] as int ?? 0,
    package3Stock: json['package_3_stock'] as int ?? 0,
    package3Price: json['package_3_price'] as num ?? 0,
    price3Sale: json['price_3_sale'] as num ?? 0,
    likeProduct: json['like_product'] as int ?? 0,
    nameAr: json['name_ar'] as String ?? '',
    nameEn: json['name_en'] as String ?? '',
    descriptionAr: json['description_ar'] as String ?? '',
    descriptionEn: json['description_en'] as String ?? '',
    package1Name: json['package_1_name'] as String ?? '',
    package2Name: json['package_2_name'] as String ?? '',
    package3Name: json['package_3_name'] as String ?? '',
    imagesPath: json['images_path'] as String ?? '',
    package1Barcode: json['package_1_barcode'] as String ?? '',
    package2Barcode: json['package_2_barcode'] as String ?? '',
    package3Barcode: json['package_3_barcode'] as String ?? '',
    rate: json['rate'] as String ?? '',
    ratersCount: json['rate_count'] as int ?? 0,
    vendorId: json['vendor_id'] as int ?? 0,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'minimum_order': instance.minimumOrder,
      'max_order': instance.maxOrder,
      'special': instance.special,
      'points': instance.points,
      'package_1_count': instance.package1Count,
      'package_1_stock': instance.package1Stock,
      'package_1_price': instance.package1Price,
      'price_1_sale': instance.price1Sale,
      'package_2_count': instance.package2Count,
      'package_2_stock': instance.package2Stock,
      'package_2_price': instance.package2Price,
      'price_2_sale': instance.price2Sale,
      'package_3_count': instance.package3Count,
      'package_3_stock': instance.package3Stock,
      'package_3_price': instance.package3Price,
      'price_3_sale': instance.price3Sale,
      'like_product': instance.likeProduct,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'description_ar': instance.descriptionAr,
      'description_en': instance.descriptionEn,
      'package_1_name': instance.package1Name,
      'package_2_name': instance.package2Name,
      'package_3_name': instance.package3Name,
      'images_path': instance.imagesPath,
      'images_id': instance.imageId,
      'package_1_barcode': instance.package1Barcode,
      'package_2_barcode': instance.package2Barcode,
      'package_3_barcode': instance.package3Barcode,
    };
