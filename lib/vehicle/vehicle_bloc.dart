import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bloc/bloc.dart';
import 'vehicle_extras.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionVehicle;

  VehicleBloc({this.authenticationBloc});

  @override
  VehicleState get initialState => VehicleState.initial();

  @override
  Stream<VehicleState> mapEventToState(VehicleEvent event) async* {
    if (event is LoadDataEvent) {
      yield* _mapLoadVehicleToState();
    } else if (event is MapVehicleToState) {
      yield* _mapUpdateVehicle(event);
    }
  }

  Stream<VehicleState> _mapLoadVehicleToState() async* {
    _streamSubscriptionVehicle?.cancel();
    _streamSubscriptionVehicle = authenticationBloc.fireStoreDatabase
        .readAllVehicle()
        .listen((vehicleList) {
      add(MapVehicleToState(vehicleList: vehicleList));
    });
  }

  Stream<VehicleState> _mapUpdateVehicle(MapVehicleToState event) async* {
    yield VehicleState.success(vehicleList: event.vehicleList);
  }
}
