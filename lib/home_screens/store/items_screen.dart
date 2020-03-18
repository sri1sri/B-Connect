import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/cart_model.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/item_inventry_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/store/no_access_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_description.dart';
import 'categories_tab.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage(
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
      child: F_ItemsPage(
        database: database,
        employee: employee,
      ),
    );
  }
}

class F_ItemsPage extends StatefulWidget {
  F_ItemsPage({@required this.database, @required this.employee});
  Database database;
  EmployeeDetails employee;

  @override
  _F_ItemsPageState createState() => _F_ItemsPageState();
}

class _F_ItemsPageState extends State<F_ItemsPage> {

  String cartBtnTitle;

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: Container(
            color: Colors.white,
              child: _buildContent(context)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<ItemEntry>>(
      stream: widget.database.viewItemsList(null),
      builder: (context, snapshot) {
        return ListItemsBuilder<ItemEntry>(
          snapshot: snapshot,
          itemBuilder: (context, itemData) =>
              StreamBuilder<List<Cart>>(
            stream: widget.database.addCartItemStatus(itemData.itemID),
            builder: (context, snapshot) {
                   return Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _ItemCard(itemData, (snapshot.data == null ? 0 : snapshot.data.length)
                               // snapshot.data.length
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
            },
          ),
        );
      },
    );
  }

  Widget _ItemCard(ItemEntry data, int length) {
    return StreamBuilder<Cart>(
        stream: widget.database.readCartDetails(data.itemID),
        builder: (context, snapshot) {
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
                          data.companyName,
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
                          ('${data.quantityAvailable} ${data.measure}'),
                          style: descriptionStyleDark,
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  widget.employee.role != 'Site Engineer'
                      ? Container()
                      : data.quantityAvailable == 0 ? Container(child: Text('No stock',style: subTitleStyle,),) : Container(
                          child: AnimatedButton(
                            onTap: () {
                              final _cartEntry = Cart(
                                  itemID: data.itemID,
                                  employeeID: EMPLOYEE_ID,
                                  purchaseStatus: false,
                                  addedDate: Timestamp.fromDate(DateTime.now()),
                              quantity: 1,
                              itemDescription: 'Not updated by site engineer.');
                              String cartID = DateTime.now().toString();

                              length == 0 ? widget.database.setcartItems(_cartEntry, cartID) : null;
                              length == 0 ? GoToPage(context, AddDescription(database: widget.database,cartID: cartID)) : null;


                              final _inventryEntry = ItemInventry(
                                  itemID: data.itemID,
                                  employeeID: EMPLOYEE_ID,
                                  addedDate: Timestamp.fromDate(DateTime.now()),
                                  quantity: 1,
                                  itemDescription: 'Not updated by site engineer.',
                              isOrdered: false);
                              length == 0 ? widget.database.setInventryItems(_inventryEntry, cartID) : null;


                              },
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            initialText: length == 0 ? 'Add to cart' : "Added to Cart",
                            finalText: length == 0 ? 'Added to Cart' : "Already added to Cart",
                            iconData: Icons.check,
                            iconSize: 28.0,
                            buttonStyle: ButtonStyle(
                              primaryColor: activeButtonBackgroundColor,
                              secondaryColor: Colors.white,
                              elevation: 10.0,
                              initialTextStyle: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                              finalTextStyle: TextStyle(
                                fontSize: 18.0,
                                color: backgroundColor,
                              ),
                              borderRadius: 10.0,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
