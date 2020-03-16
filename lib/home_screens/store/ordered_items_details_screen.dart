
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderedItemsDetailsPage extends StatelessWidget {
  OrderedItemsDetailsPage(
      {@required this.database,
        @required this.itemsID,
        @required this.orderID,
        @required this.employee,
        @required this.itemsQuantity,
        });
  Database database;
  var itemsID;
var itemsQuantity;
  String orderID;
  EmployeeDetails employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_OrderedItemsDetailsPage(
        database: database,
        itemsID: itemsID,
        orderID: orderID,
        employee: employee,
      ),
    );
  }
}

class F_OrderedItemsDetailsPage extends StatefulWidget {
  F_OrderedItemsDetailsPage(
      {@required this.database,
        @required this.itemsID,
        @required this.orderID,
        @required this.employee,
        @required this.itemsQuantity,
       });
  Database database;
  var itemsID;
  String orderID;
  EmployeeDetails employee;
  var itemsQuantity;

  @override
  _F_OrderedItemsDetailsPageState createState() => _F_OrderedItemsDetailsPageState();
}

class _F_OrderedItemsDetailsPageState extends State<F_OrderedItemsDetailsPage> {

  var orderData= [];

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.black38,
                ),
              ),
              leftAction: () {
                Navigator.pop(context, true);
              },
              primaryText: null,
              secondaryText: 'Ordered items',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<ItemEntry>>(
      stream: widget.database.viewMultipleItem(widget.itemsID),
      builder: (context, itemSnapshots) {
        return ListItemsBuilder<ItemEntry>(
          snapshot: itemSnapshots,
          itemBuilder: (context, itemData) => Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                            _OrderedItemsCard(itemData),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _OrderedItemsCard(ItemEntry itemData) {
    return StreamBuilder(
      stream: widget.database.readOrderQty(widget.orderID,itemData.itemID),
      builder: (context, snapshot) {
        String qty  = snapshot.data.toString();
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
                        itemData.companyName,
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
                        itemData.itemName,
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
                        itemData.categoryName,
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
                      Text(qty, style: descriptionStyleDark),
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
    );
  }
}