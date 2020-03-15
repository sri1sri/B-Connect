import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class ItemEntry {
  ItemEntry({
    @required this.itemID,
    @required this.companyName,
    @required this.categoryName,
    @required this.totalQuantity,
    @required this.itemName,
    @required this.measure,
    @required this.goodsID,
    @required this.item_id,
    @required this.quantityAvailable,
    @required this.empty,


  });

  final String itemID;
  final String companyName;
  final String categoryName;
  final String itemName;
  final int totalQuantity;
  final int quantityAvailable;
  final String measure;
  final String goodsID;
  final String item_id;
  final Null empty;

  factory ItemEntry.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String itemID = documentId;

    final String companyName = data['company_name'];
    final String categoryName = data['category_name'];
    final String itemName = data['item_name'];
    final int totalQuantity = data['total_quantity'];
    final String measure = data['measure'];
    final String goodsID = data['goods_id'];
    final String item_id = data['item_id'];
    final int quantityAvailable = data['quantity_available'];
    final Null empty = data['empty'];

    return ItemEntry(
      itemID: itemID,
      companyName: companyName,
      categoryName: categoryName,
      itemName: itemName,
      totalQuantity: totalQuantity,
        measure:measure,
        goodsID:goodsID,
      item_id: item_id,
      quantityAvailable: quantityAvailable,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap() {
    return {

      companyName != null ? 'company_name': 'empty': companyName,
      categoryName != null ? 'category_name': 'empty': categoryName,
      itemName != null ? 'item_name': 'empty': itemName,
      totalQuantity != null ? 'total_quantity': 'empty': totalQuantity,
      measure != null ? 'measure': 'empty': measure,
      goodsID != null ? 'goods_id': 'empty': goodsID,
      item_id != null ? 'item_id': 'empty': item_id,
      quantityAvailable != null ? 'quantity_available': 'empty': quantityAvailable,
    };
  }
}
