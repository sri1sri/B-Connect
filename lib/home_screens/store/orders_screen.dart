
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'categories_tab.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key key, this.choice, @required this.database}) : super(key: key);
  final Category choice;
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_OrdersPage(database: database,),
    );
  }
}

class F_OrdersPage extends StatefulWidget {
  F_OrdersPage({ @required this.database});
  Database database;

  @override
  _F_OrdersPageState createState() => _F_OrdersPageState();
}

class _F_OrdersPageState extends State<F_OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return new SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _OrderCard("ABC company", "Wires", "Electricals", "100 mts", context,
              OrderDetailsPage()),
          _OrderCard("DEF company", "Sand", "Raw Materials", "1000 kgs",
              context, OrderDetailsPage()),
          _OrderCard("GHI company", "Wood", "Goods", "50 logs", context,
              OrderDetailsPage()),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _OrderCard(String companyName, String itemName, String category,
      String quantity, BuildContext context, Widget page) {
    return InkWell(
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              _OrderedItemsCard("ABC company", "Wires", "Electricals", "100 mts"),
              _OrderedItemsCard(
                  "DEF company", "Sand", "Raw Materials", "1000 kgs"),
              SizedBox(
                height: 10,
              ),
              Text(
                "Order Status",
                style: descriptionStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 6,
                  ),
                  Text(
                    " ------------ ",
                    style: descriptionStyle,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 6,
                  ),
                  Text(
                    " ------------ ",
                    style: descriptionStyle,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 6,
                  ),
                  Text(
                    " ------------ ",
                    style: descriptionStyle,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 6,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Supervisor",
                    style: statusTracker,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Manager",
                    style: statusTracker,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Store Manager",
                    style: statusTracker,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Accountant",
                    style: statusTracker,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Tap for Order Details",
                style: descriptionStyleDarkBlur,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        GoToPage(context, page);
      },
    );
  }


  _OrderedItemsCard(
      String companyName, String itemName, String category, String quantity) {
    return Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: <Widget>[
                  Text(
                    "Company Name",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    companyName,
                    style: descriptionStyleDark,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Item names",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    itemName,
                    style: descriptionStyleDark,
                  ),
                ]),
                Column(children: <Widget>[
                  Text(
                    "Category",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    category,
                    style: descriptionStyleDark,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Quantity",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    quantity,
                    style: descriptionStyleDark,
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

