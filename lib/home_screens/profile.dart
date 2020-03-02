import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_launch/flutter_launch.dart';



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

class ProfilePage extends StatelessWidget {
  ProfilePage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ProfilePage(
          database: database),
    );
  }
}

class F_ProfilePage extends StatefulWidget {
  F_ProfilePage({@required this.database});
  Database database;
  String employeeName ;

  @override
  _F_ProfilePageState createState() => _F_ProfilePageState();
}

class _F_ProfilePageState extends State<F_ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          backgroundColor: Colors.white,

          appBar:
          PreferredSize(
            preferredSize: Size.fromHeight(150),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: null,
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: Container(
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                    child: Icon(Icons.more_vert,
                      color: backgroundColor,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage() ),
                      );
                    }
                ),
              ),
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: 'Hello!',
              secondaryText: 'Your Profile',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(context),
        ),
      ),

    );

  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<EmployeesList>(
        stream: widget.database.readEmployee(EMPLOYEE_ID),
        builder: (context, snapshot) {
          final employee = snapshot.data;

          return SingleChildScrollView(
            child: Center(
              child:
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            height: 400,
                            width: 440,
                            //color: Colors.red,
                            //padding: EdgeInsets.symmetric(horizontal: -60.0),
//                            margin: const EdgeInsets.only(left: .2),
                            child: Column(children: <Widget>[
                              Stack(children: [
                                Container(
                                  height: 400.0,
                                ),
                                Positioned(
                                    left: 0.0,
                                    right: 0.0,
                                    top: 120.0,
                                    bottom: 20.0,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 0.0,
                                            right: 0.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        height: 20.0,
                                        width: 280.0,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              new BoxShadow(
                                                color: Colors.black54,
                                                blurRadius: 10.0,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.white),
                                        child: Column(
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 70,
                                              ),
                                              Text(
                                                '${employee.employeeName}',
                                                style: titleStyle,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${employee.employeeContactNumber}',
                                                style: descriptionStyleDark,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        "Role",
                                                        style: subTitleStyle,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          '${employee.employeeRole}',
                                                          style:
                                                          descriptionStyleDark),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        '|',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily: 'OpenSans',
                                                          fontSize: 30.0,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        "Project",
                                                        style: subTitleStyle,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text("Bhavani",
                                                          style:
                                                          descriptionStyleDark),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),

//
                                            ]))),
                                Positioned(
                                  left: 120.0,
                                  right: 120.0,
                                  top: 30.0,
                                  bottom: 230.0,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                    AssetImage("images/profile_image.jpg"),
                                    backgroundColor: Colors.transparent,
                                  ),



//                                    Container(
//                                        height: 50.0,
//                                        width: 50.0,
//                                        decoration: BoxDecoration(
//                                            borderRadius:
//                                            BorderRadius.circular(100.0),
//                                            image: DecorationImage(
//                                                image: AssetImage(
//                                                    "images/profile_image.jpg"),
//                                                fit: BoxFit.fill)))
                                ),
                              ]),
                            ])),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 10.0, bottom: 10.0),
                          height: 260.0,
                          width: 375.0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 10.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Date Of Birth",
                                    style: descriptionStyleDark),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '29-10-1996',
                                  style: subTitleStyle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Gender", style: descriptionStyleDark),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Male',
                                  style: subTitleStyle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Joining Date", style: descriptionStyleDark),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '21-02-2019',
                                  style: subTitleStyle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Location", style: descriptionStyleDark),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Coimbatore',
                                  style: subTitleStyle,
                                ),
                              ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
