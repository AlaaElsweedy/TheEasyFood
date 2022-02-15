import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:talabat_app/business_logic/maps/maps_cubit.dart';
import 'package:talabat_app/data/models/map/place_details_model.dart';
import 'package:talabat_app/data/models/map/place_suggestation_model.dart';
import 'package:talabat_app/helpers/location_helper.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/components/styles/colors.dart';
import 'package:uuid/uuid.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<PlaceSuggestion> places = [];
  FloatingSearchBarController controller = FloatingSearchBarController();
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();

  // these variables for getPlaceLocation
  Set<Marker> markers = {};
  late PlaceSuggestion placeSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0, //camera angels (view)
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0, //like pretty much bearing
    zoom: 17,
  );

  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: LatLng(
        selectedPlace.result.geometry.location.lat,
        selectedPlace.result.geometry.location.lng,
      ),
      zoom: 13,
    );
  }

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

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      elevation: 6,
      hintStyle: const TextStyle(fontSize: 18),
      queryStyle: const TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: const BorderSide(style: BorderStyle.none),
      margins: const EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: mainColor,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      //progress: progressIndicator,
      onQueryChanged: (query) {
        getPlacesSuggestions(query);
      },
      onFocusChanged: (_) {
        // hide distance and time row
        setState(() {
          //isTimeAndDistanceVisible = false;
        });
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
              icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
              onPressed: () {}),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSuggestionsBloc(),
              buildSelectedPlaceLocationBloc(),
              // buildDiretionsBloc(),
            ],
          ),
        );
      },
    );
  }

  void getPlacesSuggestions(String query) {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .getPlaceSuggestation(query, sessionToken);
  }

  Widget buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = state.places;
          if (places.isNotEmpty) {
            return buildPlacesList();
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = state.place;

          goToMySearchedForLocation();
          //getDirections();
        }
      },
      child: Container(),
    );
  }

  Future<void> goToMySearchedForLocation() async {
    buildCameraNewPosition();
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
    buildSearchedPlaceMarker();
  }

  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: const MarkerId('1'),
      onTap: () {
        buildCurrentLocationMarker();
        // show time and distance
        setState(() {
          // isSearchedPlaceMarkerClicked = true;
          // isTimeAndDistanceVisible = true;
        });
      },
      infoWindow: InfoWindow(title: placeSuggestion.description),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: const MarkerId('2'),
      infoWindow: const InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  Widget buildPlacesList() {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () async {
              placeSuggestion = places[index];
              controller.close();
              getSelectedPlaceLocation();
              // polylinePoints.clear();
              // removeAllMarkersAndUpdateUI();
            },
            child: PlaceItem(
              suggestion: places[index],
            ),
          );
        },
        itemCount: places.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics());
  }

  void getSelectedPlaceLocation() {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context).emitPlaceLocation(
      placeSuggestion.placeId,
      sessionToken,
    );
  }

  Future getMyCurrentLocation() async {
    try {
      position = await LocationHelper.getCurrentLocation().whenComplete(() {
        setState(() {});
      });
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );

      //print('Address is ${placemarks[0].street} /////////////');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      Navigator.pop(context);
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getMyCurrentLocation();
  // }

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
          buildFloatingSearchBar()
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
  }
}
