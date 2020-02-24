import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/goods_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_goods_entry_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/goods_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodsApprovalsPage extends StatelessWidget {
  GoodsApprovalsPage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GoodsApprovalsPage(
        database: database,
      ),
    );
  }
}

class F_GoodsApprovalsPage extends StatefulWidget {
  F_GoodsApprovalsPage({@required this.database});
  Database database;

  @override
  _F_GoodsApprovalsPageState createState() => _F_GoodsApprovalsPageState();
}

class _F_GoodsApprovalsPageState extends State<F_GoodsApprovalsPage> {
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
              IconButton(
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
                  // do something
                  )
            ],
            centerTitle: true,
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
          print(snapshot.data.length);
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
                                data.vehicelImagePath,
                                data.mrrImagePath,
                                'MRR No. - ${data.MRRNumber}',
                                '${getDateTime(data.securityEntryTimestamp.seconds)}',
                                context,
                                GoodsDetailsPage(
                                  database: widget.database,
                                  goodsID: data.itemEntryID,
                                )),
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

  _ItemEntry(String vehicelImgPath, String mrrImagepath, String companyName,
      String itemEntryTime, BuildContext context, Widget page) {

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
                companyName,
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
                          image: NetworkImage(vehicelImgPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                  Column(children: <Widget>[
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
                                image: NetworkImage(mrrImagepath),
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
                  itemEntryTime,
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
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: [
//                Column(
//                    children: <Widget>[
//                      Row(
//                      children: <Widget>[
//                        CircleAvatar(backgroundColor: Colors.green,radius: 6,),
//                        SizedBox(width: 10,),
//                      Text("Entry Time",style: descriptionStyle,),
//                      ]
//                      ),
//                      SizedBox(height: 10,),
//                      Row(
//                          children: <Widget>[
//                            CircleAvatar(backgroundColor: Colors.red,radius: 8,),
//                            SizedBox(width: 10,),
//                            Text("Entry Time",style: descriptionStyle,),
//                          ]
//                      ),
//
//                    ]
//                ),
//                Column(
//                    children: <Widget>[
//                      Row(
//                          children: <Widget>[
//                            CircleAvatar(backgroundColor: Colors.yellow,radius: 8,),
//                            SizedBox(width: 10,),
//                            Text("Entry Time",style: descriptionStyle,),
//                          ]
//                      ),
//                      SizedBox(height: 10,),
//                      Row(
//                          children: <Widget>[
//                            CircleAvatar(backgroundColor: Colors.grey,radius: 8,),
//                            SizedBox(width: 10,),
//                            Text("Entry Time",style: descriptionStyle,),
//                          ]
//                      ),
//
//                    ]
//                ),
//              ],
//            ),
              Text(
                "Approval pending from store manager",
                style: descriptionStyleDark,
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
}
