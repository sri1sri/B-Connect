import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/add_stock_details/display_stock.dart';
import 'package:flutter/material.dart';

class AddStock extends StatelessWidget {
  AddStock({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddStock(
        database: database,
      ),
    );
  }
}

class F_AddStock extends StatefulWidget {
  F_AddStock({@required this.database});
  Database database;

  @override
  _F_AddStockState createState() => _F_AddStockState();
}

class _F_AddStockState extends State<F_AddStock> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget( context );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0,0,0,0 ),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color( 0xFF1F4B6E ),
            title: Center(
                child: Text(
                  'Stock details',
                  style: subTitleStyleLight,
                ) ),
            leading: IconButton(
              icon: Icon( Icons.arrow_back ),
              onPressed: () => Navigator.pop( context,false ),
            ),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: Text('',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: ()=> print(''),
              )
            ],
          ),
          body: _buildContent( context ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB( 10,0,10,0 ),
          child: Column(
            children: <Widget>[
              SizedBox( height: 5.0 ),
              _stockOptions( 'Companies',Icons.home ),
              _stockOptions( 'Categories' ,Icons.category),
              _stockOptions( 'Items' ,Icons.add_shopping_cart),
//              _options(''),
            ],
          ),
        ),
      ),
    );
  }


  Widget _stockOptions(String optionTitle, IconData icons) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        onPressed: () =>
            GoToPage( context,
                DisplayStock( database: widget.database,title: optionTitle ) ),
        padding: EdgeInsets.all( 15.0 ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 0.0 ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                new Icon(
                  icons,
                  size: 40,
                  color: backgroundColor,
                ),
              ],
            ),
            Column(
              children: <Widget>[

                Text( optionTitle,style: titleStyle ),
              ],

            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                  size: 30,
                ),
              ],

            ),

          ],

        ),
      ),

    );
  }
}