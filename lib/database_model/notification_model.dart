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
  });

  final String notificationID;
  final String notificationTitle;
  final String notificationDescription;
  final String senderID;
  final String receiverID;
  final String itemEntryID;


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

    return NotificationModel(
      notificationID: notificationID,
      notificationTitle: notificationTitle,
      notificationDescription: notificationDescription,
      senderID: senderID,
      receiverID: receiverID,
      itemEntryID: itemEntryID,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notification_title': notificationTitle,
      'notification_description': notificationDescription,
      'sender_id': senderID,
      'receiver_id': receiverID,
      'item_entry_id': itemEntryID,
    };
  }
}
