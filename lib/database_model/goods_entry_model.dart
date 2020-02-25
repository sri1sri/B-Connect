import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class GoodsEntry {
  GoodsEntry({
    @required this.itemEntryID,

    @required this.vehicelImagePath,
    @required this.mrrImagePath,

    @required this.securityID,
    @required this.supervisorID,
    @required this.managerID,
    @required this.accountantID,
    @required this.storeManagerID,

//    @required this.securityEntryStatus,
//    @required this.supervisorApproval,
//    @required this.managerApproval,
//    @required this.storeManagerItemReceivedStatus,
//    @required this.transactionStatus,

    @required this.securityRequestedTimestamp,
    @required this.supervisorApprovalTimestamp,
    @required this.managerApprovalTimestamp,
    @required this.storeMangerItemReceivedTimestamp,
    @required this.accountantTransactionStatusTimestamp,

    @required this.MRRNumber,

    @required this.approvalLevel,

  });

  final String itemEntryID;

  final String vehicelImagePath;
  final String mrrImagePath;

  final String securityID;
  final String supervisorID;
  final String managerID;
  final String storeManagerID;
  final String accountantID;
//
//  final bool securityEntryStatus;
//  final bool supervisorApproval;
//  final bool managerApproval;
//  final bool storeManagerItemReceivedStatus;
//  final bool transactionStatus;

  final Timestamp securityRequestedTimestamp;
  final Timestamp supervisorApprovalTimestamp;
  final Timestamp managerApprovalTimestamp;
  final Timestamp storeMangerItemReceivedTimestamp;
  final Timestamp accountantTransactionStatusTimestamp;

  final int MRRNumber;

  final int approvalLevel;

  factory GoodsEntry.fromMap(Map<String, dynamic> data, String documentId) {
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

//    final bool securityEntryStatus = data['security_entry_status'];
//    final bool supervisorApproval = data['supervisor_approval'];
//    final bool managerApproval = data['manager_approval'];
//    final bool storeManagerItemReceivedStatus =
//        data['store_manager_item_received_status'];
//    final bool transactionStatus = data['transaction_status'];

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

    return GoodsEntry(
      itemEntryID: itemEntryID,
      vehicelImagePath: vehicelImagePath,
      mrrImagePath: mrrImagePath,
      securityID: securityID,
      supervisorID: supervisorID,
      managerID: managerID,
      accountantID: accountantID,
      storeManagerID: storeManagerID,
//      securityEntryStatus: securityEntryStatus,
//      supervisorApproval: supervisorApproval,
//      managerApproval: managerApproval,
//      storeManagerItemReceivedStatus: storeManagerItemReceivedStatus,
//      transactionStatus: transactionStatus,
      securityRequestedTimestamp: securityRequestedTimestamp,
      supervisorApprovalTimestamp: supervisorApprovalTimestamp,
      managerApprovalTimestamp: managerApprovalTimestamp,
      storeMangerItemReceivedTimestamp: storeMangerItemReceivedTimestamp,
      accountantTransactionStatusTimestamp:
          accountantTransactionStatusTimestamp,
      MRRNumber: MRRNumber,
      approvalLevel: approvalLevel,
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
//      'security_entry_status': securityEntryStatus,
//      'supervisor_approval': supervisorApproval,
//      'manager_approval': managerApproval,
//      'store_manager_item_received_status': storeManagerItemReceivedStatus,
//      'transaction_status': transactionStatus,
      'security_requested_timestamp': securityRequestedTimestamp,
      'supervisor_approval_timestamp': supervisorApprovalTimestamp,
      'manager_approval_timestamp': managerApprovalTimestamp,
      'store_manger_item_received_timestamp': storeMangerItemReceivedTimestamp,
      'accountant_transaction_status_timestamp': accountantTransactionStatusTimestamp,
      'mrr_number': MRRNumber,
      'approval_level':approvalLevel,

    };
  }
}
