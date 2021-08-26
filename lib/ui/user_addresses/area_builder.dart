import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../config/api_links.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../controllers/adresses_controller.dart';
import 'package:get/get.dart';
import '../../helpers/validators.dart';
import '../../models/position_latlng.dart';
import '../../services/api_calls/addresses_services.dart';

class AreaBuilder extends StatefulWidget {
  @override
  _AreaBuilderState createState() => _AreaBuilderState();
}

class _AreaBuilderState extends State<AreaBuilder> {
  String shippingCost;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddressesServices _addressesServices = AddressesServices.instance;
  LatLng latLng;
  final controller = Get.find<AddressesController>();
  initData() {
    latLng = LatLng(controller.locationData.lat, controller.locationData.lng);
  }

  // Maps
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Circle> _circles = HashSet<Circle>();
  // GoogleMapController _googleMapController;
  // BitmapDescriptor _markerIcon;
  List<LatLng> polygonLatLngs = List<LatLng>();
  double radius;

  //ids
  int _polygonIdCounter = 1;
  int _circleIdCounter = 1;
  int _markerIdCounter = 1;

  // Type controllers
  bool _isPolygon = true; //Default
  bool _isMarker = false;
  bool _isCircle = false;

  @override
  void initState() {
    super.initState();
    initData();

    // void _setMarkerIcon() async {
    //   _markerIcon = await BitmapDescriptor.fromAssetImage(
    //       ImageConfiguration(), 'assets/farm.png');
    // }
  }

  // Draw Polygon to the map
  void _setPolygon() {
    final String polygonIdVal = 'polygon_id_$_polygonIdCounter';
    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonLatLngs,
      strokeWidth: 2,
      strokeColor: Colors.blue,
      fillColor: Colors.blue.withOpacity(0.15),
    ));
  }

  // Set circles as points to the map
  void _setCircles(LatLng point) {
    final String circleIdVal = 'circle_id_$_circleIdCounter';
    _circleIdCounter++;
    print(
        'Circle | Latitude: ${point.latitude}  Longitude: ${point.longitude}  Radius: $radius');
    _circles.add(Circle(
        circleId: CircleId(circleIdVal),
        center: point,
        radius: radius,
        fillColor: Colors.redAccent.withOpacity(0.5),
        strokeWidth: 3,
        strokeColor: Colors.redAccent));
  }

  // Set Markers to the map
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  // // Start the map with this marker setted up
  // void _onMapCreated(GoogleMapController controller) {
  //   _googleMapController = controller;
  //
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId('0'),
  //         position: LatLng(-20.131886, -47.484488),
  //         infoWindow:
  //             InfoWindow(title: 'Roça', snippet: 'Um bom lugar para estar'),
  //         //icon: _markerIcon,
  //       ),
  //     );
  //   });
  // }

  Widget _fabPolygon() {
    return FloatingActionButton.extended(
      onPressed: () {
        //Remove the last point setted at the polygon
        setState(() {
          polygonLatLngs.removeLast();
        });
      },
      icon: Icon(Icons.undo),
      label: Text('Undo point'),
      backgroundColor: Colors.orange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Container(
            height: 60,
            child: Form(
              key: _formKey,
              child: CustomTextField(
                onSaved: (val) {
                  setState(() {
                    shippingCost = val;
                  });
                },
                hasLabel: false,
                label: "shipping_cost".tr,
                validator: (val) => fnLnValidator(val),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 20, top: 8, bottom: 8),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  insertNewArea();
                },
                child: Text('Confirm Area'),
                color: Colors.orange,
              ),
            )
          ],
        ),
        floatingActionButton:
            polygonLatLngs.length > 0 && _isPolygon ? _fabPolygon() : null,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latLng.latitude, latLng.longitude),
                zoom: 16,
              ),
              mapType: MapType.normal,
              markers: _markers,
              circles: _circles,
              polygons: _polygons,
              myLocationEnabled: true,
              onTap: (point) {
                if (_isPolygon) {
                  setState(() {
                    polygonLatLngs.add(point);

                    _setPolygon();
                    // print(polygonLatLngs);
                  });
                } else if (_isMarker) {
                  setState(() {
                    _markers.clear();
                    _setMarkers(point);
                  });
                } else if (_isCircle) {
                  setState(() {
                    _circles.clear();
                    _setCircles(point);
                  });
                }
              },
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Row(
            //     children: <Widget>[
            //       RaisedButton(
            //           color: Colors.black54,
            //           onPressed: () {
            //             _isPolygon = true;
            //             _isMarker = false;
            //             _isCircle = false;
            //           },
            //           child: Text(
            //             'Polygon',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, color: Colors.white),
            //           )),
            //       RaisedButton(
            //           color: Colors.black54,
            //           onPressed: () {
            //             _isPolygon = false;
            //             _isMarker = true;
            //             _isCircle = false;
            //           },
            //           child: Text('Marker',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white))),
            //       RaisedButton(
            //           color: Colors.black54,
            //           onPressed: () {
            //             _isPolygon = false;
            //             _isMarker = false;
            //             _isCircle = true;
            //             radius = 50;
            //             return showDialog(
            //                 context: context,
            //                 child: AlertDialog(
            //                   backgroundColor: Colors.grey[900],
            //                   title: Text(
            //                     'Choose the radius (m)',
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.white),
            //                   ),
            //                   content: Padding(
            //                       padding: EdgeInsets.all(8),
            //                       child: Material(
            //                         color: Colors.black,
            //                         child: TextField(
            //                           style: TextStyle(
            //                               fontSize: 16, color: Colors.white),
            //                           decoration: InputDecoration(
            //                             icon: Icon(Icons.zoom_out_map),
            //                             hintText: 'Ex: 100',
            //                             suffixText: 'meters',
            //                           ),
            //                           keyboardType:
            //                               TextInputType.numberWithOptions(),
            //                           onChanged: (input) {
            //                             setState(() {
            //                               radius = double.parse(input);
            //                             });
            //                           },
            //                         ),
            //                       )),
            //                   actions: <Widget>[
            //                     FlatButton(
            //                         onPressed: () {
            //                           _setCircles(latLng);
            //                           Navigator.pop(context);
            //                         },
            //                         child: Text(
            //                           'Ok',
            //                           style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                           ),
            //                         )),
            //                   ],
            //                 ));
            //           },
            //           child: Text('Circle',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white)))
            //     ],
            //   ),
            // )
          ],
        ));
  }

  insertNewArea() async {
    List <Map>polygonList = [];
    PositionLatLng _pos;
    String adminArea;
    String subAdminArea;
    _formKey.currentState.save();
    if (_formKey.currentState.validate()&&polygonLatLngs.length>0) {
      for (int index = 0; index <= polygonLatLngs.length - 1; index++) {
        if (index == 0) {
          final coordinates = new Coordinates(
              polygonLatLngs[index].latitude, polygonLatLngs[index].longitude);
          final locationDetails =
          Geocoder.google(ApiLinks.googleApiKey,language: 'en');

          final addresses=await locationDetails.findAddressesFromCoordinates(coordinates);
          adminArea = addresses[1].adminArea;
          subAdminArea = addresses[1].subAdminArea;
        }
        _pos = PositionLatLng(
            polygonLatLngs[index].latitude, polygonLatLngs[index].longitude);
        polygonList.add(_pos.toJson());
      }
      print(polygonList);
      print('$adminArea' '_' '$subAdminArea');
      _addressesServices.insertArea(
          areaName: '$adminArea' '_' '$subAdminArea',
          polygons: polygonList,
          shippingCost: shippingCost);
    }
  }
}
