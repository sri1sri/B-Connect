import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class NotificationModel {
  NotificationModel({
    @required this.route,
    @required this.notificationID,
    @required this.notificationTitle,
    @required this.notificationDescription,
    @required this.senderID,
    this.receiverID,
    @required this.itemEntryID,
    this.status, // 0,1,2
    this.empty,
  });

  final String route;
  final String notificationID;
  final String notificationTitle;
  final String notificationDescription;
  final String senderID;
  final String receiverID;
  final String itemEntryID;
  int status;
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
    final String senderID = data['sender_id'];
    final String receiverID = data['receiver_id'];
    final String itemEntryID = data['item_entry_id'];
    final int status = data['status'];
    final Null empty = data['empty'];

    return NotificationModel(
      route: route,
      notificationID: notificationID,
      notificationTitle: notificationTitle,
      notificationDescription: notificationDescription,
      senderID: senderID,
      receiverID: receiverID,
      itemEntryID: itemEntryID,
      status: status,
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
      senderID != null ? 'sender_id' : 'empty': senderID,
      receiverID != null ? 'receiver_id' : 'empty': receiverID,
      itemEntryID != null ? 'item_entry_id' : 'empty': itemEntryID,
      status != null ? 'status' : 'empty': status,
    };
  }
}
