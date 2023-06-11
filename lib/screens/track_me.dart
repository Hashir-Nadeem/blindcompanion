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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'
                  .tr)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permissions are denied'.tr)));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'
                  .tr)));
      return false;
    }
    return true;
  }

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
        infoWindow: const InfoWindow(
          title: 'Current Location',
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
          title: Text("Map"),
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
