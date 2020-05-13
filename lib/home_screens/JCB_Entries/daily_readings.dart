import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/JCB_Entries/Add_Readings.dart';
import 'package:vector_math/vector_math.dart' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';
import 'JCB_Single_Reading.dart';

class DailyReadingsPage extends StatelessWidget {
  DailyReadingsPage({@required this.database});
  Database database;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DailyReadingsPage(),
    );
  }
}

class F_DailyReadingsPage extends StatefulWidget {
  F_DailyReadingsPage({@required this.database});
  Database database;
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
          primaryText: null,
          secondaryText: 'Vehicle Entries',
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
              _recentActivities("JCB","TN66V6571"),
              _recentActivities("Hitachi","TN73BS8121"),
              _recentActivities("Hitachi","AP38JD3322"),
              _recentActivities("JCB","AP37GG6371"),

              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          newEntryDialogue(context);
          // Add your onPressed code here!
//          GoToPage(
//              context,
//              AddReadingPage(
//                database: widget.database,
//              ));
        },
        child: Icon(Icons.add),
        backgroundColor: backgroundColor,
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
                        Image.asset("images/jcb.png",height: 80,width: 80,),
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
            AddReadingPage());
      },
    );

  }
}



void newEntryDialogue(BuildContext context,) {

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
                  height: 330.0,
                  width: 400.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 330,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Enter Vehicle Details",style: titleStyle,),
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
                                              hintText: "Vehicle Name",
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
                                              hintText: "Vehicle Number",
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
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Create",
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