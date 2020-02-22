import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/camera_screens/Camera_page.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_goods_entry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodsApprovalsPage extends StatelessWidget {
  GoodsApprovalsPage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_GoodsApprovalsPage(database: database,),
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
            title: Text(
              'Goods Approvals',
              style: subTitleStyle,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
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
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              InkWell(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("images/apple.png"),
                    backgroundColor: Colors.red,
                    radius: 50,
                  ),
                  title: Text(
                    'company name not updated',
                    style: subTitleStyle,
                  ),
                  subtitle: Text(
                    'MRR added time',
                    style: descriptionStyle,
                  ),
                  //trailing: Text('Edit', style: subTitleStyle,),
                ),
                onTap: () {},
              ),











              InkWell(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("images/apple.png"),
                    backgroundColor: Colors.red,
                    radius: 50,
                  ),
                  title: Text(
                    'company name not updated',
                    style: subTitleStyle,
                  ),
                  subtitle: Text(
                    'MRR added time',
                    style: descriptionStyle,
                  ),
                  //trailing: Text('Edit', style: subTitleStyle,),
                ),
                onTap: () {
                  GoToPage(context, CameraPage());
                },
              ),
            ],
          ),
//          Column(children: <Widget>[
//          ],),

          Column(
            children: <Widget>[
              InkWell(
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/prolfile_image.jpg"),
                    backgroundColor: Colors.red,
                    radius: 30,
                  ),
                ),
                onTap: () {
                  GoToPage(context, AddGoodsEntryPage());
                },
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
