import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/attendance_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewAllAttendancePage extends StatelessWidget {
  ViewAllAttendancePage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ViewAllAttendancePage(database: database,),
    );
  }
}

class F_ViewAllAttendancePage extends StatefulWidget {
  F_ViewAllAttendancePage({@required this.database});
  Database database;
  @override
  _F_ViewAllAttendancePageState createState() =>
      _F_ViewAllAttendancePageState();
}

class _F_ViewAllAttendancePageState extends State<F_ViewAllAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.black38,
                ),
              ),
              leftAction: () {
                Navigator.pop(context, true);
              },
              rightActionBar: Container(),
              rightAction: () {
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Daily Attendance',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return StreamBuilder<List<Attendance>>(
      stream: widget.database.readAllAttendance(),
      builder: (context, snapshots) {
        return ListItemsBuilder<Attendance>(
          snapshot: snapshots,
          itemBuilder: (context, data) =>
              Column(children: <Widget>[
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
                      children: <Widget>[Text(data.attendanceID)],
                    ),
                  )),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(data.inTimePic),
                                                  fit: BoxFit.fill))
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'In Time',
                                              style: subTitleStyle,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              getTime(data.inTime.seconds),
                                              style: descriptionStyleDark,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(data.outTimePic),
                                                  fit: BoxFit.fill))
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'Out Time',
                                              style: subTitleStyle,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              getTime(data.outTime.seconds),
                                              style: descriptionStyleDark,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
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
          ]),
        );
      },
    );
  }
}
