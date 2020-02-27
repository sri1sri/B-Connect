import 'dart:io';
import 'dart:async';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/notification_model.dart';
import 'package:bhavani_connect/firebase/api_path.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/firebase/firebase_common_variables.dart';
import 'package:bhavani_connect/firebase/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  final Database database;
  final File vehiceImage;
  final File MRRImage;
  final String MRRNumber;

  Uploader({Key key, this.vehiceImage, this.MRRImage, this.MRRNumber, this.database})
      : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://bconnect-9d1b5.appspot.com/');
  StorageUploadTask _uploadTask;

  void _startUpload() async {
    print('mrrno->${widget.MRRNumber}');
    String itemID = DateTime.now().toString();

    if (widget.vehiceImage != null && widget.MRRImage != null) {
      String vehiceImagePath = 'vehicel_images/${DateTime.now()}.png';
      String MRRImagePath = 'mrr_images/${DateTime.now()}.png';

      setState(() {
        _uploadTask =
            _storage.ref().child(vehiceImagePath).putFile(widget.vehiceImage);
        _uploadTask =
            _storage.ref().child(MRRImagePath).putFile(widget.MRRImage);
      });
      var vehiceImagePathURL = await (await _storage
              .ref()
              .child(vehiceImagePath)
              .putFile(widget.vehiceImage)
              .onComplete)
          .ref
          .getDownloadURL();

      var MRRImagePathURL = await (await _storage
              .ref()
              .child(MRRImagePath)
              .putFile(widget.MRRImage)
              .onComplete)
          .ref
          .getDownloadURL();

      _submitItemEntryDetails(
          vehiceImagePathURL.toString(),
          MRRImagePathURL.toString(),
          itemID, 1
      );

      _submitNotificationDetails(itemID);
    } else {
      PlatformExceptionAlertDialog(
        title: "Please add MRR and Vechicel Image.",
        exception: null,
      ).show(context);
    }
  }

  Future<void> _submitItemEntryDetails(
      String vehiceImage, String MRRImage, String itemID, int MRRNumber) async {
    final _itemEntry = GoodsEntry(
      vehicelImagePath: vehiceImage,
      mrrImagePath: MRRImage,
      securityID: EMPLOYEE_ID,
      supervisorID: 'Not assigned',
      managerID: 'Not assigned',
      accountantID: 'Not assigned',
      storeManagerID: 'Not assigned',
      securityRequestedTimestamp: Timestamp.fromDate(DateTime.now()),
      supervisorApprovalTimestamp: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
      managerApprovalTimestamp: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
      storeMangerItemReceivedTimestamp: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
      accountantTransactionStatusTimestamp: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
      MRRNumber: MRRNumber,
      approvalLevel: 0,
      itemsAdded: false,
      empty: null,
    );

    await widget.database.setGoodsEntry(_itemEntry, itemID);
  }

  Future<void> _submitNotificationDetails(String itemID) async {
    print('time=>${Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000'))}');
    final _notificationEntry = NotificationModel(
      notificationTitle: 'Item entry',
      notificationDescription:
          'Item has been entered the dite. waiting for your approval.',
      itemEntryID: itemID,
      senderID: 'VlkppQFc9jaeLgpjyt2yAIQL5wy2',
      receiverID: 'N0aPI4jS3RRE4yiDPyQhS0sVNfU2',
    );
    await widget.database.setNotification(_notificationEntry);
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete) Text('completed successufully'),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              LinearProgressIndicator(value: progressPercent),
              Text('${(progressPercent * 100).toStringAsFixed(2)}%'),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
          color: activeButtonTextColor,
          onPressed: _startUpload,
          icon: Icon(
            Icons.cloud_upload,
            size: 30,
            color: backgroundColor,
          ),
          label: Text('Submit', style: titleStyle));
    }
  }
}
