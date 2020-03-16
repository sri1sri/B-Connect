import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadAttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_UploadAttendancePage(),
    );
  }
}

class F_UploadAttendancePage extends StatefulWidget {
  @override
  _F_UploadAttandancePageState createState() => _F_UploadAttandancePageState();
}

class _F_UploadAttandancePageState extends State<F_UploadAttendancePage> {
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
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: Container(
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                    child: Icon(
                      Icons.list,
                      color: backgroundColor,
                      size: 30,
                    ),
                    onTap: () {}),
              ),
              rightAction: () {},
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