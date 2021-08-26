import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helpers/image_helpers.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../models/vendor_category.dart';
import '../../controllers/vendor_controller.dart';
import 'package:get/get.dart';

import 'vendor_categories_screen.dart';

class VendorsMapScreen extends StatefulWidget {
  final String title;

  VendorsMapScreen(this.title);

  @override
  _VendorsMapScreenState createState() => _VendorsMapScreenState();
}

class _VendorsMapScreenState extends State<VendorsMapScreen> {
  LatLng latLng;
  final vendorCon = Get.find<VendorController>();
  final locationCon = Get.find<LocationController>();
  final settingCon = Get.find<SettingsController>();
  final langCon = Get.find<LanguageController>();
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;


  @override
  void initState() {
    _initMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: settingCon.color1,
          elevation: 0,
          title: Text(widget.title,style: TextStyle(color: Colors.black),),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latLng.latitude, latLng.longitude),
                zoom: 12,
              ),
              mapType: MapType.normal,
              markers: _markers,
              myLocationEnabled: true,
            ),
          ],
        ));
  }

  void _initMap() {
    for (int i = 0; i <= vendorCon.vendorData.length; i++) {
      vendorCon.vendorData.forEach((vendor) {
        if (vendor.latLng != null) {
          if (i == 0) {
            setState(() {
              latLng = LatLng(vendor.latLng.latitude, vendor.latLng.longitude);
            });
          }
          _setMarkers(vendor);
        }
      });
    }
    if (latLng == null) {
      setState(() {
        latLng =
            LatLng(locationCon.userLocation.lat, locationCon.userLocation.lng);
      });
    }
  }

  void _setMarkers(VendorCategory vendor) async {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    var icon = await _setMarkerIcon(vendor.imagesPath);
    setState(() {
      _markers.add(
        Marker(
            icon: icon,
            markerId: MarkerId(markerIdVal),
            position: vendor.latLng,
            // infoWindow: InfoWindow(
            //   title: langCon.lang == 'ar' ? vendor.nameAr : vendor.nameEn,
            //
            // ),
            onTap: () {
              Get.to(() => VendorCategoriesScreen(
                title: vendor.nameAr,
                categoryImage: vendor.bannerImagesPath,
                vendorCategoryId: vendor.id,
              ));

            }),
      );
    });
  }

  Future<BitmapDescriptor> _setMarkerIcon(String image) async {
    final bytes = await getMarkerImageFromNetwork(image);
    if (bytes != null) {
      return BitmapDescriptor.fromBytes(bytes);
    }
    return BitmapDescriptor.defaultMarker;
  }
}
