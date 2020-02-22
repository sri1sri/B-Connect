import 'dart:io';
import 'dart:async';
import 'package:bhavani_connect/database_model/item_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  Database database;
  final File vehiceImage;
  final File MRRImage;

  Uploader({Key key, this.vehiceImage, this.MRRImage, this.database}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {

final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://bconnect-9d1b5.appspot.com');
ItemEntry _itemEntry;
StorageUploadTask _uploadTask;


void _startUpload() async{
  String vehiceImagePath = 'vehicel_images/${DateTime.now()}.png';
  String MRRImagePath = 'mrr_images/${DateTime.now()}.png';

  setState(() {
    _uploadTask = _storage.ref().child(vehiceImagePath).putFile(widget.vehiceImage);
    _uploadTask = _storage.ref().child(MRRImagePath).putFile(widget.MRRImage);

  });
  _itemEntry = new ItemEntry(vehicelImagePath: vehiceImagePath, mrrImagePath: MRRImagePath);

  await widget.database.setItemEntry(_itemEntry);

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
        onPressed: _startUpload,
        icon: Icon(Icons.cloud_upload),
        label: Text('Submit'));
  }
  }
}
