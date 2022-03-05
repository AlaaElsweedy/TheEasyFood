import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import '../../data/models/map/place_details_model.dart';
import '../../data/models/map/place_directions_model.dart';
import '../../data/models/map/place_suggestion_model.dart';
import '../../data/repository/map_repository.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapRepository mapRepository;

  MapsCubit(this.mapRepository) : super(MapsInitial());

  void getPlaceSuggestation(String place, String sessionToken) {
    mapRepository
        .fetchSuggestions(
      place: place,
      sessionToken: sessionToken,
    )
        .then((value) {
      emit(PlacesLoaded(value));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }

  void emitPlaceDirections(LatLng origin, LatLng destination) {
    mapRepository.getDirections(origin, destination).then((directions) {
      emit(DirectionsLoaded(directions));
    });
  }
}
