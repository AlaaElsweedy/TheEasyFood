import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talabat_app/data/models/place_suggestation_model.dart';
import 'package:talabat_app/data/repository/map_repository.dart';

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
}
