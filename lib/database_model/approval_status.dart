import 'package:flutter/foundation.dart';

class ApprovalStatus {
  static const approvalPending = 0;
  static const approvalApproved = 1;
  static const approvalDecline = 2;

  ApprovalStatus({@required this.id, @required this.name});

  final String id;
  final String name;

  factory ApprovalStatus.fromMap(Map<String, dynamic> data, String documentID) {
    if (data == null) {
      return null;
    }

    final String approvalDocumentId = documentID;

    final String id = data['id'];
    final String name = data['name'];

    return ApprovalStatus(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      id != null ? 'id' : 'empty': id,
      name != null ? 'name' : 'empty': name
    };
  }
}
