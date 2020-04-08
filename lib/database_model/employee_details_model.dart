import 'package:cloud_firestore/cloud_firestore.dart';
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
    this.employeeImagePath,
    this.deviceToken,

  });

  final String username;
  final String phoneNumber;
  final String gender;
  final Timestamp dateOfBirth;
  final Timestamp joinedDate;
  final String latitude;
  final String longitude;
  final String role;
  final String employeeImagePath;
  final String deviceToken;

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
    final String employeeImagePath = data['employee_image_path'];
    final String deviceToken = data['device_token'];

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
      employeeImagePath: employeeImagePath,
      deviceToken:deviceToken,
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
      deviceToken != null ? 'device_token': 'empty' : deviceToken,
      employeeImagePath != null ? 'employee_image_path': 'empty' : employeeImagePath,
    };
  }

}