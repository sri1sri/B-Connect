import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class Attendance{
  Attendance({

    @required this.attendanceID,
    @required this.inTime,
    @required this.outTime,
    @required this.inTimePic,
    @required this.outTimePic,
    @required this.empty,
  });

  final String attendanceID;
  final Timestamp inTime;
  final Timestamp outTime;
  final String inTimePic;
  final String outTimePic;

  final Null empty;

  factory Attendance.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String attendanceID = documentID;

    final Timestamp inTime = data['in_time'];
    final Timestamp outTime = data['out_time'];
    final String inTimePic = data['in_time_pic'];
    final String outTimePic = data['out_time_pic'];
    final Null empty = data['empty'];

    return Attendance(
      attendanceID: attendanceID,
      inTime: inTime,
      outTime: outTime,
      inTimePic: inTimePic,
      outTimePic: outTimePic,
      empty: empty,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      inTime != null ? 'in_time': 'empty': inTime,
      outTime != null ? 'out_time': 'empty': outTime,
      inTimePic != null ? 'in_time_pic': 'empty': inTimePic,
      outTimePic != null ? 'out_time_pic' : 'empty' : outTimePic,
    };
  }
}