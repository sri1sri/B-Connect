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
              secondaryText: 'Itachi Reading',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children:<Widget>[
        Column(
          children: <Widget>[
                  Stack(children: [
                    Container(
                      height: 235.0,
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
                            children: <Widget>[Text("05/Mar/2020")],
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
                                Padding(
                                  padding: const EdgeInsets.only(left:20.0,right: 20.0),
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
                                                      'Start Reading',
                                                      style: descriptionStyleDark,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      "11666.5",
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
                                                      'End Reading',
                                                      style: descriptionStyleDark,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      "11667.5	",
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
                                                    "11.30 am",
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
                                                    "4.30 pm",
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
                                                    "6 hrs",
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
                        )),
                  ]),

                ]
      ),
        GestureDetector(
          child:
            Text("Edit",style: subTitleStyle,),
       onTap: ()=> print("edit"),
        ),
    ]
    );

  }
}
