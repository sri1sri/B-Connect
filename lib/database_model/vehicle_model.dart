import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String documentId;
  String slno;
  Timestamp date;
  Timestamp dateRequest;
  Timestamp dateApproval;
  String vehicleNo;
  String site;
  String sellerName;
  String vehicleTypeId;
  String vehicleTypeName;
  Timestamp startTime;
  String startRead;
  Timestamp endTime;
  String endRead;
  String totalTime;
  String totalRead;
  String totalTrips;
  String unitsPerTrip;
  String requestedByUserId;
  String requestedByUserName;
  String requestedByUserRole;
  String approvedByUserId;
  String approvedByUserName;
  String approvedByUserRole;
  int approvalStatus;

  Vehicle({
    this.documentId,
    this.slno,
    this.date,
    this.dateRequest,
    this.dateApproval,
    this.vehicleNo,
    this.site,
    this.sellerName,
    this.vehicleTypeId,
    this.vehicleTypeName,
    this.startTime,
    this.startRead,
    this.endTime,
    this.endRead,
    this.totalTime,
    this.totalRead,
    this.totalTrips,
    this.unitsPerTrip,
    this.requestedByUserId,
    this.requestedByUserName,
    this.requestedByUserRole,
    this.approvedByUserId,
    this.approvedByUserName,
    this.approvedByUserRole,
    this.approvalStatus,
  });

  factory Vehicle.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String vehicleDocumentId = documentId;

    final String slno = data['slno'];
    final Timestamp date =  data['date'];
    final Timestamp dateRequest =  data['date_request'];
    final Timestamp dateApproval =  data['date_approval'];
    final String vehicleNo = data['vehicle_no'];
    final String site = data['site'];
    final String sellerName = data['seller_name'];
    final String categoryId = data['category_id'];
    final String categoryName = data['category_name'];
    final String categoryImage = data['category_image'];
    final String vehicleTypeId = data['vehicle_type_id'];
    final String vehicleTypeName = data['vehicle_type_name'];
    final Timestamp startTime = data['start_time'];
    final String startRead = data['start_read'];
    final Timestamp endTime = data['end_time'];
    final String endRead = data['end_read'];
    final String totalTime = data['total_time'];
    final String totalRead = data['total_read'];
    final String totalTrips = data['total_trips'];
    final String unitsPerTrip = data['units_per_trip'];
    final String requestedByUserId = data['requested_by_user_id'];
    final String requestedByUserName = data['requested_by_user_name'];
    final String requestedByUserRole = data['requested_by_user_role'];
    final String approvedByUserId = data['approved_by_user_id'];
    final String approvedByUserName = data['approved_by_user_name'];
    final String approvedByUserRole = data['approved_by_user_role'];
    final int approvalStatus = data['approval_status'];

    return Vehicle(
      documentId: vehicleDocumentId,
      slno: slno,
      date: date,
      dateRequest: dateRequest,
      dateApproval: dateApproval,
      vehicleNo: vehicleNo,
      site: site,
      sellerName: sellerName,
      vehicleTypeId: vehicleTypeId,
      vehicleTypeName: vehicleTypeName,
      startTime: startTime,
      startRead: startRead,
      endTime: endTime,
      endRead: endRead,
      totalTime: totalTime,
      totalRead: totalRead,
      totalTrips: totalTrips,
      unitsPerTrip: unitsPerTrip,
      requestedByUserId: requestedByUserId,
      requestedByUserName: requestedByUserName,
      requestedByUserRole: requestedByUserRole,
      approvedByUserId: approvedByUserId,
      approvedByUserName: approvedByUserName,
      approvedByUserRole: approvedByUserRole,
      approvalStatus: approvalStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      slno != null ? 'slno' : 'empty': slno,
      date != null ? 'date' : 'empty': date,
      dateRequest != null ? 'date_request' : 'empty': dateRequest,
      dateApproval != null ? 'date_approval' : 'empty': dateApproval,
      vehicleNo != null ? 'vehicle_no' : 'empty': vehicleNo,
      site != null ? 'site' : 'empty': site,
      sellerName != null ? 'seller_name' : 'empty': sellerName,
      vehicleTypeId != null ? 'vehicle_type_id' : 'empty': vehicleTypeId,
      vehicleTypeName != null ? 'vehicle_type_name' : 'empty': vehicleTypeName,
      startTime != null ? 'start_time' : 'empty': startTime,
      startRead != null ? 'start_read' : 'empty': startRead,
      endTime != null ? 'end_time' : 'empty': endTime,
      endRead != null ? 'end_read' : 'empty': endRead,
      totalTime != null ? 'total_time' : 'empty': totalTime,
      totalRead != null ? 'total_read' : 'empty': totalRead,
      totalTrips != null ? 'total_trips' : 'empty': totalTrips,
      unitsPerTrip != null ? 'units_per_trip' : 'empty': unitsPerTrip,
      requestedByUserId != null ? 'requested_by_user_id' : 'empty': requestedByUserId,
      requestedByUserName != null ? 'requested_by_user_name' : 'empty': requestedByUserName,
      requestedByUserRole != null ? 'requested_by_user_role' : 'empty': requestedByUserRole,
      approvedByUserId != null ? 'approved_by_user_id' : 'empty': approvedByUserId,
      approvedByUserName != null ? 'approved_by_user_name' : 'empty': approvedByUserName,
      approvedByUserRole != null ? 'approved_by_user_role' : 'empty': approvedByUserRole,
      approvalStatus != null ? 'approval_status' : 'empty': approvalStatus,
    };
  }
}
