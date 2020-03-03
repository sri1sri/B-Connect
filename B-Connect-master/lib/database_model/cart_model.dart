import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class Cart{
  Cart({

    @required this.cartID,
    @required this.itemID,
    @required this.employeeID,
    @required this.purchaseStatus,
    @required this.addedDate,
    @required this.empty,
  });

  final String cartID;
  final String itemID;
  final String employeeID;
  final bool purchaseStatus;
  final Timestamp addedDate;

  final Null empty;

  factory Cart.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String cartID = documentID;

    final String itemID = data['item_id'];
    final String employeeID = data['employee_id'];
    final bool purchaseStatus = data['purchased_status'];
    final Timestamp addedDate = data['added_date'];
    final Null empty = data['empty'];

    return Cart(
      cartID: cartID,
      itemID: itemID,
      employeeID: employeeID,
      purchaseStatus: purchaseStatus,
      addedDate: addedDate,
      empty: empty,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      itemID != null ? 'item_id': 'empty': itemID,
      employeeID != null ? 'employee_id': 'empty': employeeID,
      purchaseStatus != null ? 'purchased_status': 'empty': purchaseStatus,
      addedDate != null ? 'added_date': 'empty': addedDate,
    };
  }
}