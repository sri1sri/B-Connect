import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class VehicleEvent extends Equatable {}

class VehicleState extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  VehicleState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory VehicleState.initial() => VehicleState._(unions.first(Initial()));

  factory VehicleState.loading() =>
      VehicleState._(unions.second(Loading()));

  factory VehicleState.success() =>
      VehicleState._(unions.third(Success()));

  factory VehicleState.failure({String error}) =>
      VehicleState._(unions.fourth(Failure(error: error)));
}

class Initial {}

class Loading {}

class Success {
}

class Failure {
  String error;

  Failure({this.error});
}