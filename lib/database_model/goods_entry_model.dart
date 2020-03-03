import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class GoodsEntry {
  GoodsEntry({
    @required this.goodsEntryID,

    @required this.vehicelImagePath,
    @required this.mrrImagePath,

    @required this.securityID,
    @required this.supervisorID,
    @required this.managerID,
    @required this.accountantID,
    @required this.storeManagerID,

    @required this.securityRequestedTimestamp,
    @required this.supervisorApprovalTimestamp,
    @required this.managerApprovalTimestamp,
    @required this.storeMangerItemReceivedTimestamp,
    @required this.accountantTransactionStatusTimestamp,

    @required this.MRRNumber,

    @required this.approvalLevel,

    @required this.itemsAdded,

    @required this.empty,

  });

  final String goodsEntryID;

  final String vehicelImagePath;
  final String mrrImagePath;

  final String securityID;
  final String supervisorID;
  final String managerID;
  final String storeManagerID;
  final String accountantID;

  final Timestamp securityRequestedTimestamp;
  final Timestamp supervisorApprovalTimestamp;
  final Timestamp managerApprovalTimestamp;
  final Timestamp storeMangerItemReceivedTimestamp;
  final Timestamp accountantTransactionStatusTimestamp;

  final int MRRNumber;

  final int approvalLevel;

  final bool itemsAdded;

  final Null empty;

  factory GoodsEntry.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String goodsEntryID = documentId;

    final String vehicelImagePath = data['vehicel_image_path'];
    final String mrrImagePath = data['mrr_image_path'];

    final String securityID = data['security_id'];
    final String supervisorID = data['supervisor_id'];
    final String managerID = data['manager_id'];
    final String accountantID = data['accountant_id'];
    final String storeManagerID = data['store_manager_id'];

    final Timestamp securityRequestedTimestamp = data['security_requested_timestamp'];
    final Timestamp supervisorApprovalTimestamp =
        data['supervisor_approval_timestamp'];
    final Timestamp managerApprovalTimestamp =
        data['manager_approval_timestamp'];
    final Timestamp storeMangerItemReceivedTimestamp =
        data['store_manger_item_received_timestamp'];
    final Timestamp accountantTransactionStatusTimestamp =
        data['accountant_transaction_status_timestamp'];

    final int MRRNumber =
    data['mrr_number'];

    final int approvalLevel =
    data['approval_level'];

    final bool itemsAdded = data['items_added'];

    final Null empty = data['empty'];

    return GoodsEntry(
      goodsEntryID: goodsEntryID,
      vehicelImagePath: vehicelImagePath,
      mrrImagePath: mrrImagePath,
      securityID: securityID,
      supervisorID: supervisorID,
      managerID: managerID,
      accountantID: accountantID,
      storeManagerID: storeManagerID,
      securityRequestedTimestamp: securityRequestedTimestamp,
      supervisorApprovalTimestamp: supervisorApprovalTimestamp,
      managerApprovalTimestamp: managerApprovalTimestamp,
      storeMangerItemReceivedTimestamp: storeMangerItemReceivedTimestamp,
      accountantTransactionStatusTimestamp:
          accountantTransactionStatusTimestamp,
      MRRNumber: MRRNumber,
      approvalLevel: approvalLevel,
      itemsAdded: itemsAdded,
      empty: empty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      vehicelImagePath != null ? 'vehicel_image_path': 'empty': vehicelImagePath,
      mrrImagePath != null ? 'mrr_image_path': 'empty': mrrImagePath,
      securityID != null ? 'security_id': 'empty': securityID,
      supervisorID != null ? 'supervisor_id': 'empty': supervisorID,
      managerID != null ? 'manager_id': 'empty': managerID,
      accountantID != null ? 'accountant_id': 'empty': accountantID,
      storeManagerID != null ? 'store_manager_id': 'empty': storeManagerID,
      securityRequestedTimestamp != null ? 'security_requested_timestamp': 'empty': securityRequestedTimestamp,
      supervisorApprovalTimestamp != null ? 'supervisor_approval_timestamp': 'empty': supervisorApprovalTimestamp,
      managerApprovalTimestamp != null ? 'manager_approval_timestamp': 'empty': managerApprovalTimestamp,
      storeMangerItemReceivedTimestamp != null ? 'store_manger_item_received_timestamp': 'empty': storeMangerItemReceivedTimestamp,
      accountantTransactionStatusTimestamp != null ? 'accountant_transaction_status_timestamp': 'empty': accountantTransactionStatusTimestamp,
      MRRNumber != null ? 'mrr_number': 'empty': MRRNumber,
      approvalLevel != null ? 'approval_level': 'empty': approvalLevel,
      itemsAdded != null ? 'items_added': 'empty': itemsAdded,
    };
  }
}