import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget (BuildContext context){
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
    var features = ["Approvals","Item entry","Store","Inventory","More","Attendance","Employees"];
    List<IconData> F_icons=[Icons.touch_app,Icons.note_add,Icons.store,Icons.dashboard,Icons.people,Icons.pan_tool];
    var myGridView = new GridView.builder(

      itemCount: features.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
              child: new Text(features[index]),

            ),
          ),
          onTap: () {
            switch(features[index]) {
              case 'Employees': {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    fullscreenDialog: true,
                    builder: (context) => ManageEmployeesPage(database: widget.database,),
                    //hi da macha
                  ),
                );
              }
              break;
              default: {}
              break;
            }
//            showDialog(
//                barrierDismissible: false,
//                context: context,
//                child: new CupertinoAlertDialog(
//                  title: new Column(
//                    children: <Widget>[
//                      new Text("GridView"),
//
//                    ],
//                  ),
//                  content: new Text( features[index]),
//                  actions: <Widget>[
//                    new FlatButton(
//                        onPressed: () {
//                          Navigator.of(context).pop();
//                        },
//                        child: new Text("OK"))
//                  ],
//                ));
          },
        );
      },
    );
    return Scaffold(
        backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello!",style: subTitleStyle,),
            Text("Vasanthakumar V G",style: descriptionStyle,),
          ],
        ),
        actions: <Widget>[

          InkWell(
              child: Icon(Icons.notifications,color: backgroundColor,),
          onTap: () => _confirmSignOut(context),
          )
        ],
      ),
      body: myGridView,
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



