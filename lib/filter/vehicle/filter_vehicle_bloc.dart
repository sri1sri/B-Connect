import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bloc/bloc.dart';
import 'filter_vehicle_extras.dart';

class FilterVehicleBloc extends Bloc<FilterVehicleEvent, FilterVehicleState> {
  AuthenticationBloc authenticationBloc;

  StreamSubscription _streamReadVehicle;

  FilterVehicleBloc({this.authenticationBloc});

  @override
  FilterVehicleState get initialState => FilterVehicleState.loading();

  @override
  Stream<FilterVehicleState> mapEventToState(FilterVehicleEvent event) async* {
    if (event is InitDataFilterVehicleEvent) {
      yield FilterVehicleState.loading();
      _streamReadVehicle = authenticationBloc.fireStoreDatabase
          .readAllVehicle()
          .listen((vehicleList) {
        add(MapVehicleToSeller(vehicleList: vehicleList));
      });
    } else if (event is MapVehicleToSeller) {
      yield FilterVehicleState.success(vehicleList: event.vehicleList);
    }
  }

  @override
  Future<void> close() {
    _streamReadVehicle.cancel();
    return super.close();
  }
}
