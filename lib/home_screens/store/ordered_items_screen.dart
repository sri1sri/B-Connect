import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/database_model/order_details_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderedItemsPage extends StatelessWidget {
  OrderedItemsPage(
      {@required this.database,
      @required this.itemsID,
      @required this.orderID,
        @required this.employee,
      @required this.itemsQuantity});
  Database database;
  var itemsID;
  var itemsQuantity;

  String orderID;
  EmployeeDetails employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_OrderedItemsPage(
        database: database,
        itemsID: itemsID,
        orderID: orderID,
        employee: employee,
          itemsQuantity: itemsQuantity,
      ),
    );
  }
}

class F_OrderedItemsPage extends StatefulWidget {
  F_OrderedItemsPage(
      {@required this.database,
      @required this.itemsID,
      @required this.orderID,
      @required this.employee,
      @required this.itemsQuantity});
  Database database;
  var itemsID;
  var itemsQuantity;
  String orderID;
  EmployeeDetails employee;

  @override
  _F_OrderedItemsPageState createState() => _F_OrderedItemsPageState();
}

class _F_OrderedItemsPageState extends State<F_OrderedItemsPage> {
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
            //preferredSize : Size(double.infinity, 100),
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
              rightActionBar: Container(
                  //child: Icon(Icons.notifications, size: 40,),
                  ),
              rightAction: () {
                print('right action bar is pressed in appbar');
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

                  Text(
                    widget.itemsQuantity[0].toString(),
                    style: descriptionStyleDark,
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _OrderStatus(),
          ],
        ),
      ),
    );
  }

  Widget _iteQuantity(){
    for(var i = 0; i<2; i++){
      return Text(
        widget.itemsQuantity[i].toString(),
        style: descriptionStyleDark,
      );//gvjvjv
    }
  }

  Widget _statusTracker(OrderDetails orderDetails, Color levelOne,
      Color levelTwo, Color levelThree, Color levelFour) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 50,
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: levelOne,
              radius: 6,
            ),
            SizedBox(height: 2),
            SizedBox(
              height: 60,
              width: 3,
              child: Container(
                color: levelTwo,
              ),
            ),
            SizedBox(height: 2),
            CircleAvatar(
              backgroundColor: levelTwo,
              radius: 6,
            ),
            SizedBox(height: 2),
            SizedBox(
              height: 60,
              width: 3,
              child: Container(
                color: levelThree,
              ),
            ),
            SizedBox(height: 2),
            CircleAvatar(
              backgroundColor: levelThree,
              radius: 6,
            ),
            SizedBox(height: 2),
            SizedBox(
              height: 60,
              width: 3,
              child: Container(
                color: levelFour,
              ),
            ),
            SizedBox(height: 2),
            CircleAvatar(
              backgroundColor: levelFour,
              radius: 6,
            ),
            SizedBox(height: 20),
          ],
        ),
        SizedBox(width: 50),
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 15),
            Text(
              "Site Manager requested Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              orderDetails.siteManagerOrderedTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(
                      orderDetails.siteManagerOrderedTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 20),
            Text(
              "Manager Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              orderDetails.managerApprovalTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(orderDetails.managerApprovalTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 20),
            Text(
              "Store Manager Delivered Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              orderDetails.storeMangerDeliveredTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(
                      orderDetails.storeMangerDeliveredTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 20),
            Text(
              "Site Manager Received Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              orderDetails.siteManagerReceivedTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(
                      orderDetails.siteManagerReceivedTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget _trackOrderStatus(OrderDetails orderDetails) {
    switch (orderDetails.status) {
      case 0:
        return _statusTracker(orderDetails, Colors.green, Colors.orangeAccent,
            Colors.grey, Colors.grey);
        break;

      case 1:
        return _statusTracker(orderDetails, Colors.green, Colors.green,
            Colors.orangeAccent, Colors.grey);
        break;

      case 2:
        return _statusTracker(orderDetails, Colors.green, Colors.green,
            Colors.green, Colors.orangeAccent);
        break;

      case 3:
        return _statusTracker(orderDetails, Colors.green, Colors.green,
            Colors.green, Colors.green);
        break;
    }
  }

  Widget _OrderStatus() {
    return StreamBuilder<OrderDetails>(
      stream: widget.database.readSingleOrder(widget.orderID),
      builder: (context, snapshot) {
        final orderDetails = snapshot.data;
        return SingleChildScrollView(
          child: Container(
            child: Column(children: <Widget>[
              Column(children: <Widget>[
                _trackOrderStatus(orderDetails),
                _approvalButtonVisibility(orderDetails.status),
              ]),
            ]),
          ),
        );
      },
    );
  }

  Widget _approvalButtonVisibility(int approvalLevel) {
    switch (approvalLevel) {
      case 0:
        if (widget.employee.role == 'Manager') {
          return _approvalButtonWidget('Accpet Site Manager request', () {
            final _orderDetails = OrderDetails(
              managerApprovalTimestamp: Timestamp.fromDate(DateTime.now()),
              managerID: widget.employee.employeeID,
              status: 1,
            );
            widget.database.updateOrderDetails(_orderDetails, widget.orderID);
          });
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        break;
      case 1:
        if (widget.employee.role == 'Store Manager') {
          return _approvalButtonWidget('Items Delivered', () {
            final _orderDetails = OrderDetails(
              storeMangerDeliveredTimestamp: Timestamp.fromDate(DateTime.now()),
              storeManagerID: widget.employee.employeeID,
              status: 2,
            );
            widget.database.updateOrderDetails(_orderDetails, widget.orderID);
          });
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        break;
      case 2:
        if (widget.employee.role == 'Site Manager') {
          return _approvalButtonWidget('Items Received', () {
            final _orderDetails = OrderDetails(
              siteManagerReceivedTimestamp: Timestamp.fromDate(DateTime.now()),
              siteManagerID: widget.employee.employeeID,
              status: 3,
            );
            widget.database.updateOrderDetails(_orderDetails, widget.orderID);
          });
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        break;
      case 3:
        return Container(
          height: 0.0,
          width: 0.0,
        );
    }
  }

  Widget _approvalButtonWidget(String title, VoidCallback onTap) {
    return Container(
      child: AnimatedButton(
        onTap: () {
          onTap();
        },
        animationDuration: const Duration(milliseconds: 1000),
        initialText: title,
        finalText: "Request Accepted",
        iconData: Icons.check,
        iconSize: 32.0,
        buttonStyle: ButtonStyle(
          primaryColor: activeButtonBackgroundColor,
          secondaryColor: Colors.white,
          elevation: 10.0,
          initialTextStyle: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
          finalTextStyle: TextStyle(
            fontSize: 22.0,
            color: backgroundColor,
          ),
          borderRadius: 10.0,
        ),
      ),
    );
  }
}
//jgfcjfcjfgcgf