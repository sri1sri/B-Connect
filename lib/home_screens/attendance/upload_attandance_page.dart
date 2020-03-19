
import 'dart:io';

import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/attendance_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UploadAttendancePage extends StatelessWidget {
  UploadAttendancePage({@required this.capturedImage, @required this.database, @required this.attendanceType, @required this.uploadTime});
  Database database;
  File capturedImage;
  int attendanceType;
DateTime uploadTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_UploadAttendancePage(capturedImage: capturedImage, database: database, attendanceType: attendanceType, uploadTime: uploadTime),
    );
  }
}

class F_UploadAttendancePage extends StatefulWidget {
  F_UploadAttendancePage({@required this.capturedImage, @required this.database, @required this.attendanceType, @required this.uploadTime});
  File capturedImage;
  Database database;
  int attendanceType;
  DateTime uploadTime;

  @override
  _F_UploadAttandancePageState createState() => _F_UploadAttandancePageState();
}

class _F_UploadAttandancePageState extends State<F_UploadAttendancePage> {

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://bconnect-9d1b5.appspot.com/');
  StorageUploadTask _uploadTask;
  String _profilePicPathURL;

  bool _loading;
  double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }


  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.black38,
                ),
              ),
              leftAction: () {
                Navigator.pop(context, true);
              },
              primaryText: null,
              secondaryText: 'Upload attendance',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget uploadAttendanceContent(Widget uploadAttendance){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          //
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(widget.attendanceType == 0 ?
                      'In Time:' : 'Out Time:',
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(DateFormat("dd MMMM yyyy, HH:mm a").format(DateTime.now()).toString(), style: subTitleStyle),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: widget.capturedImage == null
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Text('Tap here to \nupload image',
                              style: subTitleStyle),
                        ),
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(widget.capturedImage), // here add your image file path
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),

                uploadAttendance,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events == null ? null :_uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            _progressValue =
            event != null ? event.bytesTransferred / event.totalByteCount : 0;
            return uploadAttendanceContent(
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LinearProgressIndicator(
                      value: _progressValue,
                    ),
                    Text('${(_progressValue * 100).round()}%'),
                  ],
                ),
              ),
            );

          },
      );
    }else{
      return uploadAttendanceContent(
        ToDoButton(
          assetName: '',
          text: 'Update Attendance',
          textColor: Colors.white,
          backgroundColor: activeButtonBackgroundColor,
          onPressed: (){
            _imageUpload();
          },
        ),
      );
    }
  }


  void _imageUpload() async {

    print('Attendance->${widget.capturedImage}');

    if (widget.capturedImage != null ) {
      String _profilePicPath = 'attandance_pics/${widget.uploadTime}.png';
      setState(() {
        _uploadTask =
            _storage.ref().child(_profilePicPath).putFile(widget.capturedImage);
      });
      _profilePicPathURL = await (await _storage
          .ref()
          .child(_profilePicPath)
          .putFile(widget.capturedImage)
          .onComplete)
          .ref
          .getDownloadURL();

      _submit(_profilePicPathURL);
    }else {
      PlatformExceptionAlertDialog(
        title: "Please add Image.",
        exception: null,
      ).show(context);
    }
  }

  Future<void> _submit(String path) async {
    try {
      if(widget.attendanceType == 0){

        final uploadAttendance = Attendance(
          inTime: Timestamp.fromDate(widget.uploadTime),
          inTimePic: path,
          outTime: null,
        );
        print(uploadAttendance);
        await widget.database.setAttendanceEntry(uploadAttendance, DateFormat("dd MMMM yyyy").format(widget.uploadTime).toString());
      }else{
        final uploadAttendance = Attendance(
          outTime: Timestamp.fromDate(widget.uploadTime),
          outTimePic: path,
        );
        await widget.database.updateAttendanceEntry(uploadAttendance, DateFormat("dd MMMM yyyy").format(widget.uploadTime).toString());
      }
Navigator.pop(context, true);

    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Something went wrong.',
        exception: e,
      ).show(context);
    }
  }

}
