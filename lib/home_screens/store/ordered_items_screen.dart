import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/database_model/order_details_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/store/ordered_items_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderedItemsPage extends StatelessWidget {
  OrderedItemsPage(
      {@required this.database,
      @required this.itemsID,
      @required this.orderID,
      @required this.employee,
      });
  Database database;
  var itemsID;
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
      ),
    );
  }
}

class F_OrderedItemsPage extends StatefulWidget {
  F_OrderedItemsPage(
      {@required this.database,
      @required this.itemsID,
      @required this.orderID,
      @required this.employee,});
  Database database;
  var itemsID;
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
              secondaryText: 'Order Status',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<OrderDetails>(
      stream: widget.database.readSingleOrder(widget.orderID),
      builder: (context, snapshot) {
        final orderDetails = snapshot.data;

        return SingleChildScrollView(
          child: Container(
            child: Column(children: <Widget>[
              Column(children: <Widget>[
                _trackOrderStatus(orderDetails),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ToDoButton(
                    assetName: '',
                    text: 'Tap here to view items',
                    textColor: Colors.white,
                    backgroundColor: activeButtonBackgroundColor,
                    onPressed: (){
                      GoToPage(
                          context,
                          OrderedItemsDetailsPage(
                            database: widget.database,
                            itemsID: widget.itemsID,
                            orderID: widget.orderID,
                            employee: widget.employee,
                            itemsQuantity: orderDetails.itemQuantity,));
                    },
                  ),
                ),
                _approvalButtonVisibility(
                    orderDetails == null ? 0 : orderDetails.status),
              ]),
            ]),
          ),
        );
      },
    );
  }

  Widget _statusTracker(OrderDetails orderDetails, Color levelOne,
      Color levelTwo, Color levelThree, Color levelFour) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            SizedBox(height: 10),
            CircleAvatar(
              backgroundColor: levelOne,
              radius: 6,
            ),
            SizedBox(height: 2),
            SizedBox(
              height: 65,
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
              height: 65,
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
              height: 65,
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
          children: [
            SizedBox(height: 15),
            Text(
              "Site Engineer requested Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              (orderDetails == null
                          ? 946665000
                          : orderDetails.siteManagerOrderedTimestamp.seconds) ==
                      946665000
                  ? 'Time not updated.'
                  : getDateTime((orderDetails == null
                      ? 946665000
                      : orderDetails.siteManagerOrderedTimestamp.seconds)),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 30),
            Text(
              "Manager Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              (orderDetails == null
                          ? 946665000
                          : orderDetails.managerApprovalTimestamp.seconds) ==
                      946665000
                  ? 'Time not updated.'
                  : getDateTime((orderDetails == null
                      ? 946665000
                      : orderDetails.managerApprovalTimestamp.seconds)),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 30),
            Text(
              "Store Manager Delivered Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              (orderDetails == null
                          ? 946665000
                          : orderDetails
                              .storeMangerDeliveredTimestamp.seconds) ==
                      946665000
                  ? 'Time not updated.'
                  : getDateTime((orderDetails == null
                      ? 946665000
                      : orderDetails.storeMangerDeliveredTimestamp.seconds)),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 30),
            Text(
              "Site Engineer Received Time",
              style: descriptionStyle,
            ),
            SizedBox(height: 10),
            Text(
              (orderDetails == null
                          ? 946665000
                          : orderDetails
                              .siteManagerReceivedTimestamp.seconds) ==
                      946665000
                  ? 'Time not updated.'
                  : getDateTime((orderDetails == null
                      ? 946665000
                      : orderDetails.siteManagerReceivedTimestamp.seconds)),
              style: descriptionStyleDark,
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget _trackOrderStatus(OrderDetails orderDetails) {
    switch ((orderDetails == null ? 0 : orderDetails.status)) {
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

  Widget _approvalButtonVisibility(int approvalLevel) {
    switch (approvalLevel) {
      case 0:
        if (widget.employee.role == 'Manager') {
          return _approvalButtonWidget('Accpet Site Engineer request', () {
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
        if (widget.employee.role == 'Site Engineer') {
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