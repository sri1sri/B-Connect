import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/Add_Vehicle.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              color: Colors.grey.withOpacity(0.2),
              height: MediaQuery.of(context).size.height/1.54,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    _recentActivities("images/jcb.png","JCB","TN66V6571"),
                    _recentActivities("images/c1.png","Tractor","TN73BS8121"),
                    _recentActivities("images/c2.png","Road Roller","AP38JD3322"),
                    _recentActivities("images/c3.png","Cement Mixer","AP37GG6371"),
                   _recentActivities("images/c4.png","Excavtor","TN66V6571"),
                    _recentActivities("images/c7.png","Goods Truck","AP38JD3322"),
                   _recentActivities("images/c5.png","BoreWell","TN73BS8121"),
                   _recentActivities("images/c6.png","Pickup Truck","AP38JD3322"),
                    _recentActivities("images/inventory.png","Fork Lift","TN66V6571"),

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

  _recentActivities(String imgPath,String messageTitle,String dateTime,)
  {
    return GestureDetector(
      child: Container(

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[
                SizedBox(height: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(imgPath,height: 80,width: 80,),
                          Column(
                              children: <Widget>[

                                Text(messageTitle,style: descriptionStyle,),
                                SizedBox(height: 10,),
                                Text(dateTime,style: descriptionStyleDark,),
                                SizedBox(height: 10,),
                                Text("Tap to view details",style: descriptionStyleDarkBlur,),
                                SizedBox(height: 10,),
                              ]
                          ),
                        ]
                    ),
                  ],
                ),

                SizedBox(height: 10,),
              ],

            ),
          ),
        ),
      ),
      onTap: (){
//        GoToPage(
//            context,
//            AddReadingPage());
      },
    );
  }
}