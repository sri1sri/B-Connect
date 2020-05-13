import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/attendance_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/JCB_Entries/JCB_Single_Reading.dart';
import 'package:bhavani_connect/home_screens/JCB_Entries/daily_readings.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';
import 'dart:async';

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
  _F_AddReadingPagePageState createState() => _F_AddReadingPagePageState();
}

class _F_AddReadingPagePageState extends State<F_AddReadingPagePage> {
  final GlobalKey<FormState> _startFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _endFormKey = GlobalKey<FormState>();
  Timer timer;
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

//  final _startFormKey = GlobalKey<FormState>();
//  final _endFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

//  bool _validateAndSaveForm() {
//    final form = _startFormKey.currentState;
//    if (form.validate()) {
//      form.save();
//      return true;
//    }
//    return false;
//  }


  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150),
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
              rightActionBar: Icon(
                Icons.library_books,
                size: 40,
                color: Colors.black38,
              ),
              rightAction: () {
                GoToPage(
                    context,
                    ViewJCBReadingsPage(
                      database: widget.database,
                    ));
              },
              primaryText: "Hitachi",
              secondaryText: 'TN66V6571',
              tabBarWidget: null,
            ),
          ),
          body:  SingleChildScrollView(child: _buildContent()),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: SpringButton(
            SpringButtonType.OnlyScale,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green.withOpacity(0.4),
              ),
              height: 300,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.green.withOpacity(0.6),
                        child: Text("START",style: subTitleStyleLight,),
                      ),
                      padding: const EdgeInsets.all(2.0), // borde width
                      decoration: new BoxDecoration(
                        color: const Color(0xFFFFFFFF), // border color
                        shape: BoxShape.circle,
                      )
                  )

                ],
              ),
            ),

            onTapDown: (_) => startReadingDialogue(context),
            onLongPress: () => timer = Timer.periodic(
              const Duration(milliseconds: 200),
                  (_) => startReadingDialogue(context),
            ),
            onLongPressEnd: (_) {
              timer?.cancel();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: SpringButton(
            SpringButtonType.OnlyScale,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red.withOpacity(0.4),
              ),
              height: 300,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.red.withOpacity(0.6),
                        child: Text("STOP",style: subTitleStyleLight,),
                      ),
                      padding: const EdgeInsets.all(2.0), // borde width
                      decoration: new BoxDecoration(
                        color: const Color(0xFFFFFFFF), // border color
                        shape: BoxShape.circle,
                      )
                  )

                ],
              ),
            ),

            onTapDown: (_) => endReadingDialogue(context,),
            onLongPress: () => timer = Timer.periodic(
              const Duration(milliseconds: 100),
                  (_) => incrementCounter(),
            ),
            onLongPressEnd: (_) {
              timer?.cancel();
            },
          ),
        ),
      ],
    );
  }
}

void startReadingDialogue(BuildContext context,) {

  final _formKey = GlobalKey<FormState>();
  String _updatedGangName;

  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 250.0,
                  width: 400.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Enter Start Readings",style: highlightDescription,),
                                Form(
                                  key: _formKey,
                                  child:
                                  Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (value) => _updatedGangName = value,
                                        autocorrect: true,
                                        obscureText: false,
                                        keyboardType: TextInputType.text,
                                        keyboardAppearance: Brightness.light,
                                        autofocus: true,
                                        cursorColor: backgroundColor,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration:  InputDecoration(
                                          counterStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                          ),
                                          hintText: "ODO Reading",
                                          hintStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,),
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide:
                                            const BorderSide(color: Colors.transparent, width: 0.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          print(value);
                                          if (value.isEmpty) {
                                            return 'Please enter new gang name.';
                                          }
                                          return null;
                                        },
                                      ),

                                    ],
                                  ),
                                ),

                                Container(
                                  height: 55,
                                  width: 180,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
//                                      final updatedGangDetails  = GangDetails(gangName: _updatedGangName);
//                                      DBreference.updateGang(updatedGangDetails, gangDetails.gangID);
//
//                                      GoToPage(context, LandingPage());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Start",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  //fontFamily: mainFontFamily,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,decoration: TextDecoration.none),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(1.05, -1.05),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}
void endReadingDialogue(BuildContext context,) {

  final _formKey = GlobalKey<FormState>();
  String _updatedGangName;

  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 250.0,
                  width: 400.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Enter End Readings",style: highlightDescription,),
                                Form(
                                  key: _formKey,
                                  child:
                                  Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (value) => _updatedGangName = value,
                                        autocorrect: true,
                                        obscureText: false,
                                        keyboardType: TextInputType.text,
                                        keyboardAppearance: Brightness.light,
                                        autofocus: true,
                                        cursorColor: backgroundColor,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration:  InputDecoration(
                                          counterStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                          ),
                                          hintText: "ODO Reading",
                                          hintStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,),
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide:
                                            const BorderSide(color: Colors.transparent, width: 0.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          print(value);
                                          if (value.isEmpty) {
                                            return 'Please enter new gang name.';
                                          }
                                          return null;
                                        },
                                      ),

                                    ],
                                  ),
                                ),

                                Container(
                                  height: 55,
                                  width: 180,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
//                                      final updatedGangDetails  = GangDetails(gangName: _updatedGangName);
//                                      DBreference.updateGang(updatedGangDetails, gangDetails.gangID);
//
//                                      GoToPage(context, LandingPage());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Stop",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  //fontFamily: mainFontFamily,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,decoration: TextDecoration.none),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(1.05, -1.05),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}