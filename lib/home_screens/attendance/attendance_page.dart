import 'dart:io';

import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AttendancePage(),
    );
  }
}

class F_AttendancePage extends StatefulWidget {
  @override
  _F_AttendancePageState createState() => _F_AttendancePageState();
}

class _F_AttendancePageState extends State<F_AttendancePage> {
  File _inTimeImage;
  File _outTimeImage;
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
}

Widget offlineWidget(BuildContext context){

  return CustomOfflineWidget(
    onlineChild: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Scaffold(
        appBar:
        PreferredSize(
          preferredSize: Size.fromHeight(120),
          //preferredSize : Size(double.infinity, 100),
          child: CustomAppBar(
            leftActionBar: Container(
              child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
            ),
            leftAction: (){
              Navigator.pop(context,true);
            },
            rightActionBar: Container(
              //child: Icon(Icons.notifications, size: 40,),
            ),
            rightAction: (){
              print('right action bar is pressed in appbar');
            },
            primaryText: null,
            secondaryText: 'Attendance',
            tabBarWidget: null,
          ),
        ),
        body: _buildContent(context),
      ),
    ),
  );
  }

  Widget _buildContent(context){
    return Column(

      children: <Widget>[
        SizedBox(height: 20,),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment : MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('In Time :',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                GestureDetector(onTap:() => _captureImage(0),
                    child: _inTimeImage == null
                        ? Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(_inTimeImage),  // here add your image file path
                                fit: BoxFit.fill,
                              )
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment : MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('Out Time :',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                GestureDetector(onTap:() => _captureImage(1),
                  child: _outTimeImage == null
                      ? Row(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(_outTimeImage),  // here add your image file path
                            fit: BoxFit.fill,
                          )
                        ),
                      ),
                    ],
                  )
                ),


              ],
            ),
          ),
        ),
        SizedBox(height: 100,),
        ToDoButton(
          assetName: 'images/googe-logo.png',
          text: 'Update Attendance',
          textColor: Colors.white,
          backgroundColor: activeButtonBackgroundColor,
          onPressed: (){},
        ),
      ],
    );

  }

  Future<void> _captureImage(int type) async{
    File uploadImage = await ImagePicker.pickImage(source: IMAGE_SOURCE);
    setState(() {
      type == 0 ? _inTimeImage = uploadImage : _outTimeImage = uploadImage;
    });
  }
}
