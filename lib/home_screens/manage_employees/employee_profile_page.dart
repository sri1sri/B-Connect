import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/store/add_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}

class EmployeeProfilePage extends StatelessWidget {
  EmployeeProfilePage({@required this.database, @required this.employeeID, @required this.employee});
  Database database;
  String employeeID;
  EmployeeDetails employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_EmployeeProfilePage(
        database: database,
        employeeID: employeeID,
        employee: employee,
      ),
    );
  }
}

class F_EmployeeProfilePage extends StatefulWidget {
  F_EmployeeProfilePage({@required this.database, @required this.employeeID, @required this.employee});
  Database database;
  String employeeID;
  EmployeeDetails employee;
  String selectedRole = 'Not assigned';

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
          appBar:
          PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: Container(
              ),
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Manage Employees',
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
        stream: widget.database.readEmployee(widget.employeeID),
        builder: (context, snapshot) {
          final employee = snapshot.data;



          return StreamBuilder<CommonVaribles>(
            stream: widget.database.readCommonVariables(),
            builder: (context, snapshots) {

              final commonVariables = snapshots.data;

              return SingleChildScrollView(
                child: Center(
                  child:
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 430,
                            width: 440,
                            margin: const EdgeInsets.only(left: .2),
                            child: Column(children: <Widget>[
                              Stack(children: [
                                Container(
                                  height: 430.0,
                                ),
                                Positioned(
                                    left: 10.0,
                                    right: 10.0,
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
                                            children: <Widget>[
                                              SizedBox(
                                                height: 70,
                                              ),
                                              Text(
                                                (employee == null ? "" : employee.employeeName),
                                                style: titleStyle,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                (employee == null ? "" : employee.employeeContactNumber),
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
                                                          (employee == null ? "" : employee.employeeRole),
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
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  MaterialButton(
                                                    minWidth: 20,
                                                    onPressed: () {
                                                     // FlutterLaunch.launchWathsApp(phone: "${employee.employeeContactNumber}", message: "Hello ${employee.employeeName}");
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Image.asset('images/whatsapp.png',height: 70,width: 70,)

                                                      ],
                                                    ),
                                                  ),
                                                  //SizedBox(width: 5.0),
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
                                                          color: Colors.blue,
                                                          size: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 15.0),
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
                                    left: 130.0,
                                    right: 130.0,
                                    top: 30.0,
                                    bottom: 260.0,
                                    child: (employee == null ? "" : employee.employeeImagePath) == null ? CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.grey[200],
                                    ) : CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                      NetworkImage((employee == null ? "" : employee.employeeImagePath)),
                                      backgroundColor: Colors.transparent,
                                    ),),
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
                                      '${getDate((employee == null ? 0 : employee.employeeDateOfBirth.seconds))}',
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
                                      (employee == null ? "" : employee.employeeGender),
                                      //'${employee.employeeGender}',
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
                                      '${getDate((employee == null ? 0 : employee.employeeJoinDate.seconds))}',
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
                                      'Coimbatore${(employee == null ? "" : employee.employeeLatitude)}',
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
                                children: _editUserProfile(widget.employee.role),
                              ),
                              onTap: () {
                                editUserRole(context);
                                },
                            ),
                            SizedBox(
                              height: 30.0,
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
        });
  }

  List _editUserProfile(String employeeRole){
    if(widget.employee.role == 'Manager') {
      return <Widget>[
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
                style: titleStyle),
          ],
        ),
        SizedBox(
          height: 50.0,
        ),
      ];
    }else{
      return <Widget>[];
    }
  }

  void editUserRole(BuildContext context) {
    int selected;

    void initState() {
      super.initState();
      selected = 0;
    }

    void onChanged(int v){
      setState(() {
        selected=v;
      });
    }

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
            Container(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                          children: <Widget>[
                      RadioButtonGroup(
                      labels: <String>[
                          "Accountant",
                          "Manager",
                          "Supervisor",
                          "Security",
                          "Store Manager",
                          "Site Engineer"
                          ],
                          onSelected: (String selectedRole) => widget.selectedRole = selectedRole
                  ),
                          ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);

                  final employeeDetails = EmployeeDetails(
                      role: widget.selectedRole);
                  widget.database.updateEmployeeDetails(
                      employeeDetails, widget.employeeID);

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
}
