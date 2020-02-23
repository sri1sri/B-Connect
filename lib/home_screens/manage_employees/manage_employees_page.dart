import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/firebase/firebase_common_variables.dart';
import 'package:bhavani_connect/home_screens/manage_employees/employee_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageEmployeesPage extends StatelessWidget {
  ManageEmployeesPage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ManageEmployeesPage(database: database,),
    );
  }
}

class F_ManageEmployeesPage extends StatefulWidget {
  F_ManageEmployeesPage({@required this.database});
  Database database;

  @override
  _F_ManageEmployeesPageState createState() => _F_ManageEmployeesPageState();
}

class _F_ManageEmployeesPageState extends State<F_ManageEmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(child:Text('Manage Employees',style: subTitleStyleLight,)),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),

            centerTitle: true,
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return _buildCards(context);
  }

  Widget getEditStatus (){
    if(USERID() == 'HuOG1oaJCHSebSOKVeN3MNIU0eT2'){
      return Text('Edit', style: subTitleStyle);
    }
    return Text('View', style: subTitleStyle);
  }

  Widget _buildCards(BuildContext context) {

    return StreamBuilder<List<EmployeesList>>(
      stream: widget.database.readEmployees(),
      builder: (context, snapshots) {
        return ListItemsBuilder<EmployeesList>(
          snapshot: snapshots,
          itemBuilder: (context, data) => Container(
              height: 100,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    InkWell(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/profile_image.jpg"),
                          backgroundColor: Colors.red,
                          radius: 30,
                        ),
                        title: Text('${data.employeeName}',style: subTitleStyle,),
                        subtitle: Text(data.employeeRole, style: descriptionStyle,),
                        trailing: getEditStatus(),
                      ),
                      onTap: (){
                        GoToPage(context, EmployeeProfilePage(database: widget.database, employeeID: data.employeeID,));
                        print('id${data.employeeID}');
                      },
                    ),
                  ],
                ),
              ),
            ),

        );
      }
    );
  }
}
