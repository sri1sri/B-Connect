import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_goods_items_builder.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/camera_screens/Camera_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_goods_entry_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_items_entry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoodsDetailsPage extends StatelessWidget {
  GoodsDetailsPage(
      {@required this.database,
      @required this.goodsID,
      @required this.employee,
        @required this.appovalStatusLevel});
  Database database;
  String goodsID;
  EmployeeDetails employee;
  int appovalStatusLevel;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GoodsDetailsPage(
        database: database,
        goodsID: goodsID,
        employee: employee,
        appovalStatusLevel: appovalStatusLevel,
      ),
    );
  }
}

class F_GoodsDetailsPage extends StatefulWidget {
  F_GoodsDetailsPage(
      {@required this.database,
      @required this.goodsID,
      @required this.employee,
      @required this.appovalStatusLevel});
  Database database;
  String goodsID;
  EmployeeDetails employee;
  int appovalStatusLevel;

  @override
  _F_GoodsDetailsPageState createState() => _F_GoodsDetailsPageState();
}

class _F_GoodsDetailsPageState extends State<F_GoodsDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(
                child: Text(
              'Goods Details',
              style: subTitleStyleLight,
            )),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            actions: <Widget>[
              _addItem(),
            ],
            centerTitle: true,
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _addItem() {
    if (widget.employee.role == 'Supervisor') {
      return IconButton(
        icon: Icon(
          Icons.add_circle,
          color: Colors.white,
        ),
        onPressed: () {
          GoToPage(
            context,
            ItemsEntryPage(
              database: widget.database,
              goodsID: widget.goodsID,
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget _statusApprovalButton() {
    switch (widget.appovalStatusLevel){
      case 0:
        if(widget.employee.role == 'Supervisor'){
          return _approvalButton('Accpet security request');
        }else{
          return Container();
        }
        break;
      case 1:
        if(widget.employee.role == 'Manager'){
          return _approvalButton('Accpet supervisor request');
        }else{
          return Container();
        }
        break;
      case 2:
        if(widget.employee.role == 'Store Manager'){
          return _approvalButton('update received status.');
        }else{
          return Container();
        }
        break;
      case 3:
        if(widget.employee.role == 'Accountant'){
          return _approvalButton('update received status.');
        }else{
          return Container();
        }
        break;

    }
  }


  Widget _approvalButton(String title) {
    return Container(
      child: AnimatedButton(
        onTap: () {
          print("Supervisor Approval Status");
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

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        _goodsDetails(context),
        SizedBox(
          height: 20,
        ),
        _statusApprovalButton(),
        SizedBox(
          height: 50,
        ),
        //_goodsItemsDetails(context),
      ]),
    );
  }

  Widget _goodsDetails(BuildContext context) {
    return StreamBuilder<GoodsEntry>(
      stream: widget.database.readGoodsDetails(widget.goodsID),
      builder: (context, snapshot) {
        final goods = snapshot.data;

        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _ItemEntry(goods),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _goodsItemsDetails(BuildContext context) {
    return StreamBuilder<List<ItemEntry>>(
      stream: widget.database.viewItemsList(widget.goodsID),
      builder: (context, snapshot) {
        return ListGoodsItemsBuilder<ItemEntry>(
          snapshot: snapshot,
          itemBuilder: (context, itemsData) => _ItemCard(itemsData),
        );
      },
    );
  }

  _ItemEntry(GoodsEntry data) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  'MRR No. - ${data.MRRNumber.toString()}',
                  style: subTitleStyle,
                )),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: <Widget>[
                      Text(
                        "Vehicle Photo",
                        style: descriptionStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(data.vehicelImagePath),
                                  fit: BoxFit.cover))),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                    Column(children: <Widget>[
                      Text(
                        "MRR Photo",
                        style: descriptionStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(data.mrrImagePath),
                                  fit: BoxFit.cover))),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ],
                ),
                _trackGoodsStatus(data),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trackGoodsStatus(GoodsEntry data) {
    switch (data.approvalLevel) {
      case 0:
        return _statusTracker(data, Colors.orangeAccent, Colors.grey,
            Colors.grey, Colors.grey, Colors.grey);
        break;

      case 1:
        return _statusTracker(data, Colors.green, Colors.orangeAccent,
            Colors.grey, Colors.grey, Colors.grey);
        break;

      case 2:
        return _statusTracker(data, Colors.green, Colors.green, Colors.green,
            Colors.orangeAccent, Colors.grey);
        break;

      case 3:
        return _statusTracker(data, Colors.green, Colors.green, Colors.green,
            Colors.green, Colors.orangeAccent);
        break;

      case 4:
        return _statusTracker(data, Colors.green, Colors.green, Colors.green,
            Colors.green, Colors.green);
        break;
    }
  }

  Widget _statusTracker(GoodsEntry data, Color levelOne, Color levelTwo,
      Color levelThree, Color levelFour, Color levelFive) {
    print('time => ${data.storeMangerItemReceivedTimestamp.seconds}');
    return Row(
      children: <Widget>[
        SizedBox(
          width: 50,
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundColor: levelOne,
              radius: 6,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            CircleAvatar(
              backgroundColor: levelTwo,
              radius: 6,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            CircleAvatar(
              backgroundColor: levelThree,
              radius: 6,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            CircleAvatar(
              backgroundColor: levelFour,
              radius: 6,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            Text(
              " | ",
              style: descriptionStyle,
            ),
            CircleAvatar(
              backgroundColor: levelFive,
              radius: 6,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Security Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data.securityRequestedTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(data.securityRequestedTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Supervisor Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data.supervisorApprovalTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(data.supervisorApprovalTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Manager Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data.managerApprovalTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(data.managerApprovalTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Store Manager Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data.storeMangerItemReceivedTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(data.storeMangerItemReceivedTimestamp.seconds),
              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Accountant Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data.accountantTransactionStatusTimestamp.seconds == 946665000
                  ? 'Time not updated.'
                  : getDateTime(
                      data.accountantTransactionStatusTimestamp.seconds),
              style: descriptionStyleDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _ItemCard(ItemEntry data) {
    print(
        'comp = ${data.categoryName},${data.categoryName},${data.measure}, ${data.quantity}');
    return Container(
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
                    data.quantity.toString(),
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
                    data.itemName,
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
                    data.categoryName,
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
                    data.quantity.toString(),
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
