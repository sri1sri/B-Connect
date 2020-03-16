import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/order_details_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/store/ordered_items_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'categories_tab.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage(
      {Key key,
      this.choice,
      @required this.database,
      @required this.employee})
      : super(key: key);
  final Category choice;
  final Database database;
  final EmployeeDetails employee;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_OrdersPage(
        database: database,
        employee: employee,
      ),
    );
  }
}

class F_OrdersPage extends StatefulWidget {
  F_OrdersPage({@required this.database, @required this.employee});
  Database database;
  EmployeeDetails employee;

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
    return _OrderCard();
  }

  String queryKey(){
    print(widget.employee.role);
    switch(widget.employee.role){
      case 'Site Engineer':
        return 'site_manager_id';
    break;
      case 'Store Manager':
        return 'store_manager_id';
        break;
      case 'Supervisor':
        return 'supervisor_id';
        break;
      case 'Manager':
        return 'manager_id';
        break;
    }
  }

  Widget _OrderCard() {
    return StreamBuilder<List<OrderDetails>>(
      stream: widget.database.readOrders(queryKey()),
      builder: (context, orderSnapshots) {
        return ListItemsBuilder<OrderDetails>(
          snapshot: orderSnapshots,
          itemBuilder: (context, orderData) =>  InkWell(
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
                    SizedBox(height: 10),
                    Text(
                      "Order Status",
                      style: descriptionStyle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "#${orderData.orderID}",
                      style: descriptionStyleDark,
                    ),


                    SizedBox(height: 10),

                    Text(
                      getDateTime(orderData.siteManagerOrderedTimestamp.seconds),
                      style: descriptionStyle,
                    ),
                    SizedBox(height: 10),

                    _trackGoodsStatus(orderData.status),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 0,),
                          Text("Ordered",style: statusTracker,),
                          SizedBox(width: 30,),
                          Text("Approved",style: statusTracker,),
                          SizedBox(width: 30,),
                          Text("Delivered",style: statusTracker,),
                          SizedBox(width: 30,),

                          Text("Received",style: statusTracker,),

                        ],
                      ),
                    ),


                    SizedBox(height: 20),
                    Text(
                      "Tap for Order Details",
                      style: descriptionStyleDarkBlur,
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            onTap: () {
              print('itemQuantity == ${orderData.itemQuantity}');
              GoToPage(context, OrderedItemsPage(database: widget.database, itemsID: orderData.itemID, orderID: orderData.orderID, employee: widget.employee));
            },
          ),
        );
      },
    );
  }

  Widget _trackGoodsStatus(int approvalLevel){
    switch (approvalLevel) {
      case 0:
        return statusTrackerWidget( Colors.green, Colors.orangeAccent,
            Colors.grey, Colors.grey);
        break;

      case 1:
        return statusTrackerWidget( Colors.green, Colors.green,
            Colors.orangeAccent, Colors.grey);
        break;

      case 2:
        return statusTrackerWidget( Colors.green, Colors.green,
            Colors.green, Colors.orangeAccent);
        break;

      case 3:
        return statusTrackerWidget( Colors.green, Colors.green,
            Colors.green, Colors.green);
        break;

    }
  }


  Widget statusTrackerWidget(Color levelOne, Color levelTwo, Color levelThree, Color levelFour){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 15,),
          CircleAvatar(backgroundColor: levelOne,radius: 6,),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: new LinearPercentIndicator(
              width: 80,
              animation: true,
              lineHeight: 4.0,
              animationDuration: 3000,
              percent: 1,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: levelTwo,
            ),
          ),
          CircleAvatar(backgroundColor: levelTwo,radius: 6,),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: new LinearPercentIndicator(
              width: 80,
              animation: true,
              lineHeight: 4.0,
              animationDuration: 3000,
              percent: 1,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: levelThree,
            ),
          ),
          CircleAvatar(backgroundColor: levelThree,radius: 6,),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: new LinearPercentIndicator(
              width: 80,
              animation: true,
              lineHeight: 4.0,
              animationDuration: 3000,
              percent: 1,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: levelFour,
            ),
          ),
          CircleAvatar(backgroundColor: levelFour,radius: 6,),
          SizedBox(width: 15,),
        ],
      ),
    );
  }

}
