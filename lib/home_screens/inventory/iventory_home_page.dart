import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/inventory/recent_activities.dart';
import 'package:bhavani_connect/home_screens/inventory/recent_items.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_InventoryPage(),

    );
  }
}

class F_InventoryPage extends StatefulWidget {
  @override
  _F_InventoryPageState createState() => _F_InventoryPageState();
}

class _F_InventoryPageState extends State<F_InventoryPage> {
  double _crossAxisSpacing = 5, _mainAxisSpacing = 1, _aspectRatio = 1;
  int _crossAxisCount = 2;
  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          appBar:
          PreferredSize(
            preferredSize: Size.fromHeight(120),
            //preferredSize : Size(double.infinity, 100),
            child: CustomAppBar(
              leftActionBar: Container(
                child: Icon(Icons.arrow_back, size: 40,color: Colors.black38,),
              ),
              leftAction: (){
                Navigator.pop(context,true);
              },
              rightActionBar: Container(
                //child: Icon(Icons.notifications, size: 40,),
              ),
              rightAction: (){
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Inventory',
              tabBarWidget: null,
            ),
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  @override
  Widget _buildContent(BuildContext context) {
    var Value = ["5","7","30","₹2.1K"];
    var Details = ["Items","New Entries","Total Quantity","Total Value"];
    List<IconData> F_icons=[Icons.category,Icons.note_add,Icons.format_align_center,Icons.attach_money];
    var myGridView = new GridView.builder(

      itemCount: Details.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _crossAxisCount,
        crossAxisSpacing: _crossAxisSpacing,
        mainAxisSpacing: _mainAxisSpacing,
        childAspectRatio: _aspectRatio,),
      itemBuilder: (BuildContext context, int index) {

        return new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.center,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0,right: 10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Icon(F_icons[index],size: 50,color: backgroundColor,),
                  new Text( Value[index],style: highlight,),
                  new Text( Details[index],style: subTitleStyle,),

                ],
              ),


            ),
          );
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(

          children: <Widget>[
            Text("Inventory Summary",style: highlightDescription,),
            SizedBox(height: 20,),
            Expanded(child: myGridView),
            _recentActivities(),
            SizedBox(height: 10,),
            _recentItems(),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
  Widget _recentActivities() {
    return Container(
      width: double.infinity,
      child: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityPage()),
            );
          },
        padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[

              Text('Recent Activities',
                  style: highlightDescription
              ),
            ],

          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
                size: 30,
              ),
            ],

          ),

        ],

      ),
    ),

    );
  }
  Widget _recentItems() {
    return Container(
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecentItemPage( ) ),
          );
        },
        padding: EdgeInsets.all(15.0),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[

                Text('Recent Items',
                    style: highlightDescription
                ),
              ],

            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                  size: 30,
                ),
              ],

            ),

          ],

        ),
      ),

    );
  }
}

