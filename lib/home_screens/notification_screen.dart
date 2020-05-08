import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
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


//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
//  List<Message> _messages;
//
//  _getToken() {
//    _firebaseMessaging.getToken().then((deviceToken) {
//      print( "Device Token: $deviceToken" );
//    } );
//  }
//
//  @override
//  void initState() {
//    super.initState( );
//    _messages = List<Message>();
//    _getToken();
//    _cofigureFirebaseListeners();
//  }
//
//  _cofigureFirebaseListeners(){
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMessage: $message");
//        _setMessage(message);
//      },
//      //onBackgroundMessage: myBackgroundMessageHandler,
//      onLaunch: (Map<String, dynamic> message) async {
//        print("onLaunch: $message");
//        _setMessage(message);
//        //_navigateToItemDetail(message);
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
//        _setMessage(message);
//        // _navigateToItemDetail(message);
//      },
//    );
//  }
//
//  _setMessage(Map<String, dynamic> message){
//    final notification = message['notification'];
//    final data = message['data'];
//    final String title = notification['title'];
//    final String body = notification['body'];
//    final String mMessage =data['BConnect'];
//    setState(() {
//      Message m = Message(title,body,mMessage);
//      _messages.add(m);
//    });
//
//  }



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
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(70),
        child: CustomAppBarDark(
          leftActionBar: Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),
          leftAction: (){
            Navigator.pop(context,true);
          },
          //rightActionBar: Icon(Icons.clear,size: 25,color: Colors.white),
          rightAction: (){
            print('right action bar is pressed in appbar');
          },
          primaryText: 'Notifications',
          tabBarWidget: null,
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0),
            topLeft: Radius.circular(50.0)),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  _recentActivities("Approval For Vehicle", "JCB came to digg the ground",1),
                  _recentActivities("Approval For Goods", "Items Added to the goods entry",2),
                  _recentActivities("Approval For Store", "Items requested in store, need an approval",1),
                  _recentActivities("Approval For Goods", "Goods created by the security need the approval",2),
                  SizedBox(height: 700,)

                ],
              )
          ),
        ),
      ),

    );
  }
  _recentActivities(String messageTitle, String messageContent,int status)
  {
    return Container(
      height: 100,

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 220,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(messageTitle,style: descriptionStyleDark1,),
                    SizedBox(height: 5,),
                    Text(messageContent,style: descriptionStyleDarkBlur3,),
                  ]
              ),
            ),
            //(employee == null ? "Not updated" : employee.username)
            status == 1 ? Row(
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green.withOpacity(0.8),
                    ),
                    height: 30,
                    width: 70,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Accept",style: descriptionStyleLite1,),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.withOpacity(0.8),
                    ),
                    height: 30,
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Decline",style: descriptionStyleLite1,),
                      ],
                    ),
                  ),
                ),
              ],
            ) : GestureDetector(
              onTap: (){

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: backgroundColor.withOpacity(0.8),
                ),
                height: 30,
                width: 70,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Status",style: descriptionStyleLite1,),
                  ],
                ),
              ),
            ),
          ],

        ),
      ),
    );

  }
}

//class Message {
//  String title;
//  String body;
//  String message;
//  Message(title,body,message){
//    this.title=title;
//    this.body=body;
//    this.message=message;
//  }
//}
