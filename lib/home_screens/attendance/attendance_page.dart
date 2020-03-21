import 'dart:io';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/attendance_model.dart';
import 'package:bhavani_connect/database_model/common_variables_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/attendance/upload_attandance_page.dart';
import 'package:bhavani_connect/home_screens/attendance/view_all_attendance_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatelessWidget {
  AttendancePage({@required this.database});
  Database database;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AttendancePage(database: database),
    );
  }
}

class F_AttendancePage extends StatefulWidget {
  F_AttendancePage({@required this.database});
  Database database;
  @override
  _F_AttendancePageState createState() => _F_AttendancePageState();
}

class _F_AttendancePageState extends State<F_AttendancePage> {
  File _inTimeImage;
  File _outTimeImage;
  bool inLocation;
  String _inUploadedTime = '';
  String _outUploadedTime = '';

  double _lattitude;
  double _longitude;

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
              rightActionBar: Container(
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                    child: Icon(
                      Icons.list,
                      color: backgroundColor,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllAttendancePage(
                                database: widget.database)),
                      );
                    }),
              ),
              primaryText: null,
              secondaryText: 'Attendance',
              tabBarWidget: null,
            ),
          ),
          body: SingleChildScrollView(child: _buildContent(context)),
        ),
      ),
    );
  }

  Widget _buildContent(context) {
    return StreamBuilder<Attendance>(
      stream: widget.database.readAttendance(),
      builder: (context, snapshot) {
        final attendance = snapshot.data;

        return StreamBuilder<CommonVaribles>(
          stream: widget.database.readCommonVariables(),
          builder: (context, commonVariablesSnapshot) {
            final commonVariables = commonVariablesSnapshot.data;

            _lattitude = commonVariables == null
                ? 0.00
                : commonVariables.bhavaniSkyTowersLocation.latitude;
            _longitude = commonVariables == null
                ? 0.00
                : commonVariables.bhavaniSkyTowersLocation.longitude;

            return Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Note: The Uploaded Attendance cannot be changed.",
                          style: descriptionStyle,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'In Time :',
                                style: titleStyle,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Text(
                                  '${attendance == null ? ' ' : getDateTime(attendance.inTime.seconds)}',
                                  style: subTitleStyle),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () =>
                                attendance == null ? _captureImage(0) : null,
                            child: attendance == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[300],
                                        ),
                                        child: Center(
                                          child: Text(
                                              'Tap here to \nupload image',
                                              style: subTitleStyle),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      attendance.inTimePic),
                                                  fit: BoxFit.fill))),
                                    ],
                                  )),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Out Time :',
                                style: titleStyle,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                  ' ${attendance == null ? ' ' : attendance.outTime == null ? ' ' : getDateTime(attendance.outTime.seconds)}',
                                  style: subTitleStyle),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () => attendance == null
                                ? null
                                : attendance.outTime == null
                                    ? _captureImage(1)
                                    : null,
                            child: attendance == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                                '  Tap here to \nupload image',
                                                style: subTitleStyle),
                                          )),
                                    ],
                                  )
                                : attendance.outTime == null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                    '  Tap here to \nupload image',
                                                    style: subTitleStyle),
                                              )),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          attendance
                                                              .outTimePic),
                                                      fit: BoxFit.fill))),
                                        ],
                                      )),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }



  Future<void> _captureImage(int type) async {
    await currentlocationfinder(_lattitude, _longitude);
    if (inLocation) {
      File uploadImage = await ImagePicker.pickImage(source: IMAGE_SOURCE);
      GoToPage(
          context,
          UploadAttendancePage(
              capturedImage: uploadImage,
              database: widget.database,
              attendanceType: type == 0 ? 0 : 1,
              uploadTime: DateTime.now()));

      setState(() {
        type == 0
            ? {
          _inTimeImage = uploadImage,
          _inUploadedTime = DateFormat("dd MMMM yyyy")
              .format(DateTime.now())
              .toString()
        }
            : {
          _outTimeImage = uploadImage,
          _outUploadedTime = DateTime.now().toString()
        };
        _inUploadedTime = DateTime.now().toString();
      });
    } else {
      PlatformExceptionAlertDialog(
        title: 'ERROR',
        exception: PlatformException(
            code: '',
            message:
            'You are not in site location. Please make sure you are in site location.'),
      ).show(context);
    }  }

  Future<bool> currentlocationfinder(double lattitude, double longitude) async {
    Geolocator()..forceAndroidLocationManager = true;
    await Geolocator().checkGeolocationPermissionStatus();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    double distanceInMeters = await Geolocator().distanceBetween(
        position.latitude, position.longitude, lattitude, longitude);
    double distance = 500.0;
    double lat = position.latitude;
    double lon = position.longitude;

    if (distanceInMeters.round() > distance.round()) {
      print(
          'not in location latitude: $lat and longitude: $lon, distance is ${distanceInMeters.round()}');
      setState(() {
        inLocation = false;
      });
    } else {
      print(
          'in location latitude: $lat and longitude: $lon, distance is ${distanceInMeters.round()}');
      setState(() {
        inLocation = true;
      });
    }
  }
}
