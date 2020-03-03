import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_NotificationPage(),
    );
  }
}

class F_NotificationPage extends StatefulWidget {
  @override
  _F_NotificationPageState createState() => _F_NotificationPageState();
}

class _F_NotificationPageState extends State<F_NotificationPage> {
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
          rightActionBar: Padding(
            padding: const EdgeInsets.only(top:15.0,),
            child: Container(
                child: FlatButton(
                  onPressed: () {
                    print('clearing notification');
                  },
                  child: Text(
                    "Clear",
                    style: subTitleStyle,
                  ),
                  //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                )),
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Notifications',
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
              _Notificationcard("Aproval Needed", "Manager approved the request"),
              _Notificationcard("Goods Delivered", "Goods collected by security"),
              _Notificationcard("Items Order", "100 tons of steels ordered"),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),

    );
  }

  _Notificationcard(String messageTitle, String messageContent,)
  {
    return Container(

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
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      children: <Widget>[

                        Text(messageTitle,style: descriptionStyle,),
                        SizedBox(height: 10,),
                        Text(messageContent,style: descriptionStyleDark,),
                        SizedBox(height: 10,),
                      ]
                  ),
                ],
              ),

              SizedBox(height: 20,),
            ],



          ),
        ),
      ),
    );

  }

}
