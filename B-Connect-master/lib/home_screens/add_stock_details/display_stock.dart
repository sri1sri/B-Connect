import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
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
  var features = [
    "Goods Approvals",
    "Add stock details",
    "Store",
    "Inventory",
//    "Notifications",
    "Attendance",
    "Employees"
  ];
  List<IconData> F_icons = [
    Icons.touch_app,
    Icons.note_add,
    Icons.store,
    Icons.dashboard,
//    Icons.notifications,
    Icons.pan_tool,
    Icons.account_circle
  ];
  double _crossAxisSpacing = 8, _mainAxisSpacing = 10, _aspectRatio = 5;
  int _crossAxisCount = 1;
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
            preferredSize: Size.fromHeight(120),
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
              secondaryText: 'Add Details',
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
          body:  Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 90.0, left: 10.0, right: 10.0),
            child: new GridView.builder(
              itemCount: features.length,
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                crossAxisSpacing: _crossAxisSpacing,
                mainAxisSpacing: _mainAxisSpacing,
                childAspectRatio: _aspectRatio,
              ),
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  child: new FlatButton(
                    color: Colors.white,
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
                              F_icons[index],
                              size: 40,
                              color: backgroundColor,
                            ),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              features[index],
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.black54,
                              size: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    switch (features[index]) {
                      case 'Employees':
                        {

                        }
                        break;

                      case 'Goods Approvals':
                        {

                        }
                        break;
                      case 'Store':
                        {
                          //GoToPage(context, StorePage(database: widget.database,employeeRole: employee.role,));
                        }
                        break;

                      case 'Inventory':
                        {
                          //GoToPage(context, InventoryPage(),);
                        }
                        break;

                      case 'Attendance':{
                        //GoToPage(context, AttendancePage(),);
                      }
                      break;

                      case 'Add stock details':
                        {
                          // GoToPage(context, AddStock(database: widget.database,));
                        }
                        break;


                      default:
                        {}
                        break;
                    }
                  },
                );
              },
            ),
          ),
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

//  Widget buildCompanyCard(CommonVaribles commonVariables) {
//    GridView.builder(
//      itemCount: commonVariables.companies.length,
//      gridDelegate:
//      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//      itemBuilder: (BuildContext context, int index) {
//        return new GestureDetector(
//          child: new Card(
//            elevation: 5.0,
//            child: new Container(
//              alignment: Alignment.center,
//              margin: new EdgeInsets.only(
//                  top: 25.0, bottom: 10.0, left: 10.0, right: 10.0),
//              child: new Column(
//                children: <Widget>[
//              Container(
//              width: double.infinity,
//                child: FlatButton(
//                  onPressed: () => print('Company'),
//                  padding: EdgeInsets.all(15.0),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(0.0),
//                  ),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Column(
//                        children: <Widget>[
//                          new Icon(
//                            F_icons[index],
//                            size: 50,
//                            color: backgroundColor,
//                          ),
//
//                        ],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          new Text(
//                            features[index],
//                            style: descriptionStyle,
//                          ),
//                        ],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Icon(
//                            Icons.add,
//                            color: Colors.black54,
//                            size: 30,
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//
//                ],
//              ),
//            ),
//          ),
//          onTap: () {
//          },
//        );
//      },
//    );
//  }
  @override
  Widget _buildContent(BuildContext context,int index) {
    return StreamBuilder<CommonVaribles>(
        stream: widget.database.readCommonVariables(),
        builder: (context, snapshot) {
          final commonVariables = snapshot.data;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                  top: 250.0, bottom: 90.0, left: 10.0, right: 10.0),

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
                          F_icons[index],
                          size: 50,
                          color: backgroundColor,
                        ),

                      ],
                    ),
                    Column(
                      children: <Widget>[
                        new Text(
                          features[index],
                          style: descriptionStyle,
                        ),
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
            ),

          );
        }
    );
  }

//  Widget _companyCard(int index) {
//    return Container(
//      width: double.infinity,
//      child: FlatButton(
//        onPressed: () => print('Company'),
//        padding: EdgeInsets.all(15.0),
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(0.0),
//        ),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Column(
//              children: <Widget>[
//                new Icon(
//                  F_icons[index],
//                  size: 50,
//                  color: backgroundColor,
//                ),
//
//              ],
//            ),
//            Column(
//              children: <Widget>[
//                new Text(
//                  features[index],
//                  style: descriptionStyle,
//                ),
//              ],
//            ),
//            Column(
//              children: <Widget>[
//                Icon(
//                  Icons.add,
//                  color: Colors.black54,
//                  size: 30,
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
}
