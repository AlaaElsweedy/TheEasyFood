import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helpers/location_helper.dart';
import '../../shared/components/styles/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();
  late List<Placemark> placemarks;

  // these variables for getPlaceLocation
  Set<Marker> markers = {};
  late Marker currentLocationMarker;

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0, //camera angels (view)
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0, //like pretty much bearing
    zoom: 17,
  );

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: markers,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: const MarkerId('1'),
      infoWindow: const InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  Future getMyCurrentLocation() async {
    try {
      position = await LocationHelper.getCurrentLocation().whenComplete(() {
        setState(() {});
      });
      buildCurrentLocationMarker();
      placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: _goToMyCurrentLocation,
          child: const Icon(Icons.place, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        _myCurrentLocationCameraPosition,
      ),
    );
    Navigator.pop(context, placemarks[0].street);
    // navigateTo(
    //   context,
    //   CheckoutScreen(
    //     currentPosition: placemarks[0].street,
    //   ),
    // );
  }
}
