import 'package:bhavani_connect/authentication_screen/login_screens/phone_number_page.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_CartPage(),
    );
  }
}

class F_CartPage extends StatefulWidget {
  @override
  _F_CartPageState createState() => _F_CartPageState();
}

class _F_CartPageState extends State<F_CartPage> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget (BuildContext context){
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
        appBar: AppBar(
          backgroundColor: Color(0xFF1F4B6E),
          title: Center(child:Text('Cart',style: titleStylelight,)),

    leading: IconButton(icon:Icon(Icons.arrow_back),
    onPressed:() => Navigator.pop(context, false),
        ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {},
              child: Text("Clear",style: activeSubTitleStyle,),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10,),
              _ItemCard("ABC company", "Wires", "Electricals", "100 mts"),
              _ItemCard("DEF company", "Sand", "Raw Materials", "1000 kgs"),
              _ItemCard("GHI company", "Wood", "Goods", "50 logs"),
              SizedBox(height: 20,),
              ToDoButton(
                assetName: 'images/google-lodgo.png',
                text: 'Place Order',
                textColor: activeButtonTextColor,
                backgroundColor: activeButtonBackgroundColor,
                onPressed: () => _goToPage(context, MrTabs()),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ));
  }

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => page,
      ),
    );
  }
  _ItemCard(String companyName, String itemName, String category, String quantity)
  {
    return Container(

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    children: <Widget>[

                      Text("Company Name",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(companyName,style: descriptionStyleDark,),
                      SizedBox(height: 10,),
                      Text("Item names",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(itemName,style: descriptionStyleDark,),
                    ]
                ),
                Column(
                    children: <Widget>[

                      Text("Category",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(category,style: descriptionStyleDark,),
                      SizedBox(height: 10,),
                      Text("Quantity",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(quantity,style: descriptionStyleDark,),
                    ]
                ),
              ],
            ),
            SizedBox(height: 20,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToDoButton(
                    assetName: 'images/google-lodgo.png',
                    text: 'Select Quantity',
                    textColor: backgroundColor,
                    backgroundColor: inActiveButtonBackgroundColor,
                    onPressed: () => {}
                ),
                SizedBox(height: 10.0),
                ToDoButton(
                  assetName: 'images/google-lodgo.png',
                  text: 'Remove Item',
                  textColor: activeButtonTextColor,
                  backgroundColor: removeButtonBackgroundColor,
                  onPressed: () => {},
                ),

              ],
            ),

            SizedBox(height: 20,),
          ],



        ),
      ),
    );

  }

}