import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/goods_approvals.dart';
import 'package:bhavani_connect/home_screens/notifications_screens/notification_page.dart';
import 'package:bhavani_connect/home_screens/store_screen.dart';
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
    "Goods Approvals",
    "Item entry",
    "Store",
    "Inventory",
    "Notifications",
    "Attendance",
    "Employees"
  ];
  List<IconData> F_icons = [
    Icons.touch_app,
    Icons.note_add,
    Icons.store,
    Icons.dashboard,
    Icons.notifications,
    Icons.pan_tool,
    Icons.account_circle
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
        print(employee.username);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Hello!",
                  style: titleStyle,
                ),
                Text(
                  "${employee.username}(${employee.role})",
                  style: subTitleStyle,
                ),
              ],
            ),
            actions: <Widget>[
              InkWell(
                child: Icon(
                  Icons.notifications,
                  color: backgroundColor,
                ),
                onTap: () => _confirmSignOut(context),
              )
            ],
          ),
          body: new GridView.builder(
            itemCount: features.length,
            gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: new Card(
                  elevation: 5.0,
                  child: new Container(
                    alignment: Alignment.center,
                    margin: new EdgeInsets.only(
                        top: 30.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: new Column(
                      children: <Widget>[
                        new Icon(
                          F_icons[index],
                          size: 50,
                          color: backgroundColor,
                        ),
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
                            ));
                      }
                      break;

                    case 'Goods Approvals':
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
                        GoToPage(context, MrTabs());
                      }
                      break;
                    case 'Notifications':
                      {
                        GoToPage(context, NotificationsPage());
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
