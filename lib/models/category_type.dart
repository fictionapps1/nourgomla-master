import 'package:json_annotation/json_annotation.dart';

part 'category_type.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryType {
  int id;
  String nameAr;
  String nameEn;
  String createdAt;
  String updatedAt;
  int createdBy;
  int updatedBy;

  CategoryType({
    this.id,
    this.nameAr,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory CategoryType.fromJson(Map json) => _$CategoryTypeFromJson(json);

  Map toJson() => _$CategoryTypeToJson(this);
}
