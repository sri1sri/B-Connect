import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class ItemEntry {
  ItemEntry({
    @required this.itemEntryID,

    @required this.vehicelImagePath,
    @required this.mrrImagePath,

    @required this.securityID,
    @required this.supervisorID,
    @required this.managerID,
    @required this.accountantID,
    @required this.storeManagerID,

    @required this.securityApproval,
    @required this.supervisorApproval,
    @required this.storeManagerItemReceivedStatus,
    @required this.transactionStatus,

    @required this.securityEntryTimestamp,
    @required this.supervisorApprovalTimestamp,
    @required this.managerApprovalTimestamp,
    @required this.storeMangerItemReceivedTimestamp,
    @required this.accountantTransactionStatusTimestamp,
  });

  final String itemEntryID;

  final String vehicelImagePath;
  final String mrrImagePath;

  final String securityID;
  final String supervisorID;
  final String managerID;
  final String storeManagerID;
  final String accountantID;

  final bool securityApproval;
  final bool supervisorApproval;
  final bool storeManagerItemReceivedStatus;
  final bool transactionStatus;

  final Timestamp securityEntryTimestamp;
  final Timestamp supervisorApprovalTimestamp;
  final Timestamp managerApprovalTimestamp;
  final Timestamp storeMangerItemReceivedTimestamp;
  final Timestamp accountantTransactionStatusTimestamp;

  factory ItemEntry.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String itemEntryID = documentId;

    final String vehicelImagePath = data['vehicel_image_path'];
    final String mrrImagePath = data['mrr_image_path'];

    final String securityID = data['security_id'];
    final String supervisorID = data['supervisor_id'];
    final String managerID = data['manager_id'];
    final String accountantID = data['accountant_id'];
    final String storeManagerID = data['store_manager_id'];

    final bool securityApproval = data['security_approval'];
    final bool supervisorApproval = data['supervisor_approval'];
    final bool storeManagerItemReceivedStatus =
        data['store_manager_item_received_status'];
    final bool transactionStatus = data['transaction_status'];

    final Timestamp securityEntryTimestamp = data['security_entry_timestamp'];
    final Timestamp supervisorApprovalTimestamp =
        data['supervisor_approval_timestamp'];
    final Timestamp managerApprovalTimestamp =
        data['manager_approval_timestamp'];
    final Timestamp storeMangerItemReceivedTimestamp =
        data['store_manger_item_received_timestamp'];
    final Timestamp accountantTransactionStatusTimestamp =
        data['accountant_transaction_status_timestamp'];

    return ItemEntry(
      itemEntryID: itemEntryID,
      vehicelImagePath: vehicelImagePath,
      mrrImagePath: mrrImagePath,
      securityID: securityID,
      supervisorID: supervisorID,
      managerID: managerID,
      accountantID: accountantID,
      storeManagerID: storeManagerID,
      securityApproval: securityApproval,
      supervisorApproval: supervisorApproval,
      storeManagerItemReceivedStatus: storeManagerItemReceivedStatus,
      transactionStatus: transactionStatus,
      securityEntryTimestamp: securityEntryTimestamp,
      supervisorApprovalTimestamp: supervisorApprovalTimestamp,
      managerApprovalTimestamp: managerApprovalTimestamp,
      storeMangerItemReceivedTimestamp: storeMangerItemReceivedTimestamp,
      accountantTransactionStatusTimestamp:
          accountantTransactionStatusTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicel_image_path': vehicelImagePath,
      'mrr_image_path': mrrImagePath,
      'security_id': securityID,
      'supervisor_id': supervisorID,
      'manager_id': managerID,
      'accountant_id': accountantID,
      'store_manager_id': storeManagerID,
      'security_approval': securityApproval,
      'supervisor_approval': supervisorApproval,
      'store_manager_item_received_status': storeManagerItemReceivedStatus,
      'transaction_status': transactionStatus,
      'security_entry_timestamp': securityEntryTimestamp,
      'supervisor_approval_timestamp': supervisorApprovalTimestamp,
      'manager_approval_timestamp': managerApprovalTimestamp,
      'store_manger_item_received_timestamp': storeMangerItemReceivedTimestamp,
      'accountant_transaction_status_timestamp': accountantTransactionStatusTimestamp,
    };
  }
}
