import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/showAllInvoice.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/day_selection.dart';
import 'package:bhavani_connect/home_screens/add_stock_details/add_stock.dart';
import 'package:bhavani_connect/home_screens/attendance/attendance_page.dart';
import 'package:bhavani_connect/home_screens/inventory/inventory_home_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/goods_approvals.dart';
import 'package:bhavani_connect/home_screens/notification_screen.dart';
import 'package:bhavani_connect/home_screens/store/store_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'JCB_Entries/daily_readings.dart';
import 'manage_employees/manage_employees_page.dart';

void GoToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => page,
    ),
  );
}


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
    "Attendance",
    "Employees",
    "Vehicle Entries",
    "Stock Register"
  ];
  List<String> F_image = [
    "images/Approval.jpg",
    "images/Addstock.jpg",
    "images/store.jpg",
    "images/inventory.png",
    "images/Attendance.jpg",
    "images/ManageEmployees.jpg",
    "images/jcb.png",
    "images/invoice.png"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _firebaseMessaging = FirebaseMessaging();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final employeeDetails = EmployeeDetails(
        deviceToken: DEVICE_TOKEN);
    widget.database.updateEmployeeDetails(
        employeeDetails, EMPLOYEE_ID);

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
            preferredSize:
            Size.fromHeight(200),
            child: CustomAppBar(
              leftActionBar: Container(
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
              rightAction: () {
                GoToPage(context, NotificationPage());
              },
              secondaryText: 'Welcome to B-Connect',
              //primaryText: 'Hello ${employee.username}(${employee.role}),',
              primaryText:
                  "Hello " + (employee == null ? "Not updated" : employee.username) + " ("+(employee == null ? "" : employee.role)+ ")",

            ),
          ),

          bottomSheet: (employee == null ? "" : employee.role) == 'Not assigned' ? Center(
            child: Center(
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage(
                      'images/no_internet.png',
                    ),
                    height: 200.0,
                    width: 200.0,
                  ),
                  SizedBox(height: 20.0,),
                  Text('You are not assigned to any role.\nAsk your manager to assign a role.', style: subTitleStyle,)
                ],
              ),
            ),
          ) : Container(
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
                            Image.asset(
                              F_image[index],height: 60,
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
                              InventoryPage(database: widget.database,),
                            );
                          }
                          break;

                        case 'Attendance':
                          {
                            GoToPage(
                              context,
                              AttendancePage(database: widget.database,),
                            );
                          }
                          break;
                        case 'Add stock':
                          {
                            GoToPage(
                                context,
                                AddStock(
                                  database: widget.database,
                                  employee: employee,
                                ));
                          }
                          break;
                        case 'Vehicle Entries':
                          {
                            GoToPage(
                                context,DaySelection());
                          }
                          break;
                        case 'Stock Register':
                          {
                            GoToPage(
                                context,ShowAllInvoice());
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
