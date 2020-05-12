import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_goods_entry_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/goods_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class GoodsApprovalsPage extends StatelessWidget {
  GoodsApprovalsPage({@required this.database, @required this.employee});
  Database database;
  EmployeeDetails employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GoodsApprovalsPage(
        database: database,
        employee: employee,
      ),
    );
  }
}

class F_GoodsApprovalsPage extends StatefulWidget {
  F_GoodsApprovalsPage({@required this.database, @required this.employee});
  Database database;
  EmployeeDetails employee;

  @override
  _F_GoodsApprovalsPageState createState() => _F_GoodsApprovalsPageState();
}

class _F_GoodsApprovalsPageState extends State<F_GoodsApprovalsPage> {

  final tween = MultiTrackTween([
    Track("color1").add(Duration(seconds: 3),
        ColorTween(begin: Colors.grey.shade400, end: Colors.grey.shade300)),
    Track("color2").add(Duration(seconds: 3),
        ColorTween(begin: Colors.grey.shade400, end: Colors.grey.shade300))
  ]);



  DateTime selectedDate = DateTime.now();
  var customFormat = DateFormat("dd MMMM yyyy 'at' HH:mm:ss 'UTC+5:30'");
  var customFormat2 = DateFormat("dd MMMM yyyy");

  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        print(customFormat.format(picked));
        selectedDate = picked;
      });
    }
  }

//  Widget addGoods(){
//    if(widget.employee.role == 'Security'){
//      return IconButton(
//          icon: Icon(
//            Icons.add_circle,
//            color: backgroundColor,
//            size: 30,
//          ),
//          onPressed: () {
//            GoToPage(
//                context,
//                AddGoodsEntryPage(
//                  database: widget.database,
//                ));
//          }
//      );
//    }else{
//      return Container();
//    }
//  }
  @override
  Widget build(BuildContext context) {
    print('role${widget.employee.role}');
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
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              primaryText: null,
              secondaryText: 'Goods Approvals',
              tabBarWidget: null,
            ),
          ),
          body: Column(

              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 10),
                  child: Container(
                    child: RaisedButton(
                      color: Colors.white,
                      child: Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: backgroundColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('${customFormat2.format(selectedDate)}',
                                      style: subTitleStyle),
                                ],
                              ),
                            ),
                            Text('Change', style: subTitleStyle),
                          ],
                        ),
                      ),
                      onPressed: () => showPicker(context),
                    ),
                  ),
                ),
                Expanded(child: _buildContent(context))]

          ),
          floatingActionButton: widget.employee.role != 'Security' ? null : FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              GoToPage(
                  context,
                  AddGoodsEntryPage(
                    database: widget.database,
                  ));
            },
            child: Icon(Icons.add),
            backgroundColor: backgroundColor,
          ),
        ),
        ),

    );
  }

  Widget _buildContent(BuildContext context) {
    return _buildCards(context);
  }

  Widget _buildCards(BuildContext context) {
    return StreamBuilder<List<GoodsEntry>>(
        stream: widget.database.readGoodsEntries(queryKey()),
        builder: (context, snapshot) {


          return ListItemsBuilder<GoodsEntry>(
            snapshot: snapshot,
            itemBuilder: (context, data) => Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[

                            _ItemEntry(
                                context,
                                GoodsDetailsPage(
                                  database: widget.database,
                                  goodsID: data.goodsEntryID,
                                  employee: widget.employee,
                                ), data),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  String queryKey(){
    switch(widget.employee.role){
      case 'Security':
        return 'security_id';
        break;
      case 'Site Engineer':
        return 'site_manager_id';
        break;
      case 'Store Manager':
        return 'store_manager_id';
        break;
      case 'Supervisor':
        return 'supervisor_id';
        break;
      case 'Manager':
        return 'manager_id';
        break;
    }
  }

  _ItemEntry(BuildContext context, Widget page, GoodsEntry data) {
    return InkWell(
      child: Container(
        color: Colors.white,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                    'MRR No. - ${data.MRRNumber}',
                    style: subTitleStyle,
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: <Widget>[
                    Text(
                      "Vehicle Photo",
                      style: descriptionStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    PhotoHero(
                      photo: (data == null ? "" : data.vehicelImagePath),
                      width: 100.0,
                      height: 100.0,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.black,
                                ),
                                body: Container(
                                  // The blue background emphasizes that it's a new route.
                                  color: Colors.black,
                                  padding: const EdgeInsets.only(top:100.0,bottom: 100,left:10,right: 10),
                                  alignment: Alignment.topLeft,
                                  child: PhotoHero(
                                    photo: (data == null ? "" : data.vehicelImagePath),
                                    width: double.infinity,
                                    height: double.infinity,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              );
                            }
                        ));
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                  ]),



                  Column(
                      children: <Widget>[
                        Text(
                          "MRR Photo",
                          style: descriptionStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),


                        PhotoHero(
                          photo: (data == null ? "" : data.mrrImagePath),
                          width: 100.0,
                          height: 100.0,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      backgroundColor: Colors.black,
                                    ),
                                    body: Container(
                                      // The blue background emphasizes that it's a new route.
                                      color: Colors.black,
                                      padding: const EdgeInsets.only(top:100.0,bottom: 100,left:10,right: 10),
                                      alignment: Alignment.topLeft,
                                      child: PhotoHero(
                                        photo: (data == null ? "" : data.mrrImagePath),
                                        width: double.infinity,
                                        height: double.infinity,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  );
                                }
                            ));
                          },
                        ),

                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ],
              ),
              Column(children: <Widget>[
                Text(
                  "Entry Time",
                  style: descriptionStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${getDateTime(data.securityRequestedTimestamp.seconds)}',
                  style: descriptionStyleDark,
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Text(
                "Order Status",
                style: descriptionStyle,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 10,),
              _trackGoodsStatus(data.approvalLevel),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("Security",style: statusTracker,),
                    SizedBox(width: 15,),

                    Text("Supervisor",style: statusTracker,),
                    SizedBox(width: 15,),
                    Text("Store Manager",style: statusTracker,),
                    SizedBox(width: 15,),

                    Text("Accountant",style: statusTracker,),

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Tap for Goods Details",
                style: descriptionStyleDarkBlur,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        GoToPage(context, page);
      },
    );
  }

  Widget _trackGoodsStatus(int approvalLevel){
    switch (approvalLevel) {
      case 0:
        return statusTrackerWidget(Colors.orangeAccent, Colors.grey, Colors.grey, Colors.grey);
        break;

      case 1:
        return statusTrackerWidget(Colors.green, Colors.orangeAccent, Colors.grey, Colors.grey);
        break;

      case 2:
        return statusTrackerWidget(Colors.green, Colors.green, Colors.orangeAccent, Colors.grey);
        break;

      case 3:
        return statusTrackerWidget(Colors.green, Colors.green, Colors.green, Colors.orangeAccent);
        break;

      case 4:
        return statusTrackerWidget(Colors.green, Colors.green, Colors.green, Colors.green);
        break;

    }
  }
  Widget statusTrackerWidget(Color levelOne, Color levelTwo, Color levelThree, Color levelFour){
    return Container(
      width: MediaQuery.of(context).size.width ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 15,),
          CircleAvatar(backgroundColor: levelOne,radius: 6,),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: new LinearPercentIndicator(
              width: 80,
              animation: true,
              lineHeight: 4.0,
              animationDuration: 3000,
              percent: 1,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: levelTwo,
            ),
          ),
          CircleAvatar(backgroundColor: levelTwo,radius: 6,),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: new LinearPercentIndicator(
              width: 80,
              animation: true,
              lineHeight: 4.0,
              animationDuration: 3000,
              percent: 1,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: levelThree,
            ),
          ),
          CircleAvatar(backgroundColor: levelThree,radius: 6,),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: new LinearPercentIndicator(
              width: 80,
              animation: true,
              lineHeight: 4.0,
              animationDuration: 3000,
              percent: 1,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: levelFour,
            ),
          ),
          CircleAvatar(backgroundColor: levelFour,radius: 6,),
          SizedBox(width: 15,),
        ],
      ),
    );
  }

}
class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width, this.height }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  final double height;

  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            bottomLeft: const Radius.circular(10.0),
            bottomRight: const Radius.circular(10.0),),
          ),
      child: SizedBox(
        width: width,
        height: height,
        child: Hero(
          tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0),),
                      image: DecorationImage(
                          image: NetworkImage(photo),
                          fit: BoxFit.cover))
                ),
              ),
            ),
          ),
        ),
      );

  }
}