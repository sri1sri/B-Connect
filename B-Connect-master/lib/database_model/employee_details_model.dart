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
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'employee_name': username,
      'employee_contact_number': phoneNumber,
      'employee_gender': gender,
      'employee_date_of_birth': dateOfBirth,
      'employee_join_date': joinedDate,
      'employee_latitude': latitude,
      'employee_longitude': longitude,
      'employee_role': role,

    };
  }

}