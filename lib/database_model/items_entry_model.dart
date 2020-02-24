import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class ItemEntry {
  ItemEntry({
    @required this.itemID,
    @required this.companyName,
    @required this.categoryName,
    @required this.quantity,
    @required this.itemName,
  });

  final String itemID;
  final String companyName;
  final String categoryName;
  final String itemName;
  final int quantity;

  factory ItemEntry.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String itemID = documentId;

    final String companyName = data['company_name'];
    final String categoryName = data['category_name'];
    final String itemName = data['item_name'];
    final int quantity = data['quantity'];

    return ItemEntry(
      itemID: itemID,
      companyName: companyName,
      categoryName: categoryName,
      itemName: itemName,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company_name': companyName,
      'category_name':categoryName,
      'item_name': itemName,
      'quantity':quantity
    };
  }
}
