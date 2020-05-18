import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/database_model/approval_status.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_extras.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  AuthenticationBloc authenticationBloc;

  NotificationBloc({this.authenticationBloc});

  @override
  NotificationState get initialState => NotificationState.loading();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is InitDataNotification) {
      authenticationBloc.fireStoreDatabase
          .readAllNotification()
          .listen((event) {
        add(MapNotificationToState(data: event));
      });
    } else if (event is MapNotificationToState) {
      yield NotificationState.success(data: event.data);
    } else if (event is ApproveEvent) {
      authenticationBloc.fireStoreDatabase
          .readVehicle(event.notificationModel.itemEntryID)
          .listen((vehicle) {
        authenticationBloc.fireStoreDatabase
            .currentUserDetails()
            .listen((user) {
          vehicle.approvalStatus = ApprovalStatus.approvalApproved;
          vehicle.approvedByUserId = user.employeeID;
          vehicle.approvedByUserName = user.username;
          vehicle.approvedByUserRole = user.role;
          vehicle.dateApproval = Timestamp.now();
          authenticationBloc.fireStoreDatabase
              .updateVehicle(vehicle, vehicle.documentId);

          event.notificationModel.status = ApprovalStatus.approvalApproved;
          authenticationBloc.fireStoreDatabase.updateNotification(
              event.notificationModel, event.notificationModel.notificationID);
        });
      });
    } else if (event is DeclineEvent) {
      authenticationBloc.fireStoreDatabase
          .readVehicle(event.notificationModel.itemEntryID)
          .listen((vehicle) {
        authenticationBloc.fireStoreDatabase
            .currentUserDetails()
            .listen((user) {
          vehicle.approvalStatus = ApprovalStatus.approvalApproved;
          vehicle.approvedByUserId = user.employeeID;
          vehicle.approvedByUserName = user.username;
          vehicle.approvedByUserRole = user.role;
          vehicle.dateApproval = Timestamp.now();
          authenticationBloc.fireStoreDatabase
              .updateVehicle(vehicle, vehicle.documentId);

          event.notificationModel.status = ApprovalStatus.approvalDecline;
          authenticationBloc.fireStoreDatabase.updateNotification(
              event.notificationModel, event.notificationModel.notificationID);
        });
      });
    }
  }
}
