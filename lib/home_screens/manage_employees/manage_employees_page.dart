import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/employee_list_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/firebase/firebase_common_variables.dart';
import 'package:bhavani_connect/home_screens/manage_employees/employee_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageEmployeesPage extends StatelessWidget {
  ManageEmployeesPage({@required this.database, @required this.employee});
  Database database;
EmployeeDetails employee;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ManageEmployeesPage(database: database, employee: employee),
    );
  }
}

class F_ManageEmployeesPage extends StatefulWidget {
  F_ManageEmployeesPage({@required this.database, @required this.employee});
  Database database;
  EmployeeDetails employee;

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
          appBar:

          PreferredSize(
            preferredSize: Size.fromHeight(120),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: Container(
                //child: Icon(Icons.notifications, size: 40,),
              ),
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Manage Employees',
              tabBarWidget: null,
            ),
          ),

//          new AppBar(
//            backgroundColor: Color(0xFF1F4B6E),
//            title: Center(child:Text('Manage Employees',style: subTitleStyleLight,)),
//            leading: IconButton(icon:Icon(Icons.arrow_back),
//              onPressed:() => Navigator.pop(context, false),
//            ),
//
//            centerTitle: true,
//            actions: <Widget>[
//              FlatButton(
//                child: Text('',
//                  style: TextStyle(
//                    fontSize: 18,
//                    color: Colors.white,
//                  ),
//                ),
//                onPressed: ()=> print(''),
//              )
//            ],
//          ),
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
                        GoToPage(context, EmployeeProfilePage(database: widget.database, employeeID: data.employeeID,employee: widget.employee,));
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
