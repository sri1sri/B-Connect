import 'dart:io';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  bool inLocation;
  String _inUploadedTime = '';
  String _outUploadedTime = '';
  @override
  Widget build(BuildContext context) {
    currentlocationfinder();
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
          child: CustomAppBar(
            leftActionBar: Container(
              child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
            ),
            leftAction: (){
              Navigator.pop(context,true);
            },
            rightActionBar: Container(
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
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      child: Text('$_inUploadedTime',
                        style: subTitleStyle
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
                            color: Colors.grey[300],
                          ),
                          child: Center(
                            child: Text('  Tap here to \nupload image',
                            style: subTitleStyle
                            ),
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
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(width:10,),
                    Container(
                      child: Text(' $_outUploadedTime',
                        style: subTitleStyle
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
                          color: Colors.grey[300],
                        ),
                        child:Center(
                          child: Text('  Tap here to \nupload image',
                            style: subTitleStyle
                          ),
                        )
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
                SizedBox(height: 80,),
                ToDoButton(
                  assetName: '',
                  text: 'Update Attendance',
                  textColor: Colors.white,
                  backgroundColor: activeButtonBackgroundColor,
                  onPressed: (){},
                ),

              ],
            ),
          ),
        ),

      ],
    );

  }

  Future<void> _captureImage(int type) async{
  if(inLocation){
    File uploadImage = await ImagePicker.pickImage(source: IMAGE_SOURCE);
    setState(() {
      type == 0 ? {_inTimeImage = uploadImage, _inUploadedTime = DateFormat("dd MMMM yyyy").format(DateTime.now()).toString()} : {_outTimeImage = uploadImage, _outUploadedTime = DateTime.now().toString()};
      _inUploadedTime = DateTime.now().toString();
    });
  }else{
    PlatformExceptionAlertDialog(
      title: 'ERROR',
      exception: PlatformException(code: '', message: 'You are not in site location. Please make sure you are in site location.'),
    ).show(context);
  }
  }

    Future<bool>currentlocationfinder() async{

      Geolocator()..forceAndroidLocationManager = true;
    await Geolocator().checkGeolocationPermissionStatus();
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    double distanceInMeters = await Geolocator().distanceBetween(position.latitude, position.longitude, 37.785834, -122.406417);
    double distance = 500.0;
    double lat = position.latitude;
    double lon = position.longitude;

    if(distanceInMeters>distance){
      print('not in location latitude: $lat and longitude: $lon, distance is $distanceInMeters');
      setState(() {
        inLocation = false;
      });
    }
    else{
      print('in location latitude: $lat and longitude: $lon, distance is $distanceInMeters');
      setState(() {
        inLocation = true;
      });
    }
  }
}
