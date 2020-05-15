import 'package:flutter/foundation.dart';

class VehicleCategory {
  VehicleCategory(
      {@required this.id, @required this.name, @required this.image});

  final String id;
  final String name;
  final String image;

  bool hasSelected = false;

  factory VehicleCategory.fromMap(
      Map<String, dynamic> data, String documentID) {
    if (data == null) {
      return null;
    }

    final String vehicleId = documentID;

    final String id = data['id'];
    final String name = data['name'];
    final String image = data['image'];

    final Null empty = data['empty'];

    return VehicleCategory(
      id: id,
      name: name,
      image: image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      id != null ? 'id' : 'empty': id,
      name != null ? 'name' : 'empty': name,
      image != null ? 'image' : 'empty': image,
    };
  }
}
