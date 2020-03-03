import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AttendancePage(),
    );
  }
}

class F_AttendancePage extends StatefulWidget {
  @override
  _F_AttendancePageState createState() => _F_AttendancePageState();
}

class _F_AttendancePageState extends State<F_AttendancePage> {

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
}

Widget offlineWidget(BuildContext context){

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
            secondaryText: 'Attendance',
            tabBarWidget: null,
          ),
        ),
        body: _buildContent(context),
      ),
    ),
  );
  }

  Widget _buildContent(context){

  }
}
