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

class AddReadingPage extends StatelessWidget {
  AddReadingPage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddReadingPagePage(),
    );
  }
}

class F_AddReadingPagePage extends StatefulWidget {
  F_AddReadingPagePage({@required this.database});
  Database database;
  @override
  _F_AddReadingPagePageState createState() =>
      _F_AddReadingPagePageState();
}

class _F_AddReadingPagePageState extends State<F_AddReadingPagePage> {
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
              secondaryText: 'Add Itachi Reading',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(),
    bottomNavigationBar: BottomAppBar(
        child:FlatButton.icon(
        color: activeButtonTextColor,
//        onPressed: _startUpload,
        icon: Icon(
          Icons.cloud_upload,
          size: 30,
          color: backgroundColor,
        ),
        label: Text('Upload', style: titleStyle))),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Card(
        child: Column(
          children: <Widget>[
            Column(
                  children: <Widget>[

                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Text ("From",style: subTitleStyle),
                          SizedBox(width: 10,),
                          Text ("To",style: subTitleStyle),
                          SizedBox(width: 10,),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: new TextField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10)
                                  )
                              ),
                            ),
                          ),
                          new Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: new TextField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),


                  ]
              ),
            SizedBox(
              height: 20,),
            Text("This Feature is not yet implemented.",style: subTitleStyle,),
          ],
        ),
    );

  }
}
