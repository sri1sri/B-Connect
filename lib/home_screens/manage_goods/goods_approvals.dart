import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_goods_entry_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/goods_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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

  Widget addGoods(){
    if(widget.employee.role == 'Security'){
      return IconButton(
          icon: Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
          onPressed: () {
            GoToPage(
                context,
                AddGoodsEntryPage(
                  database: widget.database,
                ));
          }
      );
    }else{
      return Container();
    }
  }
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF1F4B6E),
            title: Center(
                child: Text(
              'Goods Approvals',
              style: subTitleStyleLight,
            )),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),

            actions: <Widget>[
              addGoods(),

              FlatButton(
                child: Text('',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: ()=> print(''),
              )
            ],
            centerTitle : true,
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return _buildCards(context);
  }

  Widget _buildCards(BuildContext context) {
    return StreamBuilder<List<GoodsEntry>>(
        stream: widget.database.readGoodsEntries(),
        builder: (context, snapshot) {
          return ListItemsBuilder<GoodsEntry>(
            snapshot: snapshot,
            itemBuilder: (context, data) => Column(
              children: <Widget>[
                Container(
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
                                  goodsID: data.itemEntryID,
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

  _ItemEntry(BuildContext context, Widget page, GoodsEntry data) {
    return InkWell(
      child: Container(
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
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(data.vehicelImagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                    Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(data.mrrImagePath),
                                fit: BoxFit.cover))),
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
              Row(
                children: <Widget>[
                  SizedBox(width: 20,),
                  Text("Security",style: statusTracker,),
                  SizedBox(width: 20,),

                  Text("Supervisor",style: statusTracker,),
                  SizedBox(width: 10,),
                  Text("Store Manager",style: statusTracker,),
                  SizedBox(width: 10,),

                  Text("Accountant",style: statusTracker,),

                ],
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
    return Row(
      children: <Widget>[
        SizedBox(width: 40,),
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
        SizedBox(width: 40,),
      ],
    );
  }
}
