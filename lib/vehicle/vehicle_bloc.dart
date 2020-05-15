import 'dart:async';
import 'package:bloc/bloc.dart';
import 'vehicle_extras.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  @override
  VehicleState get initialState => VehicleState.initial();

  @override
  Stream<VehicleState> mapEventToState(VehicleEvent event) async* {}
}
