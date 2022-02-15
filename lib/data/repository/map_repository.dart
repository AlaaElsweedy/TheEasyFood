import 'package:talabat_app/data/models/map/place_details_model.dart';
import 'package:talabat_app/data/models/map/place_suggestation_model.dart';
import 'package:talabat_app/data/services/remote/place_web_services.dart';

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
}
