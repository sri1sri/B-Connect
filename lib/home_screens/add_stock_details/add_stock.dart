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
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(
                child: Text(
              'Stock details',
              style: subTitleStyleLight,
            )),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            centerTitle: true,
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              _options('Companies'),
              _options('Categories'),
              _options('Items'),
//              _options(''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _options(String optionTitle) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        onPressed: () => GoToPage(context, DisplayStock(database: widget.database, title: optionTitle)),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Container(
          color: Colors.black12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text(optionTitle, style: titleStyle),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black38,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
