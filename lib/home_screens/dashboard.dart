import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/add_stock_details/add_stock.dart';
import 'package:bhavani_connect/home_screens/attendance/attendance_page.dart';
import 'package:bhavani_connect/home_screens/inventory/iventory_home_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/goods_approvals.dart';
import 'package:bhavani_connect/home_screens/notification_screen.dart';
import 'package:bhavani_connect/home_screens/notifications_screens/notification_page.dart';
import 'package:bhavani_connect/home_screens/store/orders_screen.dart';
import 'package:bhavani_connect/home_screens/store/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///9588495083
import 'manage_employees/manage_employees_page.dart';

class Dashboard extends StatelessWidget {
  Dashboard({@required this.database});

  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_Dashboard(database: database),
    );
  }
}

class F_Dashboard extends StatefulWidget {
  F_Dashboard({@required this.database});

  Database database;

  @override
  _F_DashboardState createState() => _F_DashboardState();
}

class _F_DashboardState extends State<F_Dashboard> {
  var features = [
    "Approvals",
    "Add stock",
    "Store",
    "Inventory",
//    "Notifications",
    "Attendance",
    "Employees"
  ];
  List<String> F_image = [
    "images/Approval.jpg",
    "images/Addstock.jpg",
    "images/store.jpg",
    "images/inventory.png",
    "images/Attendance.jpg",
    "images/ManageEmployees.jpg"


  ];

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

  @override
  Widget _buildContent(BuildContext context) {
    return StreamBuilder<EmployeeDetails>(
      stream: widget.database.readEmployeeDetails(),
      builder: (context, snapshot) {
        final employee = snapshot.data;

        return Scaffold(
          backgroundColor: Colors.white,

          appBar: PreferredSize(
            preferredSize: Size.fromHeight(160),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                  // child: Icon(Icons.arrow_back, size: 40,),
                  ),
              leftAction: () {
                print('left action bar is pressed in appbar');
              },
              rightActionBar: Container(
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                    child: Icon(
                      Icons.notifications,
                      color: backgroundColor,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()),
                      );
                    }),
              ),

//
//              Container(
//                  child: FlatButton(
//                    onPressed: () {
//                      GoToPage(context, NotificationPage());
//                    },
//                    child: Icon(Icons.notifications, size: 30,color: backgroundColor),
//                    //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
//                  )),

              rightAction: () {
                GoToPage(context, NotificationPage());
              },
              secondaryText: 'Welcome to B-Connect',
              //primaryText: 'Hello ${employee.username}(${employee.role}),',
              primaryText:
                  "Hello " + (employee == null ? "" : employee.username) + " ("+(employee == null ? "" : employee.role)+")",
            ),

            //customAppBar1(Container(color: Colors.green,),Container(color:  Colors.red,), 'hghg', 'hgygi',  (){print('tftft');}, (){print('tftft');}),
          ),

