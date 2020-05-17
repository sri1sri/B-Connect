import 'dart:async';
import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bloc/bloc.dart';
import 'vehicle_result_extras.dart';

class VehicleResultBloc extends Bloc<VehicleResultEvent, VehicleResultState> {
  final AuthenticationBloc authenticationBloc;
  StreamSubscription _streamSubscriptionVehicle;

  VehicleResultBloc({this.authenticationBloc});

  @override
  VehicleResultState get initialState => VehicleResultState.loading();

  @override
  Stream<VehicleResultState> mapEventToState(VehicleResultEvent event) async* {
    if (event is InitDataVehicleResultEvent) {
      yield* _mapLoadVehicleToState(event);
    } else if (event is MapVehicleToState) {
      yield* _mapUpdateVehicle(event);
    }
  }

  Stream<VehicleResultState> _mapLoadVehicleToState(
      InitDataVehicleResultEvent event) async* {
    _streamSubscriptionVehicle?.cancel();
    _streamSubscriptionVehicle = authenticationBloc.fireStoreDatabase
        .filterVehicleList(
            sellerName: event.sellerName,
            siteName: event.siteName,
            dateFrom: event.dateFrom,
            dateTo: event.dateTo)
        .listen((vehicleList) {
      authenticationBloc.fireStoreDatabase
          .readAllVehicleCategory()
          .listen((vehicleCate) {
        vehicleList.forEach((vehicleListElement) {
          vehicleCate.forEach((vehicleCateElement) {
            if (vehicleListElement.categoryId == vehicleCateElement.id) {
              vehicleList[vehicleList.indexOf(vehicleListElement)]
                  .categoryName = vehicleCateElement.name;
              vehicleList[vehicleList.indexOf(vehicleListElement)]
                  .categoryImage = vehicleCateElement.image;
            }
          });
        });
        authenticationBloc.fireStoreDatabase
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
          authenticationBloc.fireStoreDatabase
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
            authenticationBloc.fireStoreDatabase
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

  void closeStream() {
    _streamSubscriptionVehicle?.cancel();
  }
}
