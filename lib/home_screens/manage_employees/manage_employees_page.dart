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
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

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
          body: Container(
            color: Colors.white,
    child: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: editingController,
          decoration: InputDecoration(
              labelText: "Search Employee",
              hintText: "Employee",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)))),
        ),
      ),
            Expanded(
              child: StreamBuilder<List<EmployeesList>>(
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
                                  leading: (data == null ? "" : data.employeeImagePath) == null ? CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.grey[200],
                                  ) : CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                    NetworkImage(data.employeeImagePath),
                                    backgroundColor: Colors.transparent,
                                  ),

                                  title: Text('${data.employeeName}',style: subTitleStyle,),
                                  subtitle: Text(data.employeeRole, style: descriptionStyleDark,),
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
              ),
            ),
    ]
    ),
          ),
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
