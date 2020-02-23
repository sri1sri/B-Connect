import 'dart:io';
import 'dart:async';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/item_entry_model.dart';
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

  Uploader({Key key, this.vehiceImage, this.MRRImage, this.database}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {

final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://bconnect-9d1b5.appspot.com');
StorageUploadTask _uploadTask;


void _startUpload() async{
  String itemID = DateTime.now().toString();

  if( widget.vehiceImage != null && widget.MRRImage != null){
    String vehiceImagePath = 'vehicel_images/${DateTime.now()}.png';
    String MRRImagePath = 'mrr_images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(vehiceImagePath).putFile(widget.vehiceImage);
      _uploadTask = _storage.ref().child(MRRImagePath).putFile(widget.MRRImage);

    });
    _submitItemEntryDetails(vehiceImagePath, MRRImagePath, itemID);
    _submitNotificationDetails(itemID);
  }else{
    PlatformExceptionAlertDialog(
      title: "Please add MRR and Vechicel Image.",
      exception: null,
    ).show(context);
  }
}

Future<void>_submitItemEntryDetails(String vehiceImage, String MRRImage, String itemID) async {

  final _itemEntry = ItemEntry(
    vehicelImagePath: vehiceImage,
    mrrImagePath: MRRImage,

    securityID: 'VlkppQFc9jaeLgpjyt2yAIQL5wy2',
    supervisorID: 'N0aPI4jS3RRE4yiDPyQhS0sVNfU2',
    managerID: 'HuOG1oaJCHSebSOKVeN3MNIU0eT2',
    accountantID: '',

    securityApproval: false,
    supervisorApproval: false,
    storeManagerItemReceivedStatus: false,
    transactionStatus: false,

    securityEntryTimestamp: Timestamp.fromDate(DateTime.now()),
    supervisorApprovalTimestamp: null,
    managerApprovalTimestamp: null,
    storeMangerItemReceivedTimestamp:null,
    accountantTransactionStatusTimestamp:null,

  );
  await widget.database.setItemEntry(_itemEntry, itemID);
}

Future<void>_submitNotificationDetails(String itemID) async {

  final _notificationEntry = NotificationModel(
    notificationTitle: 'Item entry',
    notificationDescription: 'Item has been entered the dite. waiting for your approval.',
    itemEntryID: itemID,
    senderID: 'VlkppQFc9jaeLgpjyt2yAIQL5wy2',
    receiverID: 'N0aPI4jS3RRE4yiDPyQhS0sVNfU2',

  );
  await widget.database.setNotification(_notificationEntry);
}

  @override
  Widget build(BuildContext context) {
  if(_uploadTask != null){
    return StreamBuilder<StorageTaskEvent>(
      stream: _uploadTask.events,
      builder: (context, snapshot){
        var event = snapshot?.data?.snapshot;

        double progressPercent = event != null
            ? event.bytesTransferred / event.totalByteCount
            : 0;
        return Column(
          children: <Widget>[
            if(_uploadTask.isComplete)
              Text('completed successufully'),

            if (_uploadTask.isPaused)
              FlatButton(
                child: Icon(Icons.pause),
                onPressed: _uploadTask.resume,
              ),

            if(_uploadTask.isInProgress)
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
  }else{
    return FlatButton.icon(
        color: activeButtonTextColor,
        onPressed: _startUpload,
        icon: Icon(Icons.cloud_upload,size: 30,color: backgroundColor,),
        label: Text('Submit',style:titleStyle));
  }
  }
}






