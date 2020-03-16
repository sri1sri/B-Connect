import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class ItemInventry{
  ItemInventry({

    @required this.cartID,
    @required this.itemID,
    @required this.employeeID,
    @required this.addedDate,
    @required this.empty,
    @required this.quantity,
    @required this.itemDescription,
  });

  final String cartID;
  final String itemID;
  final String employeeID;
  final Timestamp addedDate;
  final int quantity;
  final itemDescription;

  final Null empty;

  factory ItemInventry.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }

    final String cartID = documentID;

    final String itemID = data['item_id'];
    final String employeeID = data['employee_id'];
    final Timestamp addedDate = data['added_date'];
    final int quantity = data['quantity'];
    final String itemDescription = data['item_description'];
    final Null empty = data['empty'];

    return ItemInventry(
      cartID: cartID,
      itemID: itemID,
      employeeID: employeeID,
      addedDate: addedDate,
      quantity: quantity,
      itemDescription : itemDescription,
      empty: empty,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      itemID != null ? 'item_id': 'empty': itemID,
      employeeID != null ? 'employee_id': 'empty': employeeID,
      addedDate != null ? 'added_date': 'empty': addedDate,
      quantity != null ? 'quantity' : 'empty' : quantity,
      itemDescription != null ? 'item_description' : 'empty' : itemDescription,
    };
  }
}