import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/home_screens/cart.dart';
import 'package:flutter/material.dart';

//Our Category Data Object
class Category {
  const Category({ this.name});
  final String name;

}

// List of Category Data objects.
const List<Category> categories = <Category>[
  Category(name: 'Orders',),
  Category(name: 'Items'),

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
            title: Center(child:Text('Store',style: titleStylelight,)),
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
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new CategoryCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
      //theme: new ThemeData(primaryColor: Colors.deepOrange),
    );
  }
}

// Our CategoryCard data object
class CategoryCard extends StatelessWidget {
  const CategoryCard({ Key key, this.choice }) : super(key: key);
  final Category choice;

  //build and return our card with icon and text
  @override
  Widget build(BuildContext context) {

    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            new Text(choice.name, ),
          ],
        ),
      ),
    );

  }

}
void _goToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => page,
    ),
  );
}

// Our main method

