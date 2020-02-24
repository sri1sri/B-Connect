import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
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
  GoodsDetailsPage({@required this.database, @required this.goodsID});
  Database database;
  String goodsID;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GoodsDetailsPage(
        database: database,
        goodsID: goodsID,
      ),
    );
  }
}

class F_GoodsDetailsPage extends StatefulWidget {
  F_GoodsDetailsPage({@required this.database, @required this.goodsID});
  Database database;
  String goodsID;

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
              IconButton(
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
                  })
            ],
            centerTitle: true,
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return _buildCards(context);
  }

  Widget _buildCards(BuildContext context) {
    return StreamBuilder<GoodsEntry>(
      stream: widget.database.readGoodsDetails(widget.goodsID),
      builder: (context, snapshot) {
        final goods = snapshot.data;

        return StreamBuilder<List<ItemEntry>>(
            stream: widget.database.viewItemsList(widget.goodsID),
            builder: (context, snapshot) {
              print(snapshot.data.length);
              return ListItemsBuilder<ItemEntry>(
                snapshot: snapshot,
                itemBuilder: (context, itemsData) =>

                    SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                _ItemEntry(
                                    goods.vehicelImagePath,
                                    goods.mrrImagePath,
                                    'MRR No. - ${goods.MRRNumber}',
                                    getDateTime(goods.securityEntryTimestamp
                                                .seconds) ==
                                            null
                                        ? 'Security didnt add entry'
                                        : getDateTime(goods
                                            .securityEntryTimestamp.seconds),
                                    getDateTime(
                                        goods.securityEntryTimestamp.seconds),
                                    getDateTime(
                                        goods.securityEntryTimestamp.seconds),
                                    getDateTime(
                                        goods.securityEntryTimestamp.seconds),
                                    getDateTime(
                                        goods.securityEntryTimestamp.seconds),
//                            goods.supervisorApprovalTimestamp.seconds == null ? getDateTime(goods.securityEntryTimestamp.seconds) : getDateTime(goods.supervisorApprovalTimestamp.seconds),
//                            goods.managerApprovalTimestamp.seconds == null ? getDateTime(goods.securityEntryTimestamp.seconds) : getDateTime(goods.managerApprovalTimestamp.seconds),
//                            goods.storeMangerItemReceivedTimestamp.seconds == null ? getDateTime(goods.securityEntryTimestamp.seconds) : getDateTime(goods.storeMangerItemReceivedTimestamp.seconds),
//                            goods.accountantTransactionStatusTimestamp.seconds == null ? getDateTime(goods.securityEntryTimestamp.seconds) : getDateTime(goods.accountantTransactionStatusTimestamp.seconds),
                                    context,
                                    CameraPage()),
                                _ItemCard(itemsData.companyName, itemsData.itemName, itemsData.categoryName,
                                    itemsData.quantity.toString()),
                                //_ApprovalButton(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  _ItemEntry(
      String vehicelImgPath,
      String mmrImagepath,
      String companyName,
      String securityUpdatedTime,
      String supervisorUpdatedTime,
      String managerUpdatedTime,
      String storeManagerUpdatedTime,
      String accountantUpdatedTime,
      BuildContext context,
      Widget page) {
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
                height: 20,
              ),
              Center(
                  child: Text(
                companyName,
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
                                image: NetworkImage(vehicelImgPath),
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
                                image: NetworkImage(mmrImagepath),
                                fit: BoxFit.cover))),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Security Approved Time",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    securityUpdatedTime,
                    style: descriptionStyleDark,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Supervisor Approved Time",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    supervisorUpdatedTime,
                    style: descriptionStyleDark,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Manager Approved Time",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    managerUpdatedTime,
                    style: descriptionStyleDark,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Store Manager Approved Time",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    storeManagerUpdatedTime,
                    style: descriptionStyleDark,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Accountant Approved Time",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    accountantUpdatedTime,
                    style: descriptionStyleDark,
                  ),
                ],
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

  _ItemCard(
      String companyName, String itemName, String category, String quantity) {
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

  _ApprovalButton() {
    return Container(
      width: 400,
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
              Text(
                "Supervisor Approval Status",
                style: descriptionStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: AnimatedButton(
                  onTap: () {
                    print("Supervisor Approval Status");
                  },
                  animationDuration: const Duration(milliseconds: 1000),
                  initialText: "          Accept Request         ",
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
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Manager Approval Status",
                style: descriptionStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: AnimatedButton(
                  onTap: () {
                    print("Manager Approval Status");
                  },
                  animationDuration: const Duration(milliseconds: 1000),
                  initialText: "          Accept Request         ",
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
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Store Manager Approval Status",
                style: descriptionStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: AnimatedButton(
                  onTap: () {
                    print("Store Manager Approval Status");
                  },
                  animationDuration: const Duration(milliseconds: 1000),
                  initialText: "          Accept Request         ",
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
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Accountant Approval Status",
                style: descriptionStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: AnimatedButton(
                  onTap: () {
                    print("Accountant Approval Status");
                  },
                  animationDuration: const Duration(milliseconds: 1000),
                  initialText: "          Accept Request         ",
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
              ),
              SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
//void _goToPage(BuildContext context, Widget page) {
//  Navigator.of(context).push(
//    MaterialPageRoute<void>(
//      fullscreenDialog: true,
//      builder: (context) => page,
//    ),
//  );
//}
