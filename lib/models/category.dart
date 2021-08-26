import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Category {
  int id;
  int vendorId;
  String nameAr;
  String nameEn;
  int parentId;
  int imageId;
  int status;
  String sort;
  int type;
  String imagesPath;
  String bannerImagePath;
  int createdBy;
  int languageId;
  bool isSelected;
  List<Category> children;
  Category(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.parentId,
      this.imageId,
      this.status,
      this.sort,
      this.type,
      this.imagesPath,
      this.createdBy,
      this.languageId,
      this.bannerImagePath,
      this.isSelected = false,
      this.vendorId ,
      this.children = const <Category>[]});

  factory Category.fromJson(Map json) => _$CategoryFromJson(json);

  Map toJson() => _$CategoryToJson(this);
}
