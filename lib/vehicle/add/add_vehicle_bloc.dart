import 'dart:async';
import 'dart:convert';

import 'package:bhavani_connect/auth/bloc.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:bhavani_connect/database_model/vehicle_category.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import 'add_vehicle_extras.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _subscriptionVehicleCate;
  StreamSubscription _subscriptionVehicleType;

  // Replace with server token from firebase console settings.
  final String serverToken =
      'AAAArg5RNak:APA91bEJeORUU2Vv3DtkjtwbV2GjW1JsBZiPiEkNL3z0jY1n8PVpI7Jjv6D4fgUMgposbty5nNGg9a8MGR0zVBmiTK6iUB6YvOd8Rnecciep-Jpw5OjQp4PCGJmm8adTtfMHCBqTS8Co';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  AddVehicleBloc({this.authenticationBloc});

  final List<AddVehicleEvent> _events = new List<AddVehicleEvent>();

  @override
  AddVehicleState get initialState => AddVehicleState.initial();

  @override
  Stream<AddVehicleState> mapEventToState(AddVehicleEvent event) async* {
    firebaseMessaging.getToken().then((token) {
      print(token);
    });
    _events.add(event); // New Line
    if (event is InitDataEvent) {
      yield* _mapLoadVehicleCateToState();
    } else if (event is VehicleCategoryLoaded) {
      yield* _mapLoadVehicleTypeToState(vehicleCate: event.vehicleCate);
    } else if (event is VehicleInitUpdated) {
      yield* _mapLoadVehicleInitToState(event);
    } else if (event is SubmitVehicle) {
      yield AddVehicleState.loading();
      authenticationBloc.fireStoreDatabase
          .currentUserDetails()
          .listen((employee) {
        Vehicle vehicleEntity = mapEventToVehicle(event, employee);
        add(SubmitVehicleLast(vehicleEntity));
      });
    } else if (event is SubmitVehicleLast) {
      var vehicleId = Uuid().v1();
      await authenticationBloc.fireStoreDatabase
          .addVehicle(event.vehicleEntity, vehicleId)
          .then((value) => {sendNotification(event.vehicleEntity, vehicleId)});
      authenticationBloc.pop();
    }
  }

  dispatchPreviousState() {
    this.add(_events.removeLast());
  }

  Stream<AddVehicleState> _mapLoadVehicleCateToState() async* {
    _subscriptionVehicleCate?.cancel();
    _subscriptionVehicleCate =
        authenticationBloc.fireStoreDatabase.readAllVehicleCategory().listen(
              (vehicleCate) =>
                  add(VehicleCategoryLoaded(vehicleCate: vehicleCate)),
            );
  }

  Stream<AddVehicleState> _mapLoadVehicleTypeToState(
      {List<VehicleCategory> vehicleCate}) async* {
    _subscriptionVehicleType?.cancel();
    _subscriptionVehicleType =
        authenticationBloc.fireStoreDatabase.readAllVehicleType().listen(
              (vehicleType) => add(VehicleInitUpdated(
                  vehicleCate: vehicleCate, vehicleType: vehicleType)),
            );
  }

  Stream<AddVehicleState> _mapLoadVehicleInitToState(
      VehicleInitUpdated event) async* {
    yield AddVehicleState.successInit(
        vehicleCateList: event.vehicleCate, vehicleTypeList: event.vehicleType);
  }

  Vehicle mapEventToVehicle(SubmitVehicle event, EmployeeDetails employee) {
    return Vehicle(
        categoryId: event.vehicleCateSelected.id,
        categoryName: event.vehicleCateSelected.name,
        categoryImage: event.vehicleCateSelected.image,
        sellerName: event.dealerName,
        vehicleNo: event.vehicleNo,
        unitsPerTrip: event.unitPerTrip,
        vehicleTypeId: event.vehicleTypeSelected.id,
        vehicleTypeName: event.vehicleTypeSelected.name,
        requestedByUserId: employee.employeeID,
        requestedByUserName: employee.username,
        requestedByUserRole: employee.role,
        date: Timestamp.now(),
        dateRequest: Timestamp.now());
  }

  sendNotification(Vehicle vehicleEntity, String documentId) {
    authenticationBloc.fireStoreDatabase.readEmployees().listen((allEmployee) {
      allEmployee.forEach((employee) {
        if (employee.role == EmployeeDetails.roleSupervisor ||
            employee.role == EmployeeDetails.roleManager) {
          sendAndRetrieveMessage(
              vehicleEntity, documentId, employee.firebaseToken);
        }
      });
    });
  }

  Future<void> sendAndRetrieveMessage(
      Vehicle vehicle, String documentId, String token) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    var notificationTitle = 'Approval for Vehicle';
    var notificationBody =
        'Vehicle (${vehicle.sellerName}, ${vehicle.vehicleNo})';
    var notificationModel = NotificationModel(
      notificationID: documentId,
      senderID: authenticationBloc.fireStoreDatabase.uid,
      notificationTitle: notificationTitle,
      notificationDescription: notificationBody,
      route: 'vehicle',
      status: 0,
      itemEntryID: documentId,
    );
    await authenticationBloc.fireStoreDatabase
        .setNotification(notificationModel, documentId);

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': notificationTitle,
            'title': notificationBody
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'sender_id': vehicle.requestedByUserId,
            'status': 0,
            'route': 'vehicle'
          },
          'to': token,
        },
      ),
    );

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}

class SubmitVehicleLast extends AddVehicleEvent {
  final Vehicle vehicleEntity;

  SubmitVehicleLast(this.vehicleEntity);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
