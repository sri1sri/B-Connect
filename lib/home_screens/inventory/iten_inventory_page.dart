import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/item_inventry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemInventoryPage extends StatelessWidget {
  ItemInventoryPage({@required this.database});
  Database database;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ItemInventoryPage(database: database),
    );
  }
}

class F_ItemInventoryPage extends StatefulWidget {
  F_ItemInventoryPage({@required this.database});
  Database database;

  @override
  _F_ItemInventoryPageState createState() => _F_ItemInventoryPageState();
}

class _F_ItemInventoryPageState extends State<F_ItemInventoryPage> {
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
    return Scaffold(
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
          rightActionBar: Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Container(
                child: FlatButton(
              onPressed: () {
                print('clearing notification');
              },
              child: Text(""),
              //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )),
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Item Usage',
          tabBarWidget: null,
        ),
      ),
      body: _cartContent(context),
    );
  }

  Widget _cartContent(BuildContext context) {
    return StreamBuilder<List<ItemInventry>>(
      stream: widget.database.viewInventryItems(),
      builder: (context, cartSnapshot) {
        return ListItemsBuilder<ItemInventry>(
          snapshot: cartSnapshot,
          itemBuilder: (context, inventryItemData) => StreamBuilder<ItemEntry>(
            stream: widget.database.viewItem(inventryItemData.itemID),
            builder: (context, snapshot) {
              final itemData = snapshot.data;

              return Container(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      _ItemsCard(
                          itemData != null ? itemData.companyName : '',
                          itemData != null ? itemData.categoryName : '',
                          itemData != null ? itemData.itemName : '',
                          '${itemData != null ? itemData.quantityAvailable : ''} ${itemData != null ? itemData.measure : ''}',
                          getDateTime(inventryItemData != null ? inventryItemData.addedDate.seconds : ''),
                          inventryItemData != null ? inventryItemData.itemDescription : ''),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _ItemsCard(String CompanyName, String Category, String ItemName,
      String Quantity, String TimeDate, String Description) {
    return Column(children: <Widget>[
      Stack(children: [
        Container(
          height: 270.0,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
            left: 50.0,
            right: 50.0,
            top: 5.0,
            bottom: 70.0,
            child: Container(
              padding:
                  EdgeInsets.only(left: 0.0, right: 0.0, top: 3.0, bottom: 0.0),
              height: 120.0,
              width: 200.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white.withOpacity(0.8)),
              child: Column(
                children: <Widget>[Text(TimeDate)],
              ),
            )),
        Positioned(
            left: 5.0,
            right: 5.0,
            top: 30.0,
            bottom: 15.0,
            child: Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
                height: 145.0,
                width: 180.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
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
                              height: 8,
                            ),
                            Text(
                              CompanyName,
                              style: descriptionStyleDark,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Item names",
                              style: descriptionStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              ItemName,
                              style: descriptionStyleDark,
                            ),
                          ]),
                          Column(children: <Widget>[
                            Text(
                              "Category",
                              style: descriptionStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              Category,
                              style: descriptionStyleDark,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Quantity",
                              style: descriptionStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              Quantity,
                              style: descriptionStyleDark,
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
//                          Divider(
//                          color: Colors.black.withOpacity(0.5),
//                          ),
//                          SizedBox(height: 2,),
//                          Column(
//                            children: <Widget>[
//                              Text("Price",style: descriptionStyle,),
//                              SizedBox(height: 5,),
//                              Text(Price,style: highlightDescription,),
//                            ],
//                          ),
//                          SizedBox(height: 2,),
                      Divider(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Description",
                            style: descriptionStyle,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            Description,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ]))),
      ]),
    ]);
  }
}
