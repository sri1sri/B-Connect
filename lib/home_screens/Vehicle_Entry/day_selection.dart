import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/Vehicle_Reading_Details.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/Add_Vehicle.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Vehicle_Count_Details.dart';

class DaySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DaySelection(),
    );
  }
}

class F_DaySelection extends StatefulWidget {
  @override
  _F_DaySelection createState() => _F_DaySelection();
}

class _F_DaySelection extends State<F_DaySelection> {
  int _n = 0;
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

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,color: subBackgroundColor,size: 40,),
                    onPressed: (){
                      Navigator.pop(context, true);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Vehicle Entries",style: bigTitleStyle,),
                  ),
                  CalendarTimeline(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020, 2, 15),
                    lastDate: DateTime(2040, 11, 20),
                    onDateSelected: (date) => print(date),
                    leftMargin: 60,
                    monthColor: subBackgroundColor,
                    dayColor: Colors.teal[200],
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: backgroundColor,
                    dotsColor: Colors.white70,
                    //selectableDayPredicate: (date) => date.day != 23,
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.53,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    _recentActivities("images/jcb.png","JCB","TN66V6571","Approved by Manager",AddVehicleDetails()),
                    _recentActivities("images/c1.png","Tractor","TN73BS8121","Approved by Manager",AddVehicleCountDetails()),
                    _recentActivities("images/c9.png","Road Roller","AP38JD3322","Approved by Manager",AddVehicleDetails()),
                    _recentActivities("images/c3.png","Cement Mixer","AP37GG6371","Approved by Manager",AddVehicleCountDetails()),
                   _recentActivities("images/c4.png","Excavtor","TN66V6571","Approved by Manager",AddVehicleDetails()),
                    _recentActivities("images/c7.png","Goods Truck","AP38JD3322","Approved by Manager",AddVehicleCountDetails()),
                   _recentActivities("images/c5.png","BoreWell","TN73BS8121","Approved by Manager",AddVehicleDetails()),
                   _recentActivities("images/c6.png","Pickup Truck","AP38JD3322","Approved by Manager",AddVehicleCountDetails()),
                    _recentActivities("images/inventory.png","Fork Lift","TN66V6571","Approved by Manager",AddVehicleDetails()),

                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          GoToPage(
              context,
              AddVehicle(
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: backgroundColor,
      ),
    );
  }

  _recentActivities(String imgPath,String messageTitle,String dateTime,String approval,Widget path)
  {
    return GestureDetector(
      child: Container(

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          elevation: 2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 15,),
                          Image.asset(imgPath,height: 100,width: 100,),
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start ,
                              children: <Widget>[

                                Text(messageTitle,style: titleStyle,),
                                SizedBox(height: 10,),
                                Text(dateTime,style: descriptionStyleDark,),
                                SizedBox(height: 10,),
                                Text(approval,style: descriptionStyleDarkBlur1,)
                              ]
                          ),
                        ]
                    ),
                  ],
                ),

                SizedBox(height: 30,),
              ],

            ),
          ),
        ),
      ),
      onTap: (){
        GoToPage(
            context,
            path);
      },
    );
  }
}