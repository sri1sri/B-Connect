import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/AddNewInvoice.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/detail_description.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/Vehicle_Reading_Details.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/Add_Vehicle.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ShowAllInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ShowAllInvoice(),
    );
  }
}

class F_ShowAllInvoice extends StatefulWidget {
  @override
  _F_ShowAllInvoice createState() => _F_ShowAllInvoice();
}

class _F_ShowAllInvoice extends State<F_ShowAllInvoice> {
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
                    child: Text("Stock Register",style: bigTitleStyle,),
                  ),
                  CalendarTimeline(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020, 2, 15),
                    lastDate: DateTime(2040, 11, 20),
                    onDateSelected: (date) => print(date),
                    leftMargin: 60,
                    monthColor: subBackgroundColor,
                    dayColor: Colors.teal[200],
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: backgroundColor,
                    dotsColor: Colors.white70,
                    //selectableDayPredicate: (date) => date.day != 23,
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.53,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    _ItemsCard("Vasanth Plastics","23","nos","22/Mar/2020", "PVC Insulation Tapes","₹ 22,231.00"),
                    _ItemsCard("Sri Cements","300","kgs","13/Apr/2020", "Super strong Cements","₹ 50,431.00"),
                    _ItemsCard("Vamsi Steels","45","tons","08/Apr/2020", "8 layer TMT Rods","₹ 32,654.00"),


                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          GoToPage(
              context,
              AddInvoice(
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: backgroundColor,
      ),
    );
  }

  _ItemsCard(String CompanyName,String Quantity,String Measure,String TimeDate, String Description,String Price) {
    return GestureDetector(
      onTap: ()
      {
        GoToPage(
            context,
            DetailDescription(
            ));
      },
      child: Column(children: <Widget>[
        Stack(children: [
          Container(
            height: 280.0,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
              left: 50.0,
              right: 50.0,
              top: 5.0,
              bottom: 70.0,
              child: Container(
                padding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 3.0, bottom: 0.0),
                height: 120.0,
                width: 200.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Text(TimeDate,style: descriptionStyleDark,)],
                ),
              )),
          Positioned(
              left: 5.0,
              right: 5.0,
              top: 35.0,
              bottom: 15.0,
              child: Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
                  height: 145.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(children: <Widget>[
                              Text(
                                "Company Name",
                                style: descriptionStyle,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                CompanyName,
                                style: descriptionStyleDark,
                              ),

                            ]),
                            Column(children: <Widget>[
                              Text(
                                "Quantity",
                                style: descriptionStyle,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$Quantity $Measure",
                                style: descriptionStyleDark,
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                            Divider(
                            color: Colors.black.withOpacity(0.5),
                            ),
                            SizedBox(height: 2,),
                            Column(
                              children: <Widget>[
                                Text("Total Price",style: descriptionStyle,),
                                SizedBox(height: 5,),
                                Text(Price,style: highlightDescription,),
                              ],
                            ),
                            SizedBox(height: 2,),
                        Divider(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Description",
                              style: descriptionStyle,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              Description,
                              textAlign: TextAlign.center,
                              style: descriptionStyleDark,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ]))),
        ]),
      ]),
    );
  }
}