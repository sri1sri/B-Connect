import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:spring_button/spring_button.dart';
import 'package:vector_math/vector_math.dart' as math;

class AddVehicleCountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddVehicleCountDetails(),
    );
  }
}

class F_AddVehicleCountDetails extends StatefulWidget {
  @override
  _F_AddVehicleCountDetails createState() => _F_AddVehicleCountDetails();
}

class _F_AddVehicleCountDetails extends State<F_AddVehicleCountDetails> {
  final List time = [
    DateTime.now().toIso8601String(),
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
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
          rightActionBar: null,
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Vehicle Details',
          tabBarWidget: null,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),

//              Container(
//                height: 500,
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: ListView.separated(
//                    itemCount: 1,
//                    itemBuilder: (context, index) {
//
//                     return Container(
//                        child: Column(
//                          children: [
//                            Text("1 $time\n"),
//                          ],
//                        ),
//                      );
////                      return ListTile(
////
////                        title: Text("$time"),
////                      );
//                    },
//
//                    separatorBuilder: (context, index){
//
//                      return Divider();
//                    },
//                  ),
//                ),
//              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Trip Records",style: titleStyle,),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                      height: 35,
                      width: 80,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ADD",style: subTitleStyleLight1,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.4),
                ),
                //height: 150,
                width: MediaQuery.of(context).size.width,

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Round",style: subTitleStyle,),
                          SizedBox(width: 100,),
                          Text("Entry Time",style: subTitleStyle,),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            timeCard(context,1,"10.32am"),
                            timeCard(context,2,"12.04pm"),
                            timeCard(context,3,"02.20pm"),
                            timeCard(context,4,"05.45am"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text("Status",style: titleStyle,),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.4),
                ),
                //height: 150,
                width: MediaQuery.of(context).size.width,

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Requested By",style: subTitleStyle,),
                      SizedBox(height: 5,),
                      Text("Vasanthakumar (Manager)",style: descriptionStyleDark,),
                      SizedBox(height: 15,),
                      Text("Approved By",style: subTitleStyle,),
                      SizedBox(height: 5,),
                      Text("Srivatsav (Suprvisor)",style: descriptionStyleDark,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text("Details",style: titleStyle,),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.4),
                ),
                //height: 150,
                width: MediaQuery.of(context).size.width,

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Seller",style: subTitleStyle,),
                      SizedBox(height: 5,),
                      Text("Vasanth transport",style: descriptionStyleDark,),
                      SizedBox(height: 15,),
                      Text("Vehicle No.",style: subTitleStyle,),
                      SizedBox(height: 5,),
                      Text("TN66V6571",style: descriptionStyleDark,),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40,),
              ToDoButton(
                onPressed: (){},
                assetName: "",
                text: "Approved by Manager",
                textColor: Colors.white,
                backgroundColor: Colors.green,
                textSize: 40,


              ),
              SizedBox(height: 100,),

            ],
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: addItem,
//      ),
    );
  }
  void addItem(){

    setState(() {
      time.add(time[0]);
      time.length;
    });

  }

}

Widget timeCard(BuildContext context,int count,String time)
{
  return Padding(
    padding:EdgeInsets.all(10),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$count",style: descriptionStyleDark,),
        SizedBox(width: 150,),
        Text(time,style: descriptionStyleDark,),
      ],
    ),
  );
}