import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bloc/bloc.dart';
import 'vehicle_result_extras.dart';

class VehicleResultBloc extends Bloc<VehicleResultEvent, VehicleResultState> {
  final AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionVehicle;
  StreamSubscription _streamVehicleType;
  StreamSubscription _streamReadEmployee;
  StreamSubscription _streamReadCurrentUser;

  VehicleResultBloc({this.authenticationBloc});

  @override
  VehicleResultState get initialState => VehicleResultState.loading();

  @override
  Stream<VehicleResultState> mapEventToState(VehicleResultEvent event) async* {
    if (event is InitDataVehicleResultEvent) {
      cancelStreamSubs();
      yield* _mapLoadVehicleToState(event);
    } else if (event is MapVehicleToState) {
      cancelStreamSubs();
      yield* _mapUpdateVehicle(event);
    }
  }

  void cancelStreamSubs() {
    _streamSubscriptionVehicle?.cancel();
    _streamVehicleType?.cancel();
    _streamReadEmployee?.cancel();
    _streamReadCurrentUser?.cancel();
  }

  Stream<VehicleResultState> _mapLoadVehicleToState(
      InitDataVehicleResultEvent event) async* {
    _streamSubscriptionVehicle = authenticationBloc.fireStoreDatabase
        .filterVehicleList(
            sellerName: event.sellerName,
            siteName: event.siteName,
            dateFrom: event.dateFrom,
            dateTo: event.dateTo)
        .listen((vehicleList) {
      _streamVehicleType = authenticationBloc.fireStoreDatabase
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
            add(MapVehicleToState(
                vehicleList: vehicleList,
                sellerName: event.sellerName,
                siteName: event.siteName,
                dateFrom: event.dateFrom,
                dateTo: event.dateTo));
          });
        });
      });
    });
  }

  Stream<VehicleResultState> _mapUpdateVehicle(MapVehicleToState event) async* {
    yield VehicleResultState.success(
        vehicleList: event.vehicleList,
        sellerName: event.sellerName,
        siteName: event.siteName,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo);
  }
}
