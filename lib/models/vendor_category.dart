import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorCategory {
  int id;
  String nameAr;
  String nameEn;
  int vendorCategoryId;
  int imageId;
  int bannerImageId;
  int status;
  bool busy;
  bool closed;
  String imagesPath;
  num shipping;
  String bannerImagesPath;
  LatLng latLng;

  VendorCategory({
    this.id,
    this.nameAr,
    this.nameEn,
    this.vendorCategoryId,
    this.imageId,
    this.bannerImageId,
    this.status,
    this.busy,
    this.closed,
    this.imagesPath,
    this.bannerImagesPath,
    this.latLng,
    this.shipping,
  });

  VendorCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    vendorCategoryId = json['vendor_category_id'];
    imageId = json['image_id'];
    bannerImageId = json['banner_image_id'];
    status = json['status'];
    busy = json['busy'] == 1 ? true : false;
    closed = json['closed'] == 1 ? true : false;
    imagesPath = json['images_path'];
    bannerImagesPath = json['banner_images_path'];
    shipping=json['shipping'];
    latLng =json['latitude']!=null&&json['longitude']!=null?
        LatLng(double.parse(json['latitude']), double.parse(json['longitude'])):null;
  }
}
