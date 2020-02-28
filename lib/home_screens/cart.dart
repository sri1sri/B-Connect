import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/store/store_screen.dart';
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
  int _n = 0;
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
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(115),
          //preferredSize : Size(double.infinity, 100),
          child: CustomAppBar(
            leftActionBar: Container(
              child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
            ),
            leftAction: (){
              Navigator.pop(context,true);
            },
            rightActionBar: Container(
//              color: Colors.white,
              child: FlatButton(
              onPressed: () {print('clearing cart');},
              child: Text("Clear",style: subTitleStyle,),
              //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
              )
            ),
            rightAction: (){
              print('right action bar is pressed in appbar');
            },
            primaryText: null,
            secondaryText: 'Cart',
            tabBarWidget: null,
          ),
        ),

//        AppBar(
//          backgroundColor: Color(0xFF1F4B6E),
//          title: Center(child:Text('Cart',style: subTitleStyleLight,)),
//
//    leading: IconButton(icon:Icon(Icons.arrow_back),
//    onPressed:() => Navigator.pop(context, false),
//        ),
//          centerTitle: true,
//          actions: <Widget>[
//            FlatButton(
//              textColor: Colors.white,
//              onPressed: () {},
//              child: Text("Clear",style: subTitleStyleLight,),
//              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
//            ),
//          ],
//        ),
        body: Container(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 10,),
                _ItemCard("ABC company", "Wires", "Electricals", "100 mts"),
                _ItemCard("DEF company", "Sand", "Raw Materials", "1000 kgs"),
                _ItemCard("GHI company", "Wood", "Goods", "50 logs"),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      bottomNavigationBar: BottomAppBar(
        child:   FlatButton.icon(

            color: activeButtonTextColor,
            onPressed: () => { print ("Place Order")},
            icon: Icon(Icons.shopping_cart,size: 30,color: backgroundColor,),
            label: Text('Place Order',style:titleStyle))


      ),

    );
  }
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0)
        _n--;
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
  _ItemCard(String companyName, String itemName, String category, String quantity)
  {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FloatingActionButton(
                      onPressed: add,
                      child: new Icon(Icons.add, color: Colors.white,),
                      backgroundColor: backgroundColor,),
                    SizedBox(width: 15,),

                    new Text('$_n',
                        style: new TextStyle(fontSize: 30.0)),
                    SizedBox(width: 15,),
                    new FloatingActionButton(
                      onPressed: minus,
                      child: new Icon(
                          const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                          color: backgroundColor,),
                      backgroundColor: Colors.white,),
                  ],
                ),
                SizedBox(height: 10.0),
//                FloatingActionButton(
//                  onPressed: () => { print ("remove item")},
//                  child: new Icon(
//                    Icons.close,size: 30,color: Colors.white,),
//                  backgroundColor: removeButtonBackgroundColor),
                ToDoButton(
                  assetName: 'images/google-lodgo.png',
                  text: 'Remove Item',
                  textColor: activeButtonTextColor,
                  backgroundColor: removeButtonBackgroundColor,
                  onPressed: () => { print ("remove item")},
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
