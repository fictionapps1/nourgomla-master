import 'dart:convert';

import 'package:geodesy/geodesy.dart';

class AreaModel {
  int id;
  String areaNameAr;
  String areaNameEn;
  String areaLat;
  String areaLng;
  int cost;
  List<LatLng> polygon;

  AreaModel({
    this.id,
    this.areaNameAr,
    this.areaNameEn,
    this.areaLat,
    this.areaLng,
    this.cost,
    this.polygon,
  });

  AreaModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.areaNameEn = json['area_name_en'];
    this.areaNameAr = json['area_name_ar'];
    this.cost = json['area_shipping'];
    this.areaLat = json['area_latitude'];
    this.areaLng = json['area_longitude'];
    this.polygon = polygonFromJson(json['radius']);
  }

  List<LatLng> polygonFromJson(String stringJson) {
    if (stringJson != null && stringJson != '') {
      List json = jsonDecode(stringJson);
      return json.map((e) => LatLng(e['lat'], e['lng'])).toList();
    } else {
      return [];
    }
  }
}
