import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/dashboard/dashboard_bloc.dart';
import 'package:bhavani_connect/dashboard/dashboard_extras.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/showAllInvoice.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/vehicle_list_details.dart';
import 'package:bhavani_connect/home_screens/notification_screen.dart';
import 'package:bhavani_connect/vehicle/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  // Insert into injector file if you use it.
  // injector.map<DashboardBloc>((i) => DashboardBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<DashboardBloc>();

  @override
  void initState() {
    super.initState();
    context.bloc<DashboardBloc>().add(LoadEmployee());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SealedBlocBuilder4<DashboardBloc,
        DashboardState,
        Initial,
        Loading,
        Success,
        Failure>(builder: (context, states) {
      return states(
            (Initial initial) => Center(child: CircularProgressIndicator()),
            (Loading loading) => Center(child: CircularProgressIndicator()),
            (Success success) =>
            Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(200),
                child: CustomAppBar(
                  leftActionBar: Container(),
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
                  primaryText:
                  'Hello ${success.data.username}(${success.data.role}),',
                ),
              ),
              bottomSheet:
              (success?.data == null || (success?.data?.role == 'Not assigned'))
                  ? Center(
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'You are not assigned to any role.\nAsk your manager to assign a role.',
                        style: subTitleStyle,
                      )
                    ],
                  ),
                ),
              )
                  : Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 170.0, bottom: 20.0, left: 10.0, right: 10.0),
                  child: new GridView.builder(
                    itemCount: dashBoardFeatures.length,
                    gridDelegate:
                    new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0),
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                        child: new Card(
                          elevation: 0.0,
                          child: new Container(
                            alignment: Alignment.center,
                            margin: new EdgeInsets.only(
                                top: 5.0,
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0),
                            child: new Column(
                              children: <Widget>[
                                Image.asset(
                                  dashboardImage[index],
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                new Text(
                                  dashBoardFeatures[index],
                                  style: descriptionStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          switch (dashBoardFeatures[index]) {
//                        case 'Employees':
//                          {
//                            GoToPage(
//                                context,
//                                ManageEmployeesPage(
//                                  database: widget.database,
//                                  employee: employee,
//                                ));
//                          }
//                          break;
//
//                        case 'Approvals':
//                          {
//                            GoToPage(
//                                context,
//                                GoodsApprovalsPage(
//                                  database: widget.database,
//                                  employee: employee,
//                                ));
//                          }
//                          break;
//                        case 'Store':
//                          {
//                            GoToPage(
//                                context,
//                                StorePage(
//                                  database: widget.database,
//                                  employee: employee,
//                                ));
//                          }
//                          break;
//
//                        case 'Inventory':
//                          {
//                            GoToPage(
//                              context,
//                              InventoryPage(database: widget.database,),
//                            );
//                          }
//                          break;
//
//                        case 'Attendance':
//                          {
//                            GoToPage(
//                              context,
//                              AttendancePage(database: widget.database,),
//                            );
//                          }
//                          break;
//                        case 'Add stock':
//                          {
//                            GoToPage(
//                                context,
//                                AddStock(
//                                  database: widget.database,
//                                  employee: employee,
//                                ));
//                          }
//                          break;
                            case 'Vehicle Entries':
                              context.bloc<AuthenticationBloc>().gotoVehicle();
                              break;
                            case 'Stock Register':
                              {
                                GoToPage(context, ShowAllInvoice());
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
            ),
            (Failure failure) =>
            Center(
              child: Text('failed to fetch posts'),
            ),
      );
    });
  }
}
