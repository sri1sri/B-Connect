import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<Message> _messages;

  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print( "Device Token: $deviceToken" );
    } );
  }

  @override
  void initState() {
    super.initState( );
    _messages = List<Message>();
    _getToken();
    _cofigureFirebaseListeners();
  }

  _cofigureFirebaseListeners(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _setMessage(message);
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _setMessage(message);
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _setMessage(message);
        // _navigateToItemDetail(message);
      },
    );
  }

  _setMessage(Map<String, dynamic> message){
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage =data['BConnect'];
    setState(() {
      Message m = Message(title,body,mMessage);
      _messages.add(m);
    });

  }



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
        preferredSize: Size.fromHeight(140),
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
      body: ListView.builder(
        itemCount: null == _messages ? 0 : _messages.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(10.0),
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
                        Column(
                            children: <Widget>[

                              Text(_messages[index].title == null ? 'this is sample message' : _messages[index].title,style: descriptionStyle,),
                              SizedBox(height: 10,),
                              Text(_messages[index].message == null ? 'this is sample message' : _messages[index].message,style: descriptionStyleDark,),
                              SizedBox(height: 10,),
                              Text(_messages[index].body == null ? 'this is sample message' : _messages[index].body,style: descriptionStyleDarkBlur,),
                              SizedBox(height: 10,),
                            ]
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),
                  ],

                ),
              ),
            ),
          );
        },

      ),

    );
  }
  _recentActivities(String messageTitle, String messageContent,String dateTime)
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
              SizedBox(height: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      children: <Widget>[

                        Text(messageTitle,style: descriptionStyle,),
                        SizedBox(height: 10,),
                        Text(messageContent,style: descriptionStyleDark,),
                        SizedBox(height: 10,),
                        Text(dateTime,style: descriptionStyleDarkBlur,),
                        SizedBox(height: 10,),
                      ]
                  ),
                ],
              ),

              SizedBox(height: 10,),
            ],

          ),
        ),
      ),
    );

  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title,body,message){
    this.title=title;
    this.body=body;
    this.message=message;
  }
}
