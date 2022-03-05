import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/map/place_details_model.dart';
import '../models/map/place_directions_model.dart';
import '../models/map/place_suggestion_model.dart';
import '../services/place_web_services.dart';

class MapRepository {
  final PlacesWebservices placesWebservices;

  MapRepository(this.placesWebservices);

  Future<List<PlaceSuggestion>> fetchSuggestions({
    required String place,
    required String sessionToken,
  }) async {
    final suggestations = await placesWebservices.fetchSuggestions(
      place: place,
      sessionToken: sessionToken,
    );

    return suggestations
        .map((suggestation) => PlaceSuggestion.fromJson(suggestation))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebservices.getPlaceLocation(placeId, sessionToken);
    return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(
    LatLng origin,
    LatLng destination,
  ) async {
    final directions =
        await placesWebservices.getDirections(origin, destination);
    return PlaceDirections.fromJson(directions);
  }
}
