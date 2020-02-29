import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/database_model/cart_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
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
  int _n = 0;
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
//              color: Colors.white,
              child: FlatButton(
            onPressed: () {
              print('clearing cart');
            },
            child: Text(
              "Clear",
              style: subTitleStyle,
            ),
            //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          )),
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
              onPressed: () => {print("Place Order")},
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
                color: backgroundColor,
              ),
              label: Text('Place Order', style: titleStyle))),
    );
  }

  Widget _cartContent(BuildContext context) {
    return StreamBuilder<List<Cart>>(
      stream: widget.database.viewCartItems(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Cart>(
          snapshot: snapshot,
          itemBuilder: (context, cartData) =>

              StreamBuilder<ItemEntry>(
                stream: widget.database.viewItem(cartData.itemID),
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
                        _ItemCard( itemData, cartData),
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

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => page,
      ),
    );
  }

  _ItemCard(ItemEntry itemData, Cart cartData) {
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
                    "Quantity",
                    style: descriptionStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${itemData.quantity} ${itemData.measure}',
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
                      onPressed: add,
                      child: new Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      backgroundColor: backgroundColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    new Text('$_n', style: new TextStyle(fontSize: 30.0)),
                    SizedBox(
                      width: 15,
                    ),
                    new FloatingActionButton(
                      onPressed: minus,
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
                  text: 'Remove Itemm',
                  textColor: activeButtonTextColor,
                  backgroundColor: removeButtonBackgroundColor,
                  onPressed: () => {
                    widget.database.deleteCartItem(cartData.cartID),
                    print(cartData.cartID),
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
}
