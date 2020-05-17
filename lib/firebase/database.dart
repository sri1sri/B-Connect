import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/database_model/attendance_model.dart';
import 'package:bhavani_connect/database_model/cart_model.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/item_inventry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:bhavani_connect/database_model/order_details_model.dart';
import 'package:bhavani_connect/database_model/vehicle_category.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/database_model/vehicle_trip_record.dart';
import 'package:bhavani_connect/database_model/vehicle_type.dart';
import 'package:bhavani_connect/vehicle/detail/trip/vehicle_detail_trip_extras.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Stream<List<EmployeeDetails>> readEmployees();

  Stream<EmployeeDetails> readEmployee(String employeeID);

  Future<void> setGoodsEntry(GoodsEntry itemEntry, String itemID);

  Stream<EmployeeDetails> currentUserDetails();

  Future<void> setNotification(NotificationModel notificationEntry);

  Stream<List<GoodsEntry>> readGoodsEntries(String queryKey);

  Future<void> setItemEntry(ItemEntry itemEntry);

  Stream<GoodsEntry> readGoodsDetails(String goodsID);

  Stream<List<ItemEntry>> viewItemsList(String goodsID);

  Stream<EmployeeDetails> readEmployeeDetails();

  Future<void> updateGoodsEntry(GoodsEntry itemEntry, String itemID);

  Future<void> updateNotification(
      NotificationModel notificationEntry, String notificationID);

  Stream<CommonVaribles> readCommonVariables();

  Future<void> updateCommonVariables(CommonVaribles itemEntry);

  Future<void> setcartItems(Cart cart, String cartID);

  Stream<Cart> readCartDetails(String cartID);

  Stream<List<Cart>> viewCartItems();

  Stream<ItemEntry> viewItem(String itemID);

  Future<void> deleteCartItem(String cartID);

  Stream<List<Cart>> addCartItemStatus(String itemID);

  Future<void> ordersEntry(OrderDetails orderDetails);

  Stream<List<OrderDetails>> readOrders(String queryKey);

  Stream<List<ItemEntry>> viewMultipleItem(itemsID);

  Stream<List<ItemEntry>> viewMultipleItems(orderID, itemsID);

  Stream<OrderDetails> readSingleOrder(String orderID);

  Stream<String> readOrderQty(String orderID, String itemId);

  Future<void> updateOrderDetails(OrderDetails orderDetails, String itemID);

  Future<void> updateCartDetails(Cart cartDetails, String cartID);

  Future<void> updateEmployeeDetails(
      EmployeeDetails employeeDetails, String employeeUID);

  Future<void> updateItemDetails(ItemEntry itemDetails, String itemID);

  Future<void> setInventryItems(ItemInventry itemInventry, String inventryID);

  Stream<ItemInventry> readInventryDetails(String inventryID);

  Stream<List<ItemInventry>> viewInventryItems();

  Stream<List<ItemInventry>> viewInventryItemsInCart(List items);

  Future<void> updateInventryDetails(
      ItemInventry inventryDetails, String inventryID);

  Future<void> deleteItemInventry(String inventryID);

  Future<void> setAttendanceEntry(
      Attendance attendanceEntry, String attendanceID);

  Future<void> updateAttendanceEntry(
      Attendance attendanceEntry, String attendanceID);

  Stream<Attendance> readAttendance();

  Stream<List<Attendance>> readAllAttendance();

  Stream<List<Vehicle>> readAllVehicle();

  Future<void> addVehicle(Vehicle vehicle, String vehicleId);

  Stream<Vehicle> readVehicle(String documentId);

  Future<void> updateVehicle(Vehicle vehicle, String vehicleId);

  Stream<List<VehicleCategory>> readAllVehicleCategory();

  Stream<List<VehicleType>> readAllVehicleType();

  Future<void> addTripRecord(VehicleTripRecord tripRecord, String tripRecordId);

  Stream<List<VehicleTripRecord>> readAllTripRecord();

  Stream<List<VehicleTripRecord>> readTripRecordMaxRound(String documentId);

  Stream<List<VehicleTripRecord>> readTripRecordBy(String documentId);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<List<EmployeeDetails>> readEmployees() => _service.collectionStream(
        path: APIPath.employeesList(),
        builder: (data, documentId) =>
            EmployeeDetails.fromMap(data, documentId),
      );

  @override
  Stream<EmployeeDetails> currentUserDetails() => _service.documentStream(
        path: APIPath.employeeDetails(uid),
        builder: (data, documentId) =>
            EmployeeDetails.fromMap(data, documentId),
      );

  @override
  Stream<EmployeeDetails> readEmployee(String employeeID) =>
      _service.documentStream(
        path: APIPath.employeeDetails(employeeID),
        builder: (data, documentId) =>
            EmployeeDetails.fromMap(data, documentId),
      );

  @override
  Stream<List<GoodsEntry>> readGoodsEntries(String queryKey) =>
      _service.collectionStream(
        path: APIPath.goodsEntriesList(),
        builder: (data, documentId) => GoodsEntry.fromMap(data, documentId),
        queryBuilder: (query) =>
            query.where(queryKey, whereIn: ['Not assigned', EMPLOYEE_ID]),
      );

  @override
  Future<void> setGoodsEntry(GoodsEntry itemEntry, String itemID) async =>
      await _service.setData(
        path: APIPath.goodsEntry(itemID),
        data: itemEntry.toMap(),
      );

  @override
  Future<void> setNotification(NotificationModel notificationEntry) async =>
      await _service.setData(
        path: APIPath.notification(DateTime.now().toString()),
        data: notificationEntry.toMap(),
      );

  @override
  Future<void> updateNotification(
          NotificationModel notificationEntry, String notificationID) async =>
      await _service.updateData(
        path: APIPath.notification(notificationID),
        data: notificationEntry.toMap(),
      );

  @override
  Future<void> setItemEntry(ItemEntry itemEntry) async =>
      await _service.setData(
        path: APIPath.addItem(itemEntry.item_id),
        data: itemEntry.toMap(),
      );

  @override
  Future<void> updateGoodsEntry(GoodsEntry itemEntry, String itemID) async =>
      await _service.updateData(
        path: APIPath.goodsEntry(itemID),
        data: itemEntry.toMap(),
      );

  @override
  Stream<List<ItemEntry>> viewItemsList(String goodsID) =>
      _service.collectionStream(
        path: APIPath.viewItemsList(),
        builder: (data, documentId) => ItemEntry.fromMap(data, documentId),
        queryBuilder: goodsID != null
            ? (query) => query.where('goods_id', isEqualTo: goodsID)
            : (query) => query.where('quantity_available', isGreaterThan: -1),
      );

  @override
  Stream<GoodsEntry> readGoodsDetails(String goodsID) =>
      _service.documentStream(
        path: APIPath.goodsEntry(goodsID),
        builder: (data, documentId) => GoodsEntry.fromMap(data, documentId),
      );

  @override
  Stream<EmployeeDetails> readEmployeeDetails() => _service.documentStream(
        path: APIPath.employeeDetails(uid),
        builder: (data, documentId) =>
            EmployeeDetails.fromMap(data, documentId),
      );

  @override
  Stream<CommonVaribles> readCommonVariables() => _service.documentStream(
        path: APIPath.commonVariables(),
        builder: (data, documentId) => CommonVaribles.fromMap(data, documentId),
      );

  @override
  Future<void> updateCommonVariables(CommonVaribles itemEntry) async =>
      await _service.updateData(
        path: APIPath.commonVariables(),
        data: itemEntry.toMap(),
      );

  @override
  Future<void> setcartItems(Cart cart, String cartID) async =>
      await _service.setData(
        path: APIPath.addCart(cartID),
        data: cart.toMap(),
      );

  @override
  Stream<Cart> readCartDetails(String cartID) => _service.documentStream(
        path: APIPath.addCart(cartID),
        builder: (data, documentId) => Cart.fromMap(data, documentId),
      );

  @override
  Stream<List<Cart>> viewCartItems() => _service.collectionStream(
        path: APIPath.viewCart(),
        builder: (data, documentId) => Cart.fromMap(data, documentId),
        queryBuilder: (query) => query
            .where('employee_id', isEqualTo: EMPLOYEE_ID)
            .where('purchased_status', isEqualTo: false),
      );

  @override
  Stream<ItemEntry> viewItem(String itemID) => _service.documentStream(
        path: APIPath.addItem(itemID),
        builder: (data, documentId) => ItemEntry.fromMap(data, documentId),
      );

  @override
  Future<void> deleteCartItem(String cartID) async => await _service.deleteData(
        path: APIPath.addCart(cartID),
      );

  @override
  Stream<List<Cart>> addCartItemStatus(String itemID) =>
      _service.collectionStream(
        path: APIPath.viewCart(),
        builder: (data, documentId) => Cart.fromMap(data, documentId),
        queryBuilder: (query) => query
            .where('item_id', isEqualTo: itemID)
            .where('employee_id', isEqualTo: uid),
      );

  @override
  Future<void> ordersEntry(OrderDetails orderDetails) async =>
      await _service.setData(
        path: APIPath.ordersEntry(DateTime.now().toString()),
        data: orderDetails.toMap(),
      );

  @override
  Stream<List<OrderDetails>> readOrders(String queryKey) =>
      _service.collectionStream(
        path: APIPath.viewOrders(),
        builder: (data, documentId) => OrderDetails.fromMap(data, documentId),
        queryBuilder: (query) =>
            query.where(queryKey, whereIn: ['Not assigned', EMPLOYEE_ID]),
      );

  @override
  Stream<List<ItemEntry>> viewMultipleItem(itemsID) =>
      _service.collectionStream(
        path: APIPath.viewItemsList(),
        builder: (data, documentId) => ItemEntry.fromMap(data, documentId),
        queryBuilder: (query) => query.where('item_id', whereIn: itemsID),
      );

  @override
  Stream<List<ItemEntry>> viewMultipleItems(orderId, itemsID) =>
      _service.collectionStream(
        path: APIPath.viewItemsList(),
        builder: (data, documentId) => ItemEntry.fromMap(data, documentId),
        queryBuilder: (query) => query.where('item_id', whereIn: itemsID),
      );

  @override
  Stream<OrderDetails> readSingleOrder(String orderID) =>
      _service.documentStream(
        path: APIPath.ordersEntry(orderID),
        builder: (data, documentId) => OrderDetails.fromMap(data, documentId),
      );

  @override
  Stream<String> readOrderQty(String orderID, String itemId) =>
      _service.documentStream(
        path: APIPath.ordersEntry(orderID),
        builder: (data, documentId) => getQty(data, documentId, itemId),
      );

  String getQty(Map<String, dynamic> data, String documentId, String itemId) {
    if (data == null) {
      return null;
    }
    final String orderID = documentId;

    String qty = '0';

    var itemID = data['item_id'];
    var itemQuantity = data['item_quantity'];

    for (var i = 0; i < itemID.length; i++) {
      if (itemID[i].toString() == itemId) {
        qty = itemQuantity[i].toString();
        break;
      }
    }
    return qty;
  }

  @override
  Future<void> updateOrderDetails(
          OrderDetails orderDetails, String itemID) async =>
      await _service.updateData(
        path: APIPath.ordersEntry(itemID),
        data: orderDetails.toMap(),
      );

  @override
  Future<void> updateCartDetails(Cart cartDetails, String cartID) async =>
      await _service.updateData(
        path: APIPath.addCart(cartID),
        data: cartDetails.toMap(),
      );

  @override
  Future<void> updateEmployeeDetails(
          EmployeeDetails employeeDetails, String employeeUID) async =>
      await _service.updateData(
        path: APIPath.employeeDetails(employeeUID),
        data: employeeDetails.toMap(),
      );

  @override
  Future<void> updateItemDetails(ItemEntry itemDetails, String itemID) async =>
      await _service.updateData(
        path: APIPath.addItem(itemID),
        data: itemDetails.toMap(),
      );

  @override
  Future<void> setInventryItems(
          ItemInventry itemInventry, String inventryID) async =>
      await _service.setData(
        path: APIPath.addInventry(inventryID),
        data: itemInventry.toMap(),
      );

  @override
  Stream<ItemInventry> readInventryDetails(String inventryID) =>
      _service.documentStream(
        path: APIPath.addInventry(inventryID),
        builder: (data, documentId) => ItemInventry.fromMap(data, documentId),
      );

  @override
  Stream<List<ItemInventry>> viewInventryItems() => _service.collectionStream(
        path: APIPath.viewInventry(),
        builder: (data, documentId) => ItemInventry.fromMap(data, documentId),
        queryBuilder: (query) =>
            query.where('employee_id', isEqualTo: EMPLOYEE_ID),
      );

  @override
  Stream<List<ItemInventry>> viewInventryItemsInCart(List items) =>
      _service.collectionStream(
        path: APIPath.viewInventry(),
        builder: (data, documentId) => ItemInventry.fromMap(data, documentId),
        queryBuilder: (query) => query.where('item_id', whereIn: items),
      );

  @override
  Future<void> updateInventryDetails(
          ItemInventry inventryDetails, String inventryID) async =>
      await _service.updateData(
        path: APIPath.addInventry(inventryID),
        data: inventryDetails.toMap(),
      );

  @override
  Future<void> deleteItemInventry(String inventryID) async =>
      await _service.deleteData(
        path: APIPath.addInventry(inventryID),
      );

  @override
  Future<void> setAttendanceEntry(
          Attendance attendanceEntry, String attendanceID) async =>
      await _service.setData(
        path: APIPath.attandanceEntry(uid, attendanceID),
        data: attendanceEntry.toMap(),
      );

  @override
  Future<void> updateAttendanceEntry(
          Attendance attendanceEntry, String attendanceID) async =>
      await _service.updateData(
        path: APIPath.attandanceEntry(uid, attendanceID),
        data: attendanceEntry.toMap(),
      );

  @override
  Stream<Attendance> readAttendance() => _service.documentStream(
        path: APIPath.attandanceEntry(
            uid, DateFormat("dd MMMM yyyy").format(DateTime.now()).toString()),
        builder: (data, documentId) => Attendance.fromMap(data, documentId),
      );

  @override
  Stream<List<Attendance>> readAllAttendance() => _service.collectionStream(
        path: APIPath.viewAttandance(uid),
        builder: (data, documentId) => Attendance.fromMap(data, documentId),
      );

  @override
  Stream<List<Vehicle>> readAllVehicle() => _service.collectionStream(
        path: APIPath.viewVehicle(),
        builder: (data, documentId) => Vehicle.fromMap(data, documentId),
      );

  @override
  Future<void> addVehicle(Vehicle vehicle, String vehicleId) async =>
      await _service.setData(
        path: APIPath.addVehicle(vehicleId),
        data: vehicle.toMap(),
      );

  @override
  Stream<List<VehicleCategory>> readAllVehicleCategory() =>
      _service.collectionStream(
        path: APIPath.viewVehicleCategory(),
        builder: (data, documentId) =>
            VehicleCategory.fromMap(data, documentId),
      );

  @override
  Stream<List<VehicleType>> readAllVehicleType() => _service.collectionStream(
        path: APIPath.viewVehicleType(),
        builder: (data, documentId) => VehicleType.fromMap(data, documentId),
      );

  @override
  Future<void> updateVehicle(Vehicle vehicle, String documentId) async {
    await _service.updateData(
      path: APIPath.updateVehicle(documentId: documentId),
      data: vehicle.toMap(),
    );
  }

  @override
  Stream<Vehicle> readVehicle(String documentId) => _service.documentStream(
        path: APIPath.viewVehicleDetail(documentId),
        builder: (data, documentId) => Vehicle.fromMap(data, documentId),
      );

  @override
  Future<void> addTripRecord(
          VehicleTripRecord tripRecord, String tripRecordId) async =>
      await _service.setData(
        path: APIPath.addTripRecord(tripRecordId),
        data: tripRecord.toMap(),
      );

  @override
  Stream<List<VehicleTripRecord>> readAllTripRecord() =>
      _service.collectionStream(
        path: APIPath.readAllTripRecord(),
        builder: (data, documentId) =>
            VehicleTripRecord.fromMap(data, documentId),
      );

  @override
  Stream<List<VehicleTripRecord>> readTripRecordMaxRound(documentId) =>
      _service.collectionStream(
        path: APIPath.readAllTripRecord(),
        queryBuilder: (query) => query.where('vehicle_id', whereIn: [documentId]).orderBy('round', descending: true).limit(1),
        builder: (data, documentId) =>
            VehicleTripRecord.fromMap(data, documentId),
      );

  @override
  Stream<List<VehicleTripRecord>> readTripRecordBy(documentId) =>
      _service.collectionStream(
        path: APIPath.readAllTripRecord(),
        queryBuilder: (query) => query.where('vehicle_id', whereIn: [documentId]),
        builder: (data, documentId) =>
            VehicleTripRecord.fromMap(data, documentId),
      );
}
