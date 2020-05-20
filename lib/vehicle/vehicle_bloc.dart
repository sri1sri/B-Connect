import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'vehicle_extras.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionVehicle;
  StreamSubscription _streamReadCurrentUser;
  StreamSubscription _streamReadEmployee;
  StreamSubscription _streamReadAllVehicle;
  StreamSubscription _streamReadVehicleType;

  VehicleBloc({this.authenticationBloc});

  @override
  VehicleState get initialState => VehicleState.initial();

  @override
  Future<void> close() {
    _streamSubscriptionVehicle?.cancel();
    _streamReadCurrentUser?.cancel();
    _streamReadEmployee?.cancel();
    _streamReadAllVehicle?.cancel();
    _streamReadVehicleType?.cancel();
    return super.close();
  }

  @override
  Stream<VehicleState> mapEventToState(VehicleEvent event) async* {
    if (event is LoadDataEvent) {
      yield* _mapLoadVehicleToState();
    } else if (event is MapVehicleToState) {
      yield* _mapUpdateVehicle(event);
    }
  }

  Stream<VehicleState> _mapLoadVehicleToState() async* {
    _streamSubscriptionVehicle?.cancel();
    _streamSubscriptionVehicle = authenticationBloc.fireStoreDatabase
        .readAllVehicleToday(date: DateTime.now())
        .listen((vehicleList) {
        _streamReadVehicleType = authenticationBloc.fireStoreDatabase
            .readAllVehicleType()
            .listen((vehicleType) {
          vehicleList.forEach((vehicleListElement) {
            vehicleType.forEach((vehicleTypeElement) {
              if (vehicleListElement.vehicleTypeId == vehicleTypeElement.id) {
                vehicleList[vehicleList.indexOf(vehicleListElement)]
                    .vehicleTypeName = vehicleTypeElement.name;
              }
            });
          });
          _streamReadEmployee = authenticationBloc.fireStoreDatabase
              .readEmployees()
              .listen((employeeList) {
            vehicleList.forEach((vehicleListElement) {
              employeeList.forEach((employeeElement) {
                if (vehicleListElement.requestedByUserId ==
                    employeeElement.employeeID) {
                  vehicleList[vehicleList.indexOf(vehicleListElement)]
                      .requestedByUserName = employeeElement.username;
                  vehicleList[vehicleList.indexOf(vehicleListElement)]
                      .requestedByUserRole = employeeElement.role;
                }
                if (vehicleListElement.approvedByUserId ==
                    employeeElement.employeeID) {
                  vehicleList[vehicleList.indexOf(vehicleListElement)]
                      .approvedByUserName = employeeElement.username;
                  vehicleList[vehicleList.indexOf(vehicleListElement)]
                      .approvedByUserRole = employeeElement.role;
                }
              });
            });
            _streamReadCurrentUser = authenticationBloc.fireStoreDatabase
                .currentUserDetails()
                .listen((employee) {
              _streamSubscriptionVehicle?.cancel();
              _streamReadCurrentUser?.cancel();
              _streamReadEmployee?.cancel();
              _streamReadAllVehicle?.cancel();
              _streamReadVehicleType?.cancel();
              add(MapVehicleToState(
                  vehicleList: vehicleList, employee: employee));
            });
          });
        });
    });
  }

  Stream<VehicleState> _mapUpdateVehicle(MapVehicleToState event) async* {
    yield VehicleState.success(
        vehicleList: event.vehicleList, employee: event.employee);
  }
}
