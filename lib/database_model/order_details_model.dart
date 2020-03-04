import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class OrderDetails {
  OrderDetails({
    @required this.orderID,

    @required this.itemID,
    @required this.itemQuantity,

    @required this.siteManagerID,
    @required this.managerID,
    @required this.supervisorID,
    @required this.storeManagerID,

    @required this.siteManagerOrderedTimestamp,
    @required this.managerApprovalTimestamp,
    @required this.storeMangerDeliveredTimestamp,
    @required this.siteManagerReceivedTimestamp,

    @required this.status,

    @required this.empty,

  });

  final String orderID;

  final itemID;
  final itemQuantity;

  final String siteManagerID;
  final String supervisorID;
  final String managerID;
  final String storeManagerID;

  final Timestamp siteManagerOrderedTimestamp;
  final Timestamp storeMangerDeliveredTimestamp;
  final Timestamp managerApprovalTimestamp;
  final Timestamp siteManagerReceivedTimestamp;

  final int status;

  final Null empty;

  factory OrderDetails.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String orderID = documentId;

    final itemID = data['item_id'];
    final itemQuantity = data['item_quantity'];

    final String siteManagerID = data['site_manager_id'];
    final String supervisorID = data['supervisor_id'];
    final String managerID = data['manager_id'];
    final String storeManagerID = data['store_manager_id'];

    final Timestamp siteManagerOrderedTimestamp = data['site_manager_ordered_timestamp'];
    final Timestamp storeMangerDeliveredTimestamp =
    data['store_manger_delivered_timestamp'];
    final Timestamp managerApprovalTimestamp =
    data['manager_approval_timestamp'];
    final Timestamp siteManagerReceivedTimestamp =
    data['site_manager_received_timestamp'];

    final int status =
    data['status'];

    final Null empty = data['empty'];

    return OrderDetails(
      orderID: orderID,
      itemID: itemID,
      siteManagerID: siteManagerID,
      supervisorID: supervisorID,
      managerID: managerID,
      storeManagerID: storeManagerID,
      siteManagerOrderedTimestamp: siteManagerOrderedTimestamp,
      storeMangerDeliveredTimestamp: storeMangerDeliveredTimestamp,
      managerApprovalTimestamp: managerApprovalTimestamp,
      siteManagerReceivedTimestamp: siteManagerReceivedTimestamp,
      status: status,
      empty: empty,
        itemQuantity:itemQuantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      itemID != null ? 'item_id': 'empty': itemID,
      siteManagerID != null ? 'site_manager_id': 'empty': siteManagerID,
      supervisorID != null ? 'supervisor_id': 'empty': supervisorID,
      managerID != null ? 'manager_id': 'empty': managerID,
      storeManagerID != null ? 'store_manager_id': 'empty': storeManagerID,
      siteManagerOrderedTimestamp != null ? 'site_manager_ordered_timestamp': 'empty': siteManagerOrderedTimestamp,
      storeMangerDeliveredTimestamp != null ? 'store_manger_delivered_timestamp': 'empty': storeMangerDeliveredTimestamp,
      managerApprovalTimestamp != null ? 'manager_approval_timestamp': 'empty': managerApprovalTimestamp,
      siteManagerReceivedTimestamp != null ? 'site_manager_received_timestamp': 'empty': siteManagerReceivedTimestamp,
      status != null ? 'status': 'empty': status,
      itemQuantity != null ? 'item_quantity' : 'empty' : itemQuantity,
      'empty':null,
    };
  }
}