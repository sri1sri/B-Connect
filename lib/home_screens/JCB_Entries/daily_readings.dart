import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';
import 'JCB_Single_Reading.dart';

class DailyReadingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DailyReadingsPage(),
    );
  }
}

class F_DailyReadingsPage extends StatefulWidget {
  @override
  _F_DailyReadingsPageState createState() => _F_DailyReadingsPageState();
}

class _F_DailyReadingsPageState extends State<F_DailyReadingsPage> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
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
          rightActionBar: Padding(
            padding: const EdgeInsets.only(top:15.0,),
            child: Container(
                child: FlatButton(
                  onPressed: () {
                    print('clearing notification');
                  },
                  child: Text(
                    "",
                    style: subTitleStyle,
                  ),
                )),
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: 'Test Page',
          secondaryText: 'Daily Readings',
          tabBarWidget: null,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10,),
              _recentActivities("Itachi Reading","05/Mar/2020"),
              _recentActivities("Itachi Reading","07/Mar/2020"),
              _recentActivities("Itachi Reading","03/Mar/2020"),
              SizedBox(height: 20,),
              Text("This Feature is not yet implemented.",style: subTitleStyle,)
            ],
          ),
        ),
      ),

    );
  }
  _recentActivities(String messageTitle,String dateTime)
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
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage("images/jcb.png"),
                              radius: 40,
                            ),
                          ],
                        ),
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
        GoToPage(
            context,
            ViewJCBReadingsPage());
      },
    );

  }
}


