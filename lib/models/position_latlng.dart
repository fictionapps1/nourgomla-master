class PositionLatLng {
  double lat;
  double lng;

  PositionLatLng(this.lat, this.lng);

  toJson() => {'lat': lat, 'lng': lng};

  PositionLatLng.fromJson(Map json) {
    this.lat = json['lat'];
    this.lng = json['lng'];
  }

}