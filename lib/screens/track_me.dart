import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/TTSService.dart';

class MyTrackMe extends StatefulWidget {
  const MyTrackMe({super.key});

  @override
  State<MyTrackMe> createState() => _MyTrackMeState();
}

class _MyTrackMeState extends State<MyTrackMe> {
  /// Map
  final Completer<GoogleMapController> _controller = Completer();
  // we have specified starting camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(41.96132466225174, -88.09161618969705),
    zoom: 14,
  );

  late LatLng _currentLocation;
  String? _currentAddress;

  final TTSService ttsService = TTSService();

  // the list of markers, which will shown in map
  final List<Marker> _markers = <Marker>[];

  // method for getting user current location with permission
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR: $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  // method for moving screen to user current location
  void moveToCurrentPosition() async {
    getUserCurrentLocation().then((value) async {
      debugPrint("${value.latitude} ${value.longitude}");

      _currentLocation = LatLng(value.latitude, value.longitude);

      getAddressFromLatLng(_currentLocation);
      // marker added for current user location
      _markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: InfoWindow(
          title: 'Current Location'.tr,
        ),
      ));

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    await placemarkFromCoordinates(
            _currentLocation.latitude, _currentLocation.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      _currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      debugPrint(_currentAddress);
      ttsService.speak(_currentAddress!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // When this page starts loading
  @override
  void initState() {
    super.initState();
    moveToCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return (Scaffold(
        appBar: AppBar(
          title: Text('Map'.tr),
          backgroundColor: Colors.transparent,
        ),
        body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(children: [
              SafeArea(
                // on below line creating google maps
                child: GoogleMap(
                  // on below line setting camera position
                  initialCameraPosition: _kGoogle,
                  // on below line we are setting markers on the map
                  markers: Set<Marker>.of(_markers),
                  // on below line specifying map type.
                  mapType: MapType.normal,
                  // on below line setting user location enabled.
                  myLocationEnabled: true,
                  // on below line setting compass enabled.
                  compassEnabled: true,
                  // on below line specifying controller on map complete.
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ]))));
  }
}
