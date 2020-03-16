import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/item_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodsDetailsPage extends StatelessWidget {
  GoodsDetailsPage(
      {@required this.database,
      @required this.goodsID,
      @required this.employee});
  Database database;
  String goodsID;
  EmployeeDetails employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GoodsDetailsPage(
          database: database, goodsID: goodsID, employee: employee),
    );
  }
}

class F_GoodsDetailsPage extends StatefulWidget {
  F_GoodsDetailsPage(
      {@required this.database,
      @required this.goodsID,
      @required this.employee});
  Database database;
  String goodsID;
  EmployeeDetails employee;

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
              rightActionBar: Container(
                  //child: Icon(Icons.notifications, size: 40,),
                  ),
              rightAction: () {
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Goods Details',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _statusApprovalButton() {
    return StreamBuilder<GoodsEntry>(
      stream: widget.database.readGoodsDetails(widget.goodsID),
      builder: (context, snapshot) {
        final goods = snapshot.data;
        return _approvalButtonVisibility((goods == null ? 0 : goods.approvalLevel), (goods == null ? false : goods.itemsAdded));
      },
    );
  }

  Widget _approvalButtonVisibility(int approvalLevel, bool itemsAdded) {
    switch (approvalLevel) {
      case 0:
        if (widget.employee.role == 'Supervisor') {
          return _approvalButtonWidget('Accpet security request', () {
            final _itemEntry = GoodsEntry(
              supervisorApprovalTimestamp: Timestamp.fromDate(DateTime.now()),
              supervisorID: widget.employee.employeeID,
              approvalLevel: 1,
            );
            widget.database.updateGoodsEntry(_itemEntry, widget.goodsID);
          });
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        break;
      case 1:
        if (widget.employee.role == 'Manager' && itemsAdded) {
          return _approvalButtonWidget('Accpet supervisor request', () {
            final _itemEntry = GoodsEntry(
              managerApprovalTimestamp: Timestamp.fromDate(DateTime.now()),
              managerID: widget.employee.employeeID,
              approvalLevel: 2,
            );
            widget.database.updateGoodsEntry(_itemEntry, widget.goodsID);
          });
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        break;
      case 2:
        if (widget.employee.role == 'Store Manager') {
          return _approvalButtonWidget('update received status.', () {
            final _itemEntry = GoodsEntry(
              storeMangerItemReceivedTimestamp:
                  Timestamp.fromDate(DateTime.now()),
              storeManagerID: widget.employee.employeeID,
              approvalLevel: 3,
            );
            widget.database.updateGoodsEntry(_itemEntry, widget.goodsID);
          });
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        break;
      case 3:
        if (widget.employee.role == 'Accountant') {
          return _approvalButtonWidget('update received status.', () {
            final _itemEntry = GoodsEntry(
              accountantTransactionStatusTimestamp:
                  Timestamp.fromDate(DateTime.now()),
              accountantID: widget.employee.employeeID,
              approvalLevel: 4,
            );
            widget.database.updateGoodsEntry(_itemEntry, widget.goodsID);
          });
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        break;
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

  Widget _buildContent(BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            Column(children: <Widget>[
              _goodsDetails(context),
              _statusApprovalButton(),
            ]),
          ]),
        ),
      );
  }

  Widget _goodsDetails(BuildContext context) {
    return StreamBuilder<GoodsEntry>(
      stream: widget.database.readGoodsDetails(widget.goodsID),
      builder: (context, snapshot) {
        final goods = snapshot.data;
        print( 'HELLO:'+widget.goodsID+" Good :"+goods.toString() );

        return Container(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
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

  Widget _ItemEntry(GoodsEntry data) {
    return InkWell(
      child: Container(
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
                        "MRR No. -" + (data == null ? "" : data.MRRNumber.toString()),
                    //'MRR No. - ${data.MRRNumber.toString()}',
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
                        PhotoHero(
                          photo: (data == null ? "" : data.vehicelImagePath),
                          width: 100.0,
                          height: 100.0,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      backgroundColor: Colors.black,
                                    ),
                                    body: Container(
                                      // The blue background emphasizes that it's a new route.
                                      color: Colors.black,
                                      padding: const EdgeInsets.only(top:200.0,bottom: 200,left:10,right: 10),
                                      alignment: Alignment.topLeft,
                                      child: PhotoHero(
                                        photo: (data == null ? "" : data.vehicelImagePath),
                                        width: double.infinity,
                                        height: double.infinity,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  );
                                }
                            ));
                          },
                        ),
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
                        PhotoHero(
                          photo: (data == null ? "" : data.mrrImagePath),
                          width: 100.0,
                          height: 100.0,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      backgroundColor: Colors.black,
                                    ),
                                    body: Container(
                                      // The blue background emphasizes that it's a new route.
                                      color: Colors.black,
                                      padding: const EdgeInsets.only(top:200.0,bottom: 200,left:10,right: 10),
                                      alignment: Alignment.topLeft,
                                      child: PhotoHero(
                                        photo: (data == null ? "" : data.mrrImagePath),
                                        width: double.infinity,
                                        height: double.infinity,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  );
                                }
                            ));
                          },
                        ),
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
                  Text(
                    "Tap for Item Details",
                    style: descriptionStyleDarkBlur,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        GoToPage(
            context,
            ItemDetailsPage(
              database: widget.database,
              goodsID: data.goodsEntryID,
              employee: widget.employee,
            ));
      },
    );
  }

  Widget _trackGoodsStatus(GoodsEntry data) {
    switch ((data == null ? 0 : data.approvalLevel)) {
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

    return Row(
      children: <Widget>[
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundColor: levelOne,
              radius: 6,
            ),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 60,
              width: 3,
              child: Container(
                color: levelTwo,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            CircleAvatar(
              backgroundColor: levelTwo,
              radius: 6,
            ),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 60,
              width: 3,
              child: Container(
                color: levelThree,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            CircleAvatar(
              backgroundColor: levelThree,
              radius: 6,
            ),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 60,
              width: 3,
              child: Container(
                color: levelFour,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            CircleAvatar(
              backgroundColor: levelFour,
              radius: 6,
            ),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 60,
              width: 3,
              child: Container(
                color: levelFive,
              ),
            ),
            SizedBox(
              height: 2,
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
          children: [
            Text(
              "Security Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
            (data == null ? 946665000 : data.securityRequestedTimestamp.seconds) == 946665000
                  ? 'Time not updated.'
                  : getDateTime((data == null ? 946665000 : data.securityRequestedTimestamp.seconds)),
              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Supervisor Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
          (data == null ? 946665000 : data.supervisorApprovalTimestamp.seconds) == 946665000
                  ? 'Time not updated.'
                  :
              getDateTime((data == null ? 946665000 : data.supervisorApprovalTimestamp.seconds)),
              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Manager Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
            (data == null ? 946665000 : data.managerApprovalTimestamp.seconds) == 946665000
                  ? 'Time not updated.'
                  : getDateTime((data == null ? 946665000 : data.managerApprovalTimestamp.seconds)),

              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Store Manager Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (data == null ? 946665000 : data.storeMangerItemReceivedTimestamp.seconds) == 946665000
                  ? 'Time not updated.'
                  : getDateTime((data == null ? 946665000 : data.storeMangerItemReceivedTimestamp.seconds)),
              style: descriptionStyleDark,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Accountant Approved Time",
              style: descriptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
        (data == null ? 946665000 : data.accountantTransactionStatusTimestamp.seconds) == 946665000
                  ? 'Time not updated.'
                  :
            getDateTime((data == null ? 946665000 : data.accountantTransactionStatusTimestamp.seconds)),

              style: descriptionStyleDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _ItemCard(ItemEntry data) {
    print(
        'comp = ${data.categoryName},${data.categoryName},${data.measure}, ${data.quantityAvailable}');
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
                    data.quantityAvailable.toString(),
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
                    data.quantityAvailable.toString(),
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

_OrderedItemsCard(
    String companyName, String itemName, String category, String quantity) {
  print(
      'details == ${companyName}, ${itemName}, ${category}, ${quantity.toString()}');
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

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width, this.height }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  final double height;

  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0),
          bottomLeft: const Radius.circular(10.0),
          bottomRight: const Radius.circular(10.0),),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Hero(
          tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0),),
                      image: DecorationImage(
                          image: NetworkImage(photo),
                          fit: BoxFit.cover))
              ),
            ),
          ),
        ),
      ),
    );

  }
}