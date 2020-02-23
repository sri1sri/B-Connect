import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/add_to_cart_button.dart';
import 'package:bhavani_connect/home_screens/cart.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/home_screens/order_details.dart';
import 'package:flutter/material.dart';

//Our Category Data Object
class Category {
  const Category({ this.name});
  final String name;

}

// List of Category Data objects.
const List<Category> categories = <Category>[
  Category(name: 'Items',),
  Category(name: 'Orders'),

];

// Our MrTabs class.
//Will build and return our app structure.
class MrTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle label = new TextStyle(
        color: Color(0xFF1F4B6E),
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w600,
        fontSize: 25.0

    );
    TextStyle unselectedLabel = new TextStyle(
        color: Color(0xFF1F4B6E),
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w500,
        fontSize: 20.0
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
        length: categories.length,
        child: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(child:Text('Store',style: subTitleStyleLight,)),
            centerTitle: true,
            bottom: new TabBar(
              labelStyle: label,
              unselectedLabelStyle: unselectedLabel,
              isScrollable: true,
              tabs: categories.map((Category choice) {
                return new Tab(
                  text: choice.name,

                );
              }).toList(),
            ),
              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:() => Navigator.pop(context, false),
              ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () =>_goToPage(context, CartPage()),
                  // do something
              )
            ],
          ),
          body: new TabBarView(
            children: categories.map((Category choice) {
              if(choice.name == 'Items'){
                return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new ItemCard(choice: choice),
                );
              }else{
                return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new OrderCard(choice: choice),
                );
              }

            }).toList(),
          ),
        ),
      ),
      //theme: new ThemeData(primaryColor: Colors.deepOrange),
    );
  }
}

// Our CategoryCard data object
class ItemCard extends StatelessWidget {
  const ItemCard({ Key key, this.choice }) : super(key: key);
  final Category choice;

  //build and return our card with icon and text
  @override
  Widget build(BuildContext context) {

    return new SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          _ItemCard("ABC company", "Wires", "Electricals", "100 mts"),
          _ItemCard("DEF company", "Sand", "Raw Materials", "1000 kgs"),
          _ItemCard("GHI company", "Wood", "Goods", "50 logs"),
          SizedBox(height: 20,),
        ],
      ),
    );

  }


}

// Our main method


// Our CategoryCard data object
class OrderCard extends StatelessWidget {
  const OrderCard({ Key key, this.choice }) : super(key: key);
  final Category choice;

  //build and return our card with icon and text
  @override
  Widget build(BuildContext context) {

    return new SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          _OrderCard("ABC company", "Wires", "Electricals", "100 mts", context, OrderDetailsPage()),
          _OrderCard("DEF company", "Sand", "Raw Materials", "1000 kgs",context, OrderDetailsPage()),
          _OrderCard("GHI company", "Wood", "Goods", "50 logs",context, OrderDetailsPage()),
          SizedBox(height: 20,),
        ],
      ),
    );

  }


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

              Container(
                child: AnimatedButton(
                  onTap: () {
                    print("Add to Cart");
                  },
                  animationDuration: const Duration(milliseconds: 1000),
                  initialText: "Add to Cart",
                  finalText: "Added",
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


          SizedBox(height: 20,),
        ],



      ),
    ),
  );

}

_OrderCard(String companyName, String itemName, String category, String quantity, BuildContext context, Widget page)
{
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
            SizedBox(height: 10,),
            _OrderedItemsCard("ABC company", "Wires", "Electricals", "100 mts"),
            _OrderedItemsCard("DEF company", "Sand", "Raw Materials", "1000 kgs"),
            SizedBox(height: 10,),
            Text("Order Status",style: descriptionStyle,),
            SizedBox(height: 10,),
            Text("Approval pending from store manager",style: descriptionStyleDark,),
            SizedBox(height: 20,),
            Text("Tap for Order Details",style: descriptionStyleDarkBlur,),
            SizedBox(height: 20,),
          ],

        ),
      ),
    ),
    onTap: (){
      _goToPage(context, page);

    },
  );

}

_OrderedItemsCard(String companyName, String itemName, String category, String quantity)
{
  return Container(

      child: Card(
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
          ],



        ),
      ),
    );


}

void _goToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => page,
    ),
  );
}