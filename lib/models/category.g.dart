// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as int,
    vendorId: json['vendor_id'] as int,
    nameAr: json['name_ar'] as String,
    nameEn: json['name_en'] as String,
    parentId: json['parent_id'] as int,
    imageId: json['image_id'] as int,
    status: json['status'] as int,
    sort: json['sort'] as String,
    type: json['type'] as int,
    imagesPath: json['images_path'] as String,
    bannerImagePath: json['banner_image_path'] as String,
    createdBy: json['created_by'] as int,
    languageId: json['language_id'] as int,
    isSelected: false,
    children: [],
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'parent_id': instance.parentId,
      'image_id': instance.imageId,
      'status': instance.status,
      'sort': instance.sort,
      'type': instance.type,
      'images_path': instance.imagesPath,
      'banner_image_path': instance.bannerImagePath,
      'created_by': instance.createdBy,
      'language_id': instance.languageId,
    };
