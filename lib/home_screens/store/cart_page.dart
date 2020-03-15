import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/database_model/cart_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/database_model/order_details_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/store/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  CartPage({@required this.database});
  Database database;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_CartPage(
        database: database,
      ),
    );
  }
}

class F_CartPage extends StatefulWidget {
  F_CartPage({@required this.database});
  Database database;

  @override
  _F_CartPageState createState() => _F_CartPageState();
}

class _F_CartPageState extends State<F_CartPage> {
  var itemIDs = [];
  var cartIDs = [];
  var orderedItemQuantity =[];
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
          rightActionBar: Container(
            padding: EdgeInsets.only(top: 10),
            child: InkWell(
                child: Text('Clear',
                  style: subTitleStyle,
                ),
                onTap: () {
                  print('pressed clear in cart');
                }
            ),
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Cart',
          tabBarWidget: null,
        ),
      ),
      body: _cartContent(context),
      bottomNavigationBar: BottomAppBar(
          child: FlatButton.icon(
              color: activeButtonTextColor,
              onPressed: () => {
                _submitOrder(),
              },
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
                color: backgroundColor,
              ),
              label: Text('Place Order', style: titleStyle))),
    );
  }

//  _updateItemQuantity(){
//    itemQuantity.add(cartData.quantity)
//  }

  Widget _cartContent(BuildContext context) {
    return StreamBuilder<List<Cart>>(
      stream: widget.database.viewCartItems(),
      builder: (context, cartSnapshot) {
        return ListItemsBuilder<Cart>(
          snapshot: cartSnapshot,
          itemBuilder: (context, cartData) =>

              StreamBuilder<ItemEntry>(
                stream: widget.database.viewItem(cartData.itemID),
                builder: (context, snapshot) {

                  cartIDs.add(cartData.cartID);
                  cartIDs = cartIDs.toSet().toList();
                  print('cartIDs --> ${cartIDs}');


                  orderedItemQuantity.add(cartData.quantity);


                  final itemData = snapshot.data;
                  itemIDs.add(itemData.itemID);
                  itemIDs = itemIDs.toSet().toList();
                  print('itemsID --> ${itemIDs}');

                      return Container(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        _ItemCard( itemData, cartData, cartSnapshot.data.length),
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

  _ItemCard(ItemEntry itemData, Cart cartData, int cartDataLength) {
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
                    "Quantity available",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${itemData.quantityAvailable} ${itemData.measure}',
                    style: descriptionStyleDark,
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FloatingActionButton(
                      onPressed: (){
                        //add();
                        if(cartData.quantity >= 1){
                          final _cartEntry = Cart(
                              quantity: cartData.quantity + 1);
                          widget.database.updateCartDetails(
                              _cartEntry, cartData.cartID);
                          //itemQuantity.insert(, (cartData.quantity + 1));

                        }
                      },
                      child: new Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      backgroundColor: backgroundColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    new Text(cartData.quantity.toString(), style: new TextStyle(fontSize: 30.0)),
                    SizedBox(
                      width: 15,
                    ),
                    new FloatingActionButton(
                      onPressed: (){
                       // minus();
                       if(cartData.quantity > 1){
                         final _cartEntry = Cart(
                             quantity: cartData.quantity - 1);
                         widget.database.updateCartDetails(
                             _cartEntry, cartData.cartID);
                        // itemQuantity.insert(i, (cartData.quantity - 1));

                       }

                      },
                      child: new Icon(
                        const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                        color: backgroundColor,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                ToDoButton(
                  assetName: 'images/google-lodgo.png',
                  text: 'Remove Item',
                  textColor: activeButtonTextColor,
                  backgroundColor: removeButtonBackgroundColor,
                  onPressed: () => {
                    widget.database.deleteCartItem(cartData.cartID),
                  itemIDs.clear(),
                  },
                ),
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

  Future<void> _submitOrder() async {
    itemIDs = itemIDs.toSet().toList();
    cartIDs = cartIDs.toSet().toList();

print('itemsID --> ${itemIDs}');
    print('cartIDs --> ${cartIDs}');

    final _submitOrder = OrderDetails(
      itemID: itemIDs.sublist((itemIDs.length - cartIDs.length), itemIDs.length),
      siteManagerID: EMPLOYEE_ID,
      supervisorID: 'Not assigned',
      managerID: 'Not assigned',
      storeManagerID: 'Not assigned',
      siteManagerOrderedTimestamp: Timestamp.fromDate(DateTime.now()),
      storeMangerDeliveredTimestamp: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
      managerApprovalTimestamp: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
      siteManagerReceivedTimestamp: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
      status: 0,
      itemQuantity: orderedItemQuantity.sublist((orderedItemQuantity.length - cartIDs.length), orderedItemQuantity.length),
      empty: null,
    );

    itemIDs == null ? null : await widget.database.ordersEntry(_submitOrder);

    //final _itemEntry = ItemEntry(quantityAvailable: );



    for(var i = 0; i < cartIDs.length; i++){
      cartIDs = cartIDs.toSet().toList();

      cartIDs == null ? null : await widget.database.deleteCartItem(cartIDs[i]);
  }
    itemIDs.clear();
    cartIDs.clear();
    orderedItemQuantity.clear();
  }
}
