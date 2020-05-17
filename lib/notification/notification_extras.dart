import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class NotificationEvent extends Equatable {}

class ApproveEvent extends NotificationEvent {
  final NotificationModel notificationModel;

  ApproveEvent({this.notificationModel});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DeclineEvent extends NotificationEvent {
  final NotificationModel notificationModel;

  DeclineEvent({this.notificationModel});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitDataNotification extends NotificationEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class MapNotificationToState extends NotificationEvent {
  final List<NotificationModel> data;

  MapNotificationToState({this.data});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class NotificationState extends Union4Impl<Initial, Loading, Success, Failure> {
  static final unions = const Quartet<Initial, Loading, Success, Failure>();

  NotificationState._(Union4<Initial, Loading, Success, Failure> union)
      : super(union);

  factory NotificationState.initial() =>
      NotificationState._(unions.first(Initial()));

  factory NotificationState.loading() =>
      NotificationState._(unions.second(Loading()));

  factory NotificationState.success({List<NotificationModel> data}) =>
      NotificationState._(unions.third(Success(data: data)));

  factory NotificationState.failure({String error}) =>
      NotificationState._(unions.fourth(Failure(error: error)));
}

class Initial {}

class Loading {}

class Success {
  final List<NotificationModel> data;

  Success({this.data});
}

class Failure {
  String error;

  Failure({this.error});
}
