import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/database_model/vehicle_trip_record.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'vehicle_detail_trip_extras.dart';

class VehicleDetailTripBloc
    extends Bloc<VehicleDetailTripEvent, VehicleDetailTripState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionUpdate;
  StreamSubscription<List<VehicleTripRecord>> _listenAllTripRecord;
  StreamSubscription<List<VehicleTripRecord>> _listenMaxTripRecord;

  VehicleDetailTripBloc({this.authenticationBloc});

  @override
  VehicleDetailTripState get initialState => Loading();

  @override
  Stream<VehicleDetailTripState> mapEventToState(
      VehicleDetailTripEvent event) async* {
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
        authenticationBloc.fireStoreDatabase
            .readTripRecordBy(event.documentId)
            .listen((tripRecordList) {
          try {
            add(MapVehicleToState(
                vehicle: vehicleRead, tripRecordList: tripRecordList));
          } catch (e) {}
        });
      });
    } else if (event is MapVehicleToState) {
//      event.tripRecordList.sort((a,b) => a.round.compareTo(b.round));
      yield Success(
          vehicle: event.vehicle, tripRecordList: event.tripRecordList);
    } else if (event is TripRecord) {
      _listenAllTripRecord = authenticationBloc.fireStoreDatabase
          .readAllTripRecord()
          .listen((allRecord) {
        add(LoadedTripRecord(
            allTripRecord: allRecord, documentId: event.documentId));
      });
    } else if (event is LoadedTripRecord) {
      _listenAllTripRecord?.cancel();
      _listenMaxTripRecord?.cancel();
      int currentRound = 0;
      var listRecord = event.allTripRecord;
      List<VehicleTripRecord> tmpList = [];
      tmpList.addAll(
          listRecord.where((element) => event.documentId == element.vehicleId));
      if (tmpList != null && tmpList.length > 0) {
        tmpList.sort((a,b) => a.round.compareTo(b.round));
        currentRound = tmpList?.last?.round;
      }
      currentRound++;
      await authenticationBloc.fireStoreDatabase.addTripRecord(
          VehicleTripRecord(
              id: Uuid().v1(),
              round: currentRound,
              time: Timestamp.now(),
              vehicleId: event?.documentId),
          Uuid().v1());
      try {
        add(UpdatedEvent(documentId: event.documentId));
      } catch (e) {}
    }
  }
}
