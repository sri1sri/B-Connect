import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeProfilePage extends StatelessWidget {
  EmployeeProfilePage({@required this.database, @required this.employeeID});
  Database database;
  String employeeID;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_EmployeeProfilePage(database: database, employeeID: employeeID,),

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
            title: Text(
              'Employee details',
              style: subTitleStyle,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
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
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("images/profile_image.jpg"),
                    backgroundColor: Colors.red,
                    radius: 50,
                  ),
                  Text('username is the ${employee.employeeName}',style: titleStyle,),
                  Text('role${employee.employeeRole}',style: subTitleStyle,),
                  Text('user project',style: subTitleStyle,),
                  Text('number${employee.employeeContactNumber}',style: subTitleStyle,),
                  Text('dob${employee.employeeDateOfBirth}',style: subTitleStyle,),
                  Text('gender${employee.employeeGender}',style: subTitleStyle,),
                  Text('join${employee.employeeJoinDate}',style: subTitleStyle,),
                  Text('location${employee.employeeLatitude}',style: subTitleStyle,),
                ],
              ),
              Column(children: <Widget>[
              ],),

              Column(
                children: <Widget>[
                  InkWell(
                    child: Text('edit user role'),
                    onTap: (){
                      print('editProfile');
                    },
                  )
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}

