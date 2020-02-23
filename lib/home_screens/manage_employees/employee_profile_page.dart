import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}

class EmployeeProfilePage extends StatelessWidget {
  EmployeeProfilePage({@required this.database, @required this.employeeID});
  Database database;
  String employeeID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_EmployeeProfilePage(
        database: database,
        employeeID: employeeID,
      ),
    );
  }
}

class F_EmployeeProfilePage extends StatefulWidget {
  F_EmployeeProfilePage({@required this.database, @required this.employeeID});
  Database database;
  String employeeID;

  @override
  _F_EmployeeProfilePageState createState() => _F_EmployeeProfilePageState();
}

class _F_EmployeeProfilePageState extends State<F_EmployeeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    print(widget.employeeID);
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(
                child: Text(
              'Employee details',
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
    return StreamBuilder<EmployeesList>(
        stream: widget.database.readEmployee(widget.employeeID),
        builder: (context, snapshot) {
          final employee = snapshot.data;
          return Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                  Container(
                      height: 430,
                      width: 440,
                      //color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: -60.0),
                      margin: const EdgeInsets.only(left: .2),
                      child: Column(children: <Widget>[
                        Stack(children: [
                          Container(
                            height: 430.0,
                          ),
                          Positioned(
                              left: 70.0,
                              right: 70.0,
                              top: 120.0,
                              bottom: 20.0,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
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
                                                    'role${employee.employeeRole}',
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
                                                Text("Bhavani Project",
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
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            MaterialButton(
                                              minWidth: 40,
                                              onPressed: () {
                                                customLaunch(
                                                    'mailto:sales@bhavaniproperties.com?Subject=test%20Subject&body=test%20body');
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.mail,
                                                    color: Colors.blue,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            MaterialButton(
                                              minWidth: 40,
                                              onPressed: () {
                                                customLaunch(
                                                    'tel:${employee.employeeContactNumber}');
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.green,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            MaterialButton(
                                              minWidth: 40,
                                              onPressed: () {
                                                customLaunch(
                                                    'sms:${employee.employeeContactNumber}');
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.message,
                                                    color: Colors.purple,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
//
                                      ]))),
                          Positioned(
                              left: 190.0,
                              right: 190.0,
                              top: 30.0,
                              bottom: 260.0,
                              child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/profile_image.jpg"),
                                          fit: BoxFit.fill)))),
                        ]),
                      ])),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
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
                                '29-10-1996${employee.employeeDateOfBirth}',
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
                                'Male${employee.employeeGender}',
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
                                '21-02-2017${employee.employeeJoinDate}',
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
                                'Coimbatore${employee.employeeLatitude}',
                                style: subTitleStyle,
                              ),
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: backgroundColor,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Edit User Role',
                                  style: titleStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),

//                      child: Text('Edit User Role',style: titleStyle),
                        onTap: () {
                          editUserRole(context);
                          print('editProfile');
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

void editUserRole(BuildContext context) {
  Dialog fancyDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 300.0,
      width: 300.0,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'User Role',
                  style: subTitleStyleLight,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Submit', style: titleStyle)),
              ),
            ),
          ),
          Align(
            // These values are based on trial & error method
            alignment: Alignment(1.05, -1.05),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => fancyDialog);
}
//