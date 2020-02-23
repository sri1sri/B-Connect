
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/database_model/item_entry_model.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database{

  Stream<List<EmployeesList>> readEmployees();
  Stream<EmployeesList> readEmployee(String employeeID);
  Future<void> setItemEntry(ItemEntry itemEntry, String itemID);
  Stream<EmployeesList> currentUserDetails();
  Future<void> setNotification(NotificationModel notificationEntry);

//  Future<void> addCustomerDetails(CustomersDetails customersDetails);
//  Stream<UserDetails> userDetails();

}

class FirestoreDatabase implements Database {

  FirestoreDatabase({@required this.uid}) : assert (uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<List<EmployeesList>> readEmployees() => _service.collectionStream(
    path: APIPath.employeesList(),
    builder: (data, documentId) => EmployeesList.fromMap(data, documentId),
  );
  @override
  Stream<EmployeesList> currentUserDetails() => _service.documentStream(
    path: APIPath.employeeDetails(uid),
    builder: (data, documentId) => EmployeesList.fromMap(data, documentId),
  );

  @override
  Stream<EmployeesList> readEmployee(String employeeID) => _service.documentStream(
    path: APIPath.employeeDetails(employeeID),
    builder: (data, documentId) => EmployeesList.fromMap(data, documentId),
  );




  @override
  Future<void> setItemEntry(ItemEntry itemEntry, String itemID) async => await _service.setData(
    path: APIPath.itemEntry(itemID),
    data: itemEntry.toMap(),
  );

  @override
  Future<void> setNotification(NotificationModel notificationEntry) async => await _service.setData(
    path: APIPath.notification(DateTime.now().toString()),
    data: notificationEntry.toMap(),
  );


}