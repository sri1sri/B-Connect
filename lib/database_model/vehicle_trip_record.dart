import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class VehicleTripRecord {
  VehicleTripRecord(
      {@required this.id,
      @required this.round,
      @required this.time,
      @required this.vehicleId});

  final String id;
  final int round;
  final Timestamp time;
  final String vehicleId;

  factory VehicleTripRecord.fromMap(
      Map<String, dynamic> data, String documentID) {
    if (data == null) {
      return null;
    }

    final String documentId = documentID;

    final String id = data['id'];
    final int round = data['round'];
    final Timestamp time = data['time'];
    final String vehicleId = data['vehicle_id'];

    return VehicleTripRecord(
      id: id,
      round: round,
      time: time,
      vehicleId: vehicleId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      id != null ? 'id' : 'empty': id,
      round != null ? 'round' : 'empty': round,
      time != null ? 'time' : 'empty': time,
      vehicleId != null ? 'vehicle_id' : 'empty': vehicleId
    };
  }
}
