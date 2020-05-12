import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Site_Activities/add_Site_Activity.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/AddNewInvoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityDetailDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ActivityDetailDescription(),
    );
  }
}

class F_ActivityDetailDescription extends StatefulWidget {
  @override
  _F_ActivityDetailDescription createState() => _F_ActivityDetailDescription();
}

class _F_ActivityDetailDescription extends State<F_ActivityDetailDescription> {
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
            rightActionBar: Icon(Icons.border_color,size: 25,color: Colors.white,),
            rightAction: (){
              GoToPage(
                  context,
                  AddSiteActivity(
                  ));
            },
            primaryText: 'Activity Details',
            tabBarWidget: null,
          ),
        ),
        body:ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              topLeft: Radius.circular(50.0)),
          child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subtext("Date", "29/Oct/2020"),
                              subtext("Site", "Bhavani Vivan"),
                              subtext("Block", "2nd"),
                              subtext("Category", "Iron/Steels"),
                              subtext("Sub Category", "8Thread Tmt rods"),
                              subtext("Uom", "tons"),
                              subtext("Yesterday's Progress", "40"),
                              subtext("Total Progress", "100"),
                              Divider(
                                thickness: 1,
                                color: Colors.black54,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Remarks:",style: subTitleStyle ,),
                                    SizedBox(height: 5,),
                                    Text("Transfer from store to construction site",style: descriptionStyleDarkBlur1,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 550,),
                      ]
                  )
              )),
        )
    );
  }
}

Widget subtext(String _left, String _right) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
            '$_left :',
            style: subTitleStyle
        ),
        Text(
            '$_right',
            style: descriptionStyleDarkBlur1
        ),
      ],
    ),
  );
}

Widget totalsubtext(String _left, String _right) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
            '$_left :',
            style: titleStyle
        ),
        Text(
            '$_right',
            style: highlight
        ),
      ],
    ),
  );
}


