import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String slno;
  Timestamp date;
  String vehicleNo;
  String site;
  String sellerName;
  String imgCate;
  String categoryId;
  String vehicleTypeId;
  String startTime;
  String startRead;
  String endTime;
  String endRead;
  String totalTime;
  String totalRead;
  String totalTrips;
  String unitsPerTrip;
  String requestedByUserId;
  String approvedByUserId;
  String approvalStatus;

  Vehicle({
    this.slno,
    this.date,
    this.vehicleNo,
    this.site,
    this.sellerName,
    this.imgCate,
    this.categoryId,
    this.vehicleTypeId,
    this.startTime,
    this.startRead,
    this.endTime,
    this.endRead,
    this.totalTime,
    this.totalRead,
    this.totalTrips,
    this.unitsPerTrip,
    this.requestedByUserId,
    this.approvedByUserId,
    this.approvalStatus,
  });

  factory Vehicle.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String slno = data['slno'];
    final Timestamp date =  data['date'];
    final String vehicleNo = data['vehicle_no'];
    final String site = data['site'];
    final String sellerName = data['seller_name'];
    final String imgCate = data['img_cate'];
    final String categoryId = data['category_id'];
    final String vehicleTypeId = data['vehicle_type_id'];
    final String startTime = data['start_time'];
    final String startRead = data['start_read'];
    final String endTime = data['end_time'];
    final String endRead = data['end_read'];
    final String totalTime = data['total_time'];
    final String totalRead = data['total_read'];
    final String totalTrips = data['total_trips'];
    final String unitsPerTrip = data['units_per_trip'];
    final String requestedByUserId = data['requested_by_user_id'];
    final String approvedByUserId = data['approved_by_user_id'];
    final String approvalStatus = data['approval_status'];

    return Vehicle(
      slno: slno,
      date: date,
      vehicleNo: vehicleNo,
      site: site,
      sellerName: sellerName,
      imgCate: imgCate,
      categoryId: categoryId,
      vehicleTypeId: vehicleTypeId,
      startTime: startTime,
      startRead: startRead,
      endTime: endTime,
      endRead: endRead,
      totalTime: totalTime,
      totalRead: totalRead,
      totalTrips: totalTrips,
      unitsPerTrip: unitsPerTrip,
      requestedByUserId: requestedByUserId,
      approvedByUserId: approvedByUserId,
      approvalStatus: approvalStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      slno != null ? 'slno' : 'empty': slno,
      date != null ? 'date' : 'empty': date,
      vehicleNo != null ? 'vehicle_no' : 'empty': vehicleNo,
      site != null ? 'site' : 'empty': site,
      sellerName != null ? 'seller_name' : 'empty': sellerName,
      imgCate != null ? 'img_cate' : 'empty': imgCate,
      categoryId != null ? 'category_id' : 'empty': categoryId,
      vehicleTypeId != null ? 'vehicle_type_id' : 'empty': vehicleTypeId,
      startTime != null ? 'start_time' : 'empty': startTime,
      startRead != null ? 'start_read' : 'empty': startRead,
      endTime != null ? 'end_time' : 'empty': endTime,
      endRead != null ? 'end_read' : 'empty': endRead,
      totalTime != null ? 'total_time' : 'empty': totalTime,
      totalRead != null ? 'total_read' : 'empty': totalRead,
      totalTrips != null ? 'total_trips' : 'empty': totalTrips,
      unitsPerTrip != null ? 'units_per_trip' : 'empty': unitsPerTrip,
      requestedByUserId != null ? 'requested_by_user_id' : 'empty': requestedByUserId,
      approvedByUserId != null ? 'approved_by_user_id' : 'empty': approvedByUserId,
      approvalStatus != null ? 'approval_status' : 'empty': approvalStatus,
    };
  }
}
