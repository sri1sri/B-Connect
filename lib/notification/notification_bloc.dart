import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/database_model/approval_status.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_extras.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  AuthenticationBloc authenticationBloc;

  StreamSubscription _streamReadNotification;
  StreamSubscription _streamReadVehicle;
  StreamSubscription _streamReadCurrentUser;
  StreamSubscription _streamReadCurrentUserApproval;
  StreamSubscription _streamReadCurrentUserDecline;
  Stream _readNotification;

  NotificationBloc({this.authenticationBloc});

  @override
  NotificationState get initialState => NotificationState.loading();

  @override
  Future<void> close() {
    _streamReadCurrentUser?.cancel();
    _streamReadCurrentUserApproval?.cancel();
    _streamReadCurrentUserDecline?.cancel();
    _streamReadVehicle?.cancel();
    _streamReadNotification?.cancel();
    return super.close();
  }

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is InitDataNotification) {
      add(ReadRoleEmployee());
    } else if (event is ReadRoleEmployee) {
      _streamReadCurrentUser = authenticationBloc.fireStoreDatabase
          .currentUserDetails()
          .listen((currentUser) {
        add((ReadNotification(currentUser)));
      });
    } else if (event is ReadNotification) {
      _streamReadNotification?.cancel();
      if (isCanApprove(event.currentUser.role)) {
        _readNotification =
            authenticationBloc.fireStoreDatabase.readAllNotification();
      } else {
        _readNotification = authenticationBloc.fireStoreDatabase
            .readNotificationBy(requestById: event?.currentUser?.employeeID);
      }
      if (_readNotification == null) {
        add(MapNotificationToEmpty());
      } else {
        _streamReadNotification = _readNotification.listen((notificationList) {
          add(MapNotificationToState(
              data: notificationList, role: event?.currentUser?.role));
        });
      }
    } else if (event is MapNotificationToEmpty) {
      yield NotificationState.empty();
    } else if (event is MapNotificationToState) {
      if (event.data.isEmpty) {
        add(MapNotificationToEmpty());
      } else {
        event.data.forEach((element) {
          if (isCanApprove(event.role)) {
            element.isShowAction = true;
          }
        });
        event.data.sort((a,b) => b.date.compareTo(a.date));
        yield NotificationState.success(data: event.data);
      }
    } else if (event is ApproveEvent) {
      _streamReadVehicle = authenticationBloc.fireStoreDatabase
          .readVehicle(event.notificationModel.itemEntryID)
          .listen((vehicle) {
        _streamReadVehicle?.cancel();
        _streamReadCurrentUserApproval = authenticationBloc.fireStoreDatabase
            .currentUserDetails()
            .listen((user) {
          _streamReadVehicle?.cancel();
          _streamReadCurrentUserApproval?.cancel();
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
      _streamReadVehicle = authenticationBloc.fireStoreDatabase
          .readVehicle(event.notificationModel.itemEntryID)
          .listen((vehicle) {
        _streamReadVehicle?.cancel();
        _streamReadCurrentUserDecline = authenticationBloc.fireStoreDatabase
            .currentUserDetails()
            .listen((user) {
          _streamReadCurrentUserDecline?.cancel();
          _streamReadVehicle?.cancel();
          vehicle.approvalStatus = ApprovalStatus.approvalDecline;
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

  bool isCanApprove([String role]) {
    return role == EmployeeDetails.roleStoreManager ||
        role == EmployeeDetails.roleManager ||
        role == EmployeeDetails.roleSupervisor;
  }
}
