import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../config/api_links.dart';
import '../models/vendor_area.dart';
import '../models/location_model.dart';
import 'home_controller.dart';

class LocationController extends GetxController {
  LocationModel userLocation;
  VendorArea chosenArea;

  chooseLocation(VendorArea area) {
    chosenArea = area;
    update();
  }

  @override
  onInit() async {
    userLocation = await getUserLocation();
    Get.put<HomeController>(HomeController(), permanent: true);
    update();
    super.onInit();
  }

  Future<LocationModel> getUserLocation() async {
    LocationModel location;
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final coordinates = new Coordinates(pos.latitude, pos.longitude);
      final locationDetails =
         Geocoder.google(ApiLinks.googleApiKey,language: 'en');

      final addresses=await locationDetails.findAddressesFromCoordinates(coordinates);
      update();
      print("latitude  ${pos.latitude}");
      print("longitude  ${pos.longitude}");
      print("countryName   ${addresses[0].countryName}");
      print("adminArea  ${addresses[1].adminArea}");
      print("subAdminArea  ${addresses[1].subAdminArea}");
      print("countryCode  ${addresses[1].countryCode}");
      print("locality  ${addresses[1].locality}");
      print("addressLine  ${addresses[0].addressLine}");
      print("coordinates   ${addresses[0].coordinates}");
      print("postalCode   ${addresses[0].postalCode}");

      location = LocationModel(
        lng: pos.longitude,
        lat: pos.latitude,
        adminArea: addresses[1].adminArea,
        countryCode: addresses[1].countryCode,
        countryName: addresses[0].countryName,
        locality: addresses[1].locality,
        subAdminArea: addresses[1].subAdminArea,
      );
      userLocation = location;
      return location;
    } catch (e) {
      print('Error Getting Location============> $e');
      return location;
    }
  }
}
