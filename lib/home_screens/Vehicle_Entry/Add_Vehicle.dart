import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddVehicle(),
    );
  }
}

class F_AddVehicle extends StatefulWidget {
  @override
  _F_AddVehicle createState() => _F_AddVehicle();
}

class _F_AddVehicle extends State<F_AddVehicle> {

  var category = [
    "Jcb/Hitachi",
    "Tractor",
    "Road Roller",
    "Cement Mixer",
    "Excavator",
    "BoreWell",
    "Pickup Truck",
    "GoodsTruck",
    "Fork Lift"
  ];
  List<String> F_image = [
    "images/jcb.png",
    "images/c1.png",
    "images/c2.png",
    "images/c3.png",
    "images/c4.png",
    "images/c5.png",
    "images/c6.png",
    "images/c7.png",
    "images/inventory.png"

  ];


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
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,color: subBackgroundColor,size: 40,),
                    onPressed: (){
                      Navigator.pop(context, true);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Add Vehicle",style: bigTitleStyle,),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: category.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 10
                ),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    child: new Card(
                      elevation: 10.0,
                      child: new Container(
                        alignment: Alignment.center,
                        margin: new EdgeInsets.only(
                            top: 5.0, bottom: 0.0, left: 0.0, right: 0.0),
                        child: new Column(
                          children: <Widget>[
                            Image.asset(
                              F_image[index],height: 70,
                            ),
                            SizedBox(height: 5,),
                            new Text(
                              category[index],
                              style: descriptionStyle,
                            ),

                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      newEntryDialogue(context);

                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
                                          hintText: "Seller Name",
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
                                          hintText: "Vehicle Unit",
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