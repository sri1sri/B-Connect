import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SearchVehicleEvent extends Equatable {}

class SearchVehicleState {

  SearchVehicleState();

  factory SearchVehicleState.fromPrev(
      {@required SearchVehicleState prevState}) {
    if (prevState == null) {
      return SearchVehicleState();
    } else {
      return SearchVehicleState();
    }
  }
}