import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class NotificationModel {
  NotificationModel({
    @required this.notificationID,
    @required this.notificationTitle,
    @required this.notificationDescription,
    @required this.senderID,
    @required this.receiverID,
    @required this.itemEntryID,
    @required this.empty,
  });

  final String notificationID;
  final String notificationTitle;
  final String notificationDescription;
  final String senderID;
  final String receiverID;
  final String itemEntryID;
  final Null empty;


  factory NotificationModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String notificationID = documentId;
    final String notificationTitle = data['notification_title'];
    final String notificationDescription = data['notification_description'];
    final String senderID = data['sender_id'];
    final String receiverID = data['receiver_id'];
    final String itemEntryID = data['item_entry_id'];
    final Null empty = data['empty'];


    return NotificationModel(
      notificationID: notificationID,
      notificationTitle: notificationTitle,
      notificationDescription: notificationDescription,
      senderID: senderID,
      receiverID: receiverID,
      itemEntryID: itemEntryID,
      empty: empty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      notificationDescription != null ? 'notification_description': 'empty' : notificationDescription,
      notificationTitle != null ? 'notification_title': 'empty' : notificationTitle,
      senderID != null ? 'sender_id': 'empty' : senderID,
      receiverID != null ? 'receiver_id': 'empty' : receiverID,
      itemEntryID != null ? 'item_entry_id': 'empty' : itemEntryID,
    };
  }
}
