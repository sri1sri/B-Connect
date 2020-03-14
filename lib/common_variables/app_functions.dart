import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void GoToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => page,
    ),
  );
}

//var format = new DateFormat('HH:mm a');
//String branchName;

String EMPLOYEE_ID;
ImageSource IMAGE_SOURCE = ImageSource.gallery;


String getDateTime(int timestamp) {
  var format = new DateFormat('dd MMM yyyy, hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}

String getDate(int timestamp) {
  var format = new DateFormat('dd MMMM, yyyy');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}

String getTime(int timestamp) {
  var format = new DateFormat('hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}

//void uniqifyList(List<Dynamic> list) {
//  for (int i = 0; i < list.length; i++) {
//    Dynamic o = list[i];
//    int index;
//    // Remove duplicates
//    do {
//      index = list.indexOf(o, i+1);
//      if (index != -1) {
//        list.removeRange(index, 1);
//      }
//    } while (index != -1);
//  }
//}