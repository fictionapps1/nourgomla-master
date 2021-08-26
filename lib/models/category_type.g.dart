// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryType _$CategoryTypeFromJson(Map<String, dynamic> json) {
  return CategoryType(
    id: json['id'] as int,
    nameAr: json['name_ar'] as String,
    nameEn: json['name_en'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    createdBy: json['created_by'] as int,
    updatedBy: json['updated_by'] as int,
  );
}

Map<String, dynamic> _$CategoryTypeToJson(CategoryType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
