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
    @required this.measure,
    @required this.goodsID,

  });

  final String itemID;
  final String companyName;
  final String categoryName;
  final String itemName;
  final int quantity;
  final String measure;
  final String goodsID;

  factory ItemEntry.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String itemID = documentId;

    final String companyName = data['company_name'];
    final String categoryName = data['category_name'];
    final String itemName = data['item_name'];
    final int quantity = data['quantity'];
    final String measure = data['measure'];
    final String goodsID = data['goods_id'];

    return ItemEntry(
      itemID: itemID,
      companyName: companyName,
      categoryName: categoryName,
      itemName: itemName,
      quantity: quantity,
        measure:measure,
        goodsID:goodsID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company_name': companyName,
      'category_name':categoryName,
      'item_name': itemName,
      'quantity':quantity,
      'measure': measure,
      'goods_id':goodsID,
    };
  }
}
