import '../../config/api_links.dart';

import '../../controllers/location_controller.dart';

import '../../external_packages/place_picker/google_maps_place_picker.dart';
import '../../ui/user_addresses/widgets/map_address_insert_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/adresses_controller.dart';
import '../../common_widgets/loading_view.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isLoading = false;

  final controller = Get.find<AddressesController>();

  GoogleMapController mapController;
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    if (controller.updateMode) {
      controller.changeCurrentLatLng(LatLng(
          double.parse(controller.addressToUpdate.areaLat),
          double.parse(controller.addressToUpdate.areaLng)));
    } else {
      setState(() {
        isLoading = true;
      });
      LocationController locationCon = Get.find<LocationController>();
      if (locationCon.userLocation == null) {
        await locationCon.getUserLocation();
        if (locationCon.userLocation == null) {
          return;
        }
      }
      controller.changeCurrentLatLng(
          LatLng(locationCon.userLocation.lat, locationCon.userLocation.lng));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddressesController>(
          init: Get.find(),
          builder: (addressesController) {
            return isLoading
                ? LoadingView()
                : Column(
                    children: [
                      Expanded(
                        child: PlacePicker(
                          onMapCreated: (mapCon) {},
                          autocompleteLanguage: 'ar',
                          selectInitialPosition: false,
                          initialPosition: LatLng(
                              controller.currentLatLng.latitude,
                              controller.currentLatLng.longitude),
                          useCurrentLocation: false,
                          selectedPlaceWidgetBuilder: (context, selectedPlace,
                              state, isSearchBarFocused) {
                            print('Build');
                            return AddressInsertWidget(
                                selectedPlace: selectedPlace);
                          },
                          apiKey: ApiLinks.googleApiKey,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
          }),
    );
  }
}
