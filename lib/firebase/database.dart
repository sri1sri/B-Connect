
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database{

  Stream<List<EmployeesList>> readEmployees();
  Stream<EmployeesList> readEmployee(String employeeID);
  Future<void> setGoodsEntry(GoodsEntry itemEntry, String itemID);
  Stream<EmployeesList> currentUserDetails();
  Future<void> setNotification(NotificationModel notificationEntry);
  Stream<List<GoodsEntry>> readGoodsEntries();
  Future<void> setItemEntry(ItemEntry itemEntry,String goodsID);
  Stream<GoodsEntry> readGoodsDetails(String goodsID);
  Stream<List<ItemEntry>> viewItemsList(String goodsID);
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
  Stream<List<GoodsEntry>> readGoodsEntries() => _service.collectionStream(
    path: APIPath.goodsEntriesList(),
    builder: (data, documentId) => GoodsEntry.fromMap(data, documentId),
  );

  @override
  Future<void> setGoodsEntry(GoodsEntry itemEntry, String itemID) async => await _service.setData(
    path: APIPath.goodsEntry(itemID),
    data: itemEntry.toMap(),
  );

  @override
  Future<void> setNotification(NotificationModel notificationEntry) async => await _service.setData(
    path: APIPath.notification(DateTime.now().toString()),
    data: notificationEntry.toMap(),
  );

  @override
  Future<void> setItemEntry(ItemEntry itemEntry,String goodsID) async => await _service.setData(
    path: APIPath.addItem(goodsID, DateTime.now().toString()),
    data: itemEntry.toMap(),
  );
  @override
  Stream<List<ItemEntry>> viewItemsList(String goodsID) => _service.collectionStream(
    path: APIPath.viewItemsList(goodsID),
    builder: (data, documentId) => ItemEntry.fromMap(data, documentId),
  );

  @override
  Stream<GoodsEntry> readGoodsDetails(String goodsID) => _service.documentStream(
    path: APIPath.goodsEntry(goodsID),
    builder: (data, documentId) => GoodsEntry.fromMap(data, documentId),
  );


}