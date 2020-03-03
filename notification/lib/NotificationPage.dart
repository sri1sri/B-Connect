import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingDemo extends StatefulWidget {
  FirebaseMessagingDemo() : super();
  final String title ='Firebase Messaging Demo';
  @override
  State<StatefulWidget> createState() => FirebaseMessagingDemoState();
}

class FirebaseMessagingDemoState extends State<FirebaseMessagingDemo> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging( );
List<Message>_messages;
  _getToken() {
    _firebaseMessaging.getToken( ).then( (deviceToken) {
      print( "Device Token: $deviceToken" );
    } );
  }

  _configurationFirebaseListeners(){
  _firebaseMessaging.configure(
  onMessage: (Map<String,dynamic>message) async{
    print('onMessage: $message');
    _setMessage(message);
  },
      onLaunch: (Map<String,dynamic>message) async{
    print('onLaunch: $message');
    _setMessage(message);
  },
  onResume: (Map<String,dynamic>message) async{
    print('onResume: $message');
    _setMessage(message);
  }
  );
  }

  _setMessage(Map<String,dynamic>message){
    final notification = message['notification'];
    final data = message["data"];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];
    setState(() {
      Message m = Message(title, body, mMessage);
      _messages.add(m);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messages = List<Message>();
    _getToken();
    _configurationFirebaseListeners();
  }


    @override
    Widget build(BuildContext context) {

      // TODO: implement build
      return Scaffold(

        appBar: AppBar(title: Text(widget.title),),
        body: ListView.builder(itemCount: null == _messages ? 0 : _messages.length,
        itemBuilder: (context,index){
          return Card(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                _messages[index].message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },)
      );
    }

}

class Message{
  String title;
  String body;
  String message;
  Message(title,body,message){
    this.title=title;
    this.body=body;
    this.message=message;

  }
}