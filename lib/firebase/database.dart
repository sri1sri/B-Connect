
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/database_model/cart_model.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:bhavani_connect/database_model/order_details_model.dart';
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
  Future<void> setItemEntry(ItemEntry itemEntry);
  Stream<GoodsEntry> readGoodsDetails(String goodsID);
  Stream<List<ItemEntry>> viewItemsList(String goodsID);
  Stream<EmployeeDetails> readEmployeeDetails();
  Future<void> updateGoodsEntry(GoodsEntry itemEntry, String itemID);
  Future<void> updateNotification(NotificationModel notificationEntry, String notificationID);
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
  Stream<OrderDetails> readSingleOrder(String orderID);
  Future<void> updateOrderDetails(OrderDetails orderDetails, String itemID);
  Future<void> updateCartDetails(Cart cartDetails, String cartID);
  Future<void> updateEmployeeDetails(EmployeeDetails employeeDetails, String employeeUID);
  Future<void> updateItemDetails(ItemEntry itemDetails, String itemID);


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
    path: APIPath.notification( DateTime.now().toString()),
    data: notificationEntry.toMap(),
  );

  @override
  Future<void> updateNotification(NotificationModel notificationEntry, String notificationID) async => await _service.updateData(
    path: APIPath.notification(notificationID),
    data: notificationEntry.toMap(),
  );

  @override
  Future<void> setItemEntry(ItemEntry itemEntry) async => await _service.setData(
    path: APIPath.addItem(itemEntry.item_id),
    data: itemEntry.toMap(),
  );

  @override
  Future<void> updateGoodsEntry(GoodsEntry itemEntry, String itemID) async => await _service.updateData(
    path: APIPath.goodsEntry(itemID),
    data: itemEntry.toMap(),
  );


  @override
  Stream<List<ItemEntry>> viewItemsList(String goodsID) =>  _service.collectionStream(
    path: APIPath.viewItemsList(),
    builder: (data, documentId) => ItemEntry.fromMap(data, documentId),
    queryBuilder: goodsID != null ? (query) => query.where('goods_id', isEqualTo: goodsID) : (query) => query.where('quantity_available', isGreaterThan: -1),
  );

  @override
  Stream<GoodsEntry> readGoodsDetails(String goodsID) => _service.documentStream(
    path: APIPath.goodsEntry(goodsID),
    builder: (data, documentId) => GoodsEntry.fromMap(data, documentId),
  );

  @override
  Stream<EmployeeDetails> readEmployeeDetails() => _service.documentStream(
    path: APIPath.employeeDetails(uid),
    builder: (data, documentId) => EmployeeDetails.fromMap(data, documentId),
  );

  @override
  Stream<CommonVaribles> readCommonVariables() => _service.documentStream(
    path: APIPath.commonVariables(),
    builder: (data, documentId) => CommonVaribles.fromMap(data, documentId),
  );

  @override
  Future<void> updateCommonVariables(CommonVaribles itemEntry) async => await _service.updateData(
    path: APIPath.commonVariables(),
    data: itemEntry.toMap(),
  );

  @override
  Future<void> setcartItems(Cart cart, String cartID) async => await _service.setData(
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
    queryBuilder: (query) => query.where('employee_id', isEqualTo: EMPLOYEE_ID).where('purchased_status', isEqualTo: false),
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
  Stream<List<Cart>> addCartItemStatus(String itemID) => _service.collectionStream(
    path: APIPath.viewCart(),
    builder: (data, documentId) => Cart.fromMap(data, documentId),
    queryBuilder: (query) => query.where('item_id', isEqualTo: itemID),
  );

  @override
  Future<void> ordersEntry(OrderDetails orderDetails) async => await _service.setData(
    path: APIPath.ordersEntry(DateTime.now().toString()),
    data: orderDetails.toMap(),
  );

  @override
  Stream<List<OrderDetails>> readOrders(String queryKey) => _service.collectionStream(
    path: APIPath.viewOrders(),
    builder: (data, documentId) => OrderDetails.fromMap(data, documentId),
    queryBuilder: (query) => query.where(queryKey, isEqualTo: EMPLOYEE_ID),
  );

  @override
  Stream<List<ItemEntry>> viewMultipleItem(itemsID) => _service.collectionStream(
    path: APIPath.viewItemsList(),
    builder: (data, documentId) => ItemEntry.fromMap(data, documentId),
    queryBuilder: (query) => query.where('item_id', whereIn: itemsID),
  );

  @override
  Stream<OrderDetails> readSingleOrder(String orderID) => _service.documentStream(
    path: APIPath.ordersEntry(orderID),
    builder: (data, documentId) => OrderDetails.fromMap(data, documentId),
  );

  @override
  Future<void> updateOrderDetails(OrderDetails orderDetails, String itemID) async => await _service.updateData(
    path: APIPath.ordersEntry(itemID),
    data: orderDetails.toMap(),
  );

  @override
  Future<void> updateCartDetails(Cart cartDetails, String cartID) async => await _service.updateData(
    path: APIPath.addCart(cartID),
    data: cartDetails.toMap(),
  );

  @override
  Future<void> updateEmployeeDetails(EmployeeDetails employeeDetails, String employeeUID) async => await _service.updateData(
    path: APIPath.employeeDetails(employeeUID),
    data: employeeDetails.toMap(),
  );

  @override
  Future<void> updateItemDetails(ItemEntry itemDetails, String itemID) async => await _service.updateData(
    path: APIPath.addItem(itemID),
    data: itemDetails.toMap(),
  );
}