import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'vehicle_detail_reading_extras.dart';

class VehicleDetailReadingBloc
    extends Bloc<VehicleDetailReadingEvent, VehicleDetailReadingState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionUpdate;

  VehicleDetailReadingBloc({this.authenticationBloc});

  @override
  VehicleDetailReadingState get initialState => Loading();

  @override
  Stream<VehicleDetailReadingState> mapEventToState(
      VehicleDetailReadingEvent event) async* {
    if (event is InitDataEvent) {
      yield Loading();
      add(UpdatedEvent(documentId: event.vehicle.documentId));
    } else if (event is StartReading) {
      event.vehicle
        ..startTime = Timestamp.now()
        ..startRead = event.odoReading;
      authenticationBloc.fireStoreDatabase
          .updateVehicle(event.vehicle, event.vehicle.documentId)
          .then((value) =>
              add(UpdatedEvent(documentId: event.vehicle.documentId)));
    } else if (event is StopReading) {
      event.vehicle
        ..endTime = Timestamp.now()
        ..endRead = event.odoReading;
      authenticationBloc.fireStoreDatabase
          .updateVehicle(event.vehicle, event.vehicle.documentId)
          .then((value) =>
              add(UpdatedEvent(documentId: event.vehicle.documentId)));
    } else if (event is UpdatedEvent) {
      _streamSubscriptionUpdate?.cancel();
      _streamSubscriptionUpdate = authenticationBloc.fireStoreDatabase
          .readVehicle(event.documentId)
          .listen((vehicleRead) {
        try {
          add(MapVehicleToState(vehicle: vehicleRead));
        } catch (e) {}
      });
    } else if (event is MapVehicleToState) {
      yield Success(vehicle: event.vehicle);
    }
  }
}
