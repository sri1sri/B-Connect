import 'package:flutter/foundation.dart';

class VehicleType {
  VehicleType({@required this.id, @required this.name});

  final String id;
  final String name;

  factory VehicleType.fromMap(Map<String, dynamic> data, String documentID) {
    if (data == null) {
      return null;
    }

    final String vehicleId = documentID;

    final String id = data['id'];
    final String name = data['name'];

    return VehicleType(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      id != null ? 'id' : 'empty': id,
      name != null ? 'name' : 'empty': name
    };
  }
}