//          body: PreferredSize(
//            preferredSize: Size(double.infinity, 100),
//            child: Container(
//              decoration: BoxDecoration(
//                  boxShadow: [BoxShadow(
//                      color: Colors.black12,
//                      spreadRadius: 5,
//                      blurRadius: 2
//                  )]
//              ),
//              width: MediaQuery.of(context).size.width,
//              height: 130,8333
//              child: Container(
//                decoration: BoxDecoration(
//                    color: backgroundColor,
//                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
//                ),
//                child: Container(
//                  margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: [
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(
//                            "Hello!",
//                            style: activeSubTitleStyle,
//                          ),
//                          Text(
//                            "${employee.username}(${employee.role})",
//                            style: subTitleStyleLight,
//                          ),
//                        ],
//                      ),
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          InkWell(
//                            child: Icon(
//                              Icons.notifications,
//                              color: activeButtonTextColor,
//                            ),
//                            onTap: () => GoToPage(context, NotificationPage())
//                          ),
//                        ],
//                      )
//
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),

//          body: Padding(
//            padding: const EdgeInsets.only(
//                top: 50.0, bottom: 10.0, left: 10.0, right: 10.0),
//            child: new GridView.builder(
//              itemCount: features.length,
//              gridDelegate:
//              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//              itemBuilder: (BuildContext context, int index) {
//                return new GestureDetector(
//                  child: new Card(
//                    elevation: 5.0,
//                    child: new Container(
//                      alignment: Alignment.center,
//                      margin: new EdgeInsets.only(
//                          top: 25.0, bottom: 10.0, left: 10.0, right: 10.0),
//                      child: new Column(
//                        children: <Widget>[
//                          new Icon(
//                            F_icons[index],
//                            size: 50,
//                            color: backgroundColor,
//                          ),
//                          new Text(
//                            features[index],
//                            style: descriptionStyle,
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  onTap: () {
//                    switch (features[index]) {
//                      case 'Employees':
//                        {
//                          GoToPage(
//                              context,
//                              ManageEmployeesPage(
//                                database: widget.database,
//                                employee: employee,
//                              ));
//                        }
//                        break;
//
//                      case 'Goods Approvals':
//                        {
//                          GoToPage(
//                              context,
//                              GoodsApprovalsPage(
//                                database: widget.database,
//                                employee: employee,
//                              ));
//                        }
//                        break;
//                      case 'Store':
//                        {
//                          GoToPage(context, StorePage(database: widget.database,employeeRole: employee.role,));
//                        }
//                        break;
//
//                      case 'Inventory':
//                        {
//                          GoToPage(context, InventoryPage(),);
//                        }
//                        break;
//
//                      case 'Attendance':{
//                        GoToPage(context, AttendancePage(),);
//                      }
//                      break;
////                      case 'Notifications':
////                        {
////                          GoToPage(context, NotificationsPage());
////                        }
////                        break;
//
//                      case 'Add stock details':
//                        {
//                          GoToPage(context, AddStock(database: widget.database,));
//                        }
//                        break;
//
//
//                      default:
//                        {}
//                        break;
//                    }
//                  },
//                );
//              },
//            ),
//          ),
          bottomSheet: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 170.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: new GridView.builder(
                itemCount: features.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 0
                  ),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    child: new Card(
                      elevation: 0.0,
                      child: new Container(
                        alignment: Alignment.center,
                        margin: new EdgeInsets.only(
                            top: 5.0, bottom: 0.0, left: 0.0, right: 0.0),
                        child: new Column(
                          children: <Widget>[
//                            Container(
//
//                                height: 60.0,
//                                width: 60.0,
//                                decoration: BoxDecoration(
//                                    image: DecorationImage(
//                                        image: AssetImage(
//                                          F_image[index],),
//                                        fit: BoxFit.fill))),
                            Image.asset(
                              F_image[index],height: 80,
                            ),
                            SizedBox(height: 5,),
                            new Text(
                              features[index],
                              style: descriptionStyle,
                            ),

                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      switch (features[index]) {
                        case 'Employees':
                          {
                            GoToPage(
                                context,
                                ManageEmployeesPage(
                                  database: widget.database,
                                  employee: employee,
                                ));
                          }
                          break;

                        case 'Approvals':
                          {
                            GoToPage(
                                context,
                                GoodsApprovalsPage(
                                  database: widget.database,
                                  employee: employee,
                                ));
                          }
                          break;
                        case 'Store':
                          {
                            GoToPage(
                                context,
                                StorePage(
                                  database: widget.database,
                                  employee: employee,
                                ));
                          }
                          break;

                        case 'Inventory':
                          {
                            GoToPage(
                              context,
                              InventoryPage(),
                            );
                          }
                          break;

                        case 'Attendance':
                          {
                            GoToPage(
                              context,
                              AttendancePage(),
                            );
                          }
                          break;
//                      case 'Notifications':
//                        {
//                          GoToPage(context, NotificationsPage());
//                        }
//                        break;

                        case 'Add stock':
                          {
                            GoToPage(
                                context,
                                AddStock(
                                  database: widget.database,
                                ));
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
          ),
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      //Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }
}
