import 'dart:ffi';

import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/attendance_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_goods_entry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Add_Readings.dart';

class ViewJCBReadingsPage extends StatelessWidget {
  ViewJCBReadingsPage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ViewJCBReadingsPage(),
    );
  }
}

class F_ViewJCBReadingsPage extends StatefulWidget {
  F_ViewJCBReadingsPage({@required this.database});
  Database database;
  @override
  _F_ViewJCBReadingsPageState createState() =>
      _F_ViewJCBReadingsPageState();
}

class _F_ViewJCBReadingsPageState extends State<F_ViewJCBReadingsPage> {



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
            preferredSize: Size.fromHeight(150),
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
              primaryText: "Hitachi",
              secondaryText: 'TN66V6571',
              tabBarWidget: null,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildContent("05/Mar/2020",43543.43,43873.4,292.3,"11.30 am","5.00 pm","6 hrs"),
                _buildContent("06/Mar/2020",43543.43,43873.4,292.3,"11.00 am","5.00 pm","6 hrs"),
                _buildContent("07/Mar/2020",43543.43,43873.4,292.3,"11.30 am","5.00 pm","6 hrs"),
                _buildContent("08/Mar/2020",43543.43,43873.4,292.3,"11.30 am","5.00 pm","6 hrs"),
                _buildContent("09/Mar/2020",43543.43,43873.4,292.3,"11.30 am","5.00 pm","6 hrs"),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(String date,double startRead,double endRead,double totalRead,String startTime,String endTime,String totalTime) {
    return ExpansionTile(
      title: Text(date,style: subTitleStyle,),
      children: [
        Column(
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
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
                    padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:0.0,right: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'Start',
                                              style: descriptionStyleDark,
                                            ),
                                            Text(
                                              'Reading',
                                              style: descriptionStyleDark,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "$startRead",
                                              style: subTitleStyle,
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'End',
                                              style: descriptionStyleDark,
                                            ),
                                            Text(
                                              'Reading',
                                              style: descriptionStyleDark,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "$endRead",
                                              style: subTitleStyle,
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'Total',
                                              style: descriptionStyleDark,
                                            ),
                                            Text(
                                              'Reading',
                                              style: descriptionStyleDark,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "$totalRead",
                                              style: subTitleStyle,
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
                              )
                            ],
                          ),
                        ),
                        new Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'From',
                                            style: descriptionStyleDark,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            startTime,
                                            style: subTitleStyle,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'To',
                                            style: descriptionStyleDark,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            endTime,
                                            style: subTitleStyle,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Total',
                                            style: descriptionStyleDark,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            totalTime,
                                            style: subTitleStyle,
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
                ),
              ),
//        GestureDetector(
//          child:
//            Text("Edit",style: subTitleStyle,),
//       onTap: ()=> print("edit"),
//        ),
            ]
        ),
      ],
    );

  }
}
