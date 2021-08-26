class AddressModel {
  int id;
  int userId;
  String address;
  String areaNameAr;
  String areaNameEn;
  String areaLat;
  String areaLng;
  int cost;
  int areaId;
  bool selected;

  AddressModel(
      {this.id,
      this.userId,
      this.areaNameAr,
      this.areaNameEn,
      this.areaLat,
      this.areaLng,
      this.cost,
      this.address,
      this.areaId,
      this.selected = false});

  AddressModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.userId = json['user_id'];
    this.address = json['address'];
    this.areaId = json['area_id'];
    this.areaNameEn = json['area_name_en'];
    this.areaNameAr = json['area_name_ar'];
    this.cost = json['area_shipping'];
    this.areaLat = json['latitude'];
    this.areaLng = json['longitude'];
    this.selected = false;
  }
}
