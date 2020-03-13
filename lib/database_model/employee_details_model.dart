import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class EmployeeDetails{
  EmployeeDetails({
    this.username,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.joinedDate,
    this.latitude,
    this.longitude,
    this.role,
    this.employeeID,
    this.empty,

  });

  final String username;
  final String phoneNumber;
  final String gender;
  final Timestamp dateOfBirth;
  final Timestamp joinedDate;
  final String latitude;
  final String longitude;
  final String role;

  final String employeeID;
  final Null empty;



  factory EmployeeDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }
    final String employeeID = documentID;

    final String username = data['employee_name'];
    final String phoneNumber = data['employee_contact_number'];
    final String gender = data['employee_gender'];
    final Timestamp dateOfBirth = data['employee_date_of_birth'];
    final Timestamp joinedDate = data['employee_join_date'];
    final String latitude = data['employee_latitude'];
    final String longitude = data['employee_longitude'];
    final String role = data['employee_role'];
    final Null empty = data['empty'];


    return EmployeeDetails(
      username: username,
      phoneNumber: phoneNumber,
      gender: gender,
      dateOfBirth: dateOfBirth,
      joinedDate: joinedDate,
      latitude: latitude,
      longitude: longitude,
      role: role,
      employeeID: employeeID,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      username != null ? 'employee_name': 'empty' : username,
      phoneNumber != null ? 'employee_contact_number':'empty' :  phoneNumber,
      gender != null ? 'employee_gender': 'empty' : gender,
      dateOfBirth != null ? 'employee_date_of_birth': 'empty' : dateOfBirth,
      joinedDate != null ? 'employee_join_date': 'empty' : joinedDate,
      latitude != null ? 'employee_latitude': 'empty' : latitude,
      longitude != null ? 'employee_longitude': 'empty' : longitude,
      role != null ? 'employee_role': 'empty' : role,
    };
  }

}