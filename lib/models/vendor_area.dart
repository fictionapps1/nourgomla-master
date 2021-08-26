class VendorArea {
  int id;
  String keyArea;
  String nameAr;
  String nameEn;
  bool isSelected;

  VendorArea({this.id, this.keyArea, this.nameAr, this.nameEn,this.isSelected});

  VendorArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyArea = json['key_area'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    isSelected = false;
  }

}