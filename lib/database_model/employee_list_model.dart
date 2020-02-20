import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class EmployeesList {
  EmployeesList({
    @required this.employeeID,
    @required this.employeeName,
    @required this.employeeRole,
    @required this.employeeLatitude,
    @required this.employeeLongitude,
    @required this.employeeJoinDate,
    @required this.employeeGender,
    @required this.employeeDateOfBirth,
    @required this.employeeContactNumber,
  });

  final String employeeID;
  final String employeeName;
  final String employeeRole;
  final String employeeLatitude;
  final String employeeLongitude;
  final String employeeJoinDate;
  final String employeeGender;
  final String employeeDateOfBirth;
  final String employeeContactNumber;


  factory EmployeesList.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String employeeID = documentId;
    final String employeeName = data['employee_name'];
    final String employeeRole = data['employee_role'];
    final String employeeLatitude = data['employee_latitude'];
    final String employeeLongitude = data['employee_longitude'];
    final String employeeJoinDate = data['employee_join_date'];
    final String employeeGender = data['employee_gender'];
    final String employeeDateOfBirth = data['employee_date_of_birth'];
    final String employeeContactNumber = data['employee_contact_number'];

    return EmployeesList(
      employeeID: employeeID,
      employeeName: employeeName,
      employeeRole: employeeRole,
      employeeLatitude: employeeLatitude,
      employeeLongitude: employeeLongitude,
      employeeJoinDate: employeeJoinDate,
      employeeDateOfBirth: employeeDateOfBirth,
      employeeContactNumber: employeeContactNumber,
      employeeGender: employeeGender,

    );
  }
}
