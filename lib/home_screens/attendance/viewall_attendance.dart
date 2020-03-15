import 'dart:io';

import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ViewAllAttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ViewAllAttendancePage(),
    );
  }
}

class F_ViewAllAttendancePage extends StatefulWidget {
  @override
  _F_ViewAllAttendancePageState createState() => _F_ViewAllAttendancePageState();
}

class _F_ViewAllAttendancePageState extends State<F_ViewAllAttendancePage> {
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
              secondaryText: 'Daily Attendance',
              tabBarWidget: null,
            ),
          ),
          body:_buildContent(context),
        ),
      ),
    );

  }
  Widget _buildContent(context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right:20.0,left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ItemsCard("9.30 am","5.30 pm","05-03-2020"),
                ItemsCard("9.40 am","6.00 pm","05-03-2020"),
                ItemsCard("10.30 am","5.00 pm","04-03-2020"),
                ItemsCard("10.00 am","5.00 pm","03-03-2020"),
                ItemsCard("9.10 am","6.00 pm","02-03-2020"),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ItemsCard(String TimeIn,String TimeOut,String TimeDate)
  {
    return Column(children: <Widget>[
      Stack(children: [
        Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
            left: 50.0,
            right: 50.0,
            top: 5.0,
            bottom: 30.0,
            child: Container(
              padding: EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 3.0, bottom: 0.0),
              height: 100.0,
              width: 200.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white.withOpacity(0.8)),
              child: Column(
                children: <Widget>[
                  Text(TimeDate)
                ],
              ),)),
        Positioned(
            left: 5.0,
            right: 5.0,
            top: 30.0,
            bottom: 15.0,
            child: Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
                height: 15.0,
                width: 180.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:10.0,left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Text('In Time',
                                    style: subTitleStyle,
                                  ),
                                  SizedBox(width: 20,),
                                  Text(TimeIn,
                                    style: descriptionStyleDark,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                         ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text('Out Time',
                                        style: subTitleStyle,
                                      ),
                                      SizedBox(width: 20,),
                                      Text(TimeOut,
                                        style: descriptionStyleDark,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            )),
      ]),
    ]);
  }
}
