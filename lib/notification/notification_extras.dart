import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

abstract class NotificationEvent extends Equatable {}

class ReadNotification extends NotificationEvent {
  final EmployeeDetails currentUser;

  ReadNotification(this.currentUser);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ReadRoleEmployee extends NotificationEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

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

class MapNotificationToEmpty extends NotificationEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class MapNotificationToState extends NotificationEvent {
  final List<NotificationModel> data;
  final String role;

  MapNotificationToState({this.data, this.role});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class NotificationState
    extends Union5Impl<Initial, Loading, Empty, Success, Failure> {
  static final unions =
      const Quintet<Initial, Loading, Empty, Success, Failure>();

  NotificationState._(Union5<Initial, Loading, Empty, Success, Failure> union)
      : super(union);

  factory NotificationState.initial() =>
      NotificationState._(unions.first(Initial()));

  factory NotificationState.loading() =>
      NotificationState._(unions.second(Loading()));

  factory NotificationState.empty() =>
      NotificationState._(unions.third(Empty()));

  factory NotificationState.success({List<NotificationModel> data}) =>
      NotificationState._(unions.fourth(Success(data: data)));

  factory NotificationState.failure({String error}) =>
      NotificationState._(unions.fifth(Failure(error: error)));
}

class Initial {}

class Empty {}

class Loading {}

class Success {
  final List<NotificationModel> data;

  Success({this.data});
}

class Failure {
  String error;

  Failure({this.error});
}
