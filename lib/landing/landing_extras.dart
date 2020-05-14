import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LandingEvent extends Equatable {}

class LandingInitData extends LandingEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LandingEventGotoHome extends LandingEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LandingState {
  LandingState();

  factory LandingState.fromPrev({@required LandingState prevState}) {
    if (prevState == null) {
      return LandingState();
    } else {
      return LandingState();
    }
  }
}
