import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
@immutable
abstract class VehicleListEvent extends Equatable {
  VehicleListEvent([List props = const []]);
}