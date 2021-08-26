class LocationModel {
  double lat;
  double lng;
  String countryName;
  String adminArea;
  String subAdminArea;
  String countryCode;
  String locality;

  LocationModel(
      {this.lat,
      this.lng,
      this.countryName,
      this.adminArea,
      this.subAdminArea,
      this.countryCode,
      this.locality});

  String stringAddress() {
    return 'Latitude: $lat,  Longitude: $lng,  Country Name: $countryName   Admin Area: $adminArea,  Sub Admin Area: $subAdminArea  Country Code: $countryCode,  Locality: $locality';
  }
}
