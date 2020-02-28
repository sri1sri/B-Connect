import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/cart.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/home_screens/order_details.dart';
import 'package:flutter/material.dart';

//Our Category Data Object
class Category {
  const Category({this.name});
  final String name;
}

// List of Category Data objects.
const List<Category> categories = <Category>[
  Category(
    name: 'Items',
  ),
  Category(name: 'Orders'),
];
