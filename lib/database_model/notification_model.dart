import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class NotificationModel {
  NotificationModel({
    this.route,
    this.notificationID,
    this.notificationTitle,
    this.notificationDescription,
    this.requestById,
    this.approveById,
    this.itemEntryID,
    this.status, // 0,1,2
    this.date,
    this.isShowAction = false,
    this.empty,
  });

  final String route;
  final String notificationID;
  final String notificationTitle;
  final String notificationDescription;
  final String requestById;
  final String approveById;
  final String itemEntryID;
  Timestamp date;
  int status;
  bool isShowAction;
  final Null empty;

  factory NotificationModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String route = data['route'];
    final String notificationID = documentId;
    final String notificationTitle = data['notification_title'];
    final String notificationDescription = data['notification_description'];
    final String requestById = data['request_by_id'];
    final String approveById = data['approve_by_id'];
    final String itemEntryID = data['item_entry_id'];
    final int status = data['status'];
    final Timestamp date = data['date'];
    final Null empty = data['empty'];

    return NotificationModel(
      route: route,
      notificationID: notificationID,
      notificationTitle: notificationTitle,
      notificationDescription: notificationDescription,
      requestById: requestById,
      approveById: approveById,
      itemEntryID: itemEntryID,
      status: status,
      date: date,
      empty: empty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      route != null ? 'route' : 'empty': route,
      notificationDescription != null ? 'notification_description' : 'empty':
          notificationDescription,
      notificationTitle != null ? 'notification_title' : 'empty':
          notificationTitle,
      requestById != null ? 'request_by_id' : 'empty': requestById,
      approveById != null ? 'approve_by_id' : 'empty': approveById,
      itemEntryID != null ? 'item_entry_id' : 'empty': itemEntryID,
      status != null ? 'status' : 'empty': status,
      date != null ? 'date' : 'empty': date,
    };
  }
}
