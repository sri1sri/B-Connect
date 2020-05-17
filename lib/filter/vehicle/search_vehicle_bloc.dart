import 'dart:async';
import 'package:bloc/bloc.dart';
import 'search_vehicle_extras.dart';

class SearchVehicleBloc extends Bloc<SearchVehicleEvent, SearchVehicleState> {

  @override
  SearchVehicleState get initialState => SearchVehicleState();

  @override
  Stream<SearchVehicleState> mapEventToState(SearchVehicleEvent event) async* {}

}
