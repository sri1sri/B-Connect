import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/common_variables.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/add_stock_details/edit_stock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisplayStock extends StatelessWidget {
  DisplayStock({@required this.database, @required this.title});
  Database database;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DisplayStock(
        database: database,
        title: title,
      ),
    );
  }
}

class F_DisplayStock extends StatefulWidget {
  F_DisplayStock({@required this.database, @required this.title});
  Database database;
  String title;

  @override
  _F_DisplayStockState createState() => _F_DisplayStockState();
}

class _F_DisplayStockState extends State<F_DisplayStock> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(115),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: null,
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Stock Details',
              tabBarWidget: null,
            ),
          ),

//          new AppBar(
//            backgroundColor: Color(0xFF1F4B6E),
//            title: Center(
//                child: Text(
//              widget.title,
//              style: subTitleStyleLight,
//            )),
//            leading: IconButton(
//              icon: Icon(Icons.arrow_back),
//              onPressed: () => Navigator.pop(context, false),
//            ),
//            centerTitle: true,
//            actions: <Widget>[
//              FlatButton(
//                child: Text(
//                  '',
//                  style: TextStyle(
//                    fontSize: 18,
//                    color: Colors.white,
//                  ),
//                ),
//                onPressed: () => print(''),
//              )
//            ],
//          ),
          body: _buildContent(context),
          floatingActionButton: FloatingActionButton(
            elevation: 90,
            backgroundColor: backgroundColor,
            autofocus: true,
            onPressed: () {
              GoToPage(
                  context,
                  EditStock(
                    database: widget.database,
                    title: widget.title,
                  ));
            },
            child: Icon(Icons.add),
            tooltip: 'Add Company',
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  Widget buildCompanyCard(CommonVaribles commonVariables) {
    GridView.builder(
      itemCount: commonVariables.companies.length,
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.center,
              margin: new EdgeInsets.only(
                  top: 25.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: new Column(
                children: <Widget>[
//                  new Icon(
//                    F_icons[index],
//                    size: 50,
//                    color: backgroundColor,
//                  ),
                  new Text(
                    commonVariables.companies[index],
                    style: descriptionStyle,
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<CommonVaribles>(
        stream: widget.database.readCommonVariables(),
        builder: (context, snapshot) {
          final commonVariables = snapshot.data;

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    buildCompanyCard(commonVariables),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _companyCard(String companyName, IconData icons) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        onPressed: () => print('Company'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
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
                Text(companyName, style: titleStyle),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.add,
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
