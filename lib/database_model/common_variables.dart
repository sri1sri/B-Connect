import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class CommonVaribles{
  CommonVaribles({

    @required this.employeeRoles,
    @required this.itemNames,
    @required this.categories,
    @required this.companies,
    @required this.empty,
  });

  final employeeRoles;
  final itemNames;
  final categories;
  final companies;

  final Null empty;

  factory CommonVaribles.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }
    final employeeRoles = data['roles'];
    final itemNames = data['item_names'];
    final categories = data['categories'];
    final companies = data['companies'];
    final Null empty = data['empty'];

    return CommonVaribles(
      employeeRoles: employeeRoles,
      itemNames: itemNames,
      categories: categories,
      companies: companies,
      empty: empty,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      employeeRoles != null ? 'roles': 'empty': FieldValue.arrayUnion([employeeRoles]),
      itemNames != null ? 'item_names': 'empty': FieldValue.arrayUnion([itemNames]),
      categories != null ? 'categories': 'empty': FieldValue.arrayUnion([categories]),
      companies != null ? 'companies': 'empty': FieldValue.arrayUnion([companies]),
    };
  }
}