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
    @required this.item_id,


  });

  final String itemID;
  final String companyName;
  final String categoryName;
  final String itemName;
  final int quantity;
  final String measure;
  final String goodsID;
  final String item_id;

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
    final String item_id = data['item_id'];

    return ItemEntry(
      itemID: itemID,
      companyName: companyName,
      categoryName: categoryName,
      itemName: itemName,
      quantity: quantity,
        measure:measure,
        goodsID:goodsID,
      item_id: item_id,
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
      'item_id':item_id,
    };
  }
}
