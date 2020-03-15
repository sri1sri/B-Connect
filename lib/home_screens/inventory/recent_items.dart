import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_RecentItemPage(),
    );
  }
}

class F_RecentItemPage extends StatefulWidget {
  @override
  _F_RecentItemPageState createState() => _F_RecentItemPageState();
}

class _F_RecentItemPageState extends State<F_RecentItemPage> {
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
          rightActionBar: Padding(
            padding: const EdgeInsets.only(top:15.0,),
            child: Container(
                child: FlatButton(
                  onPressed: () {
                    print('clearing notification');
                  },
                  child: Text(""
                  ),
                  //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                )),
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Item Usage',
          tabBarWidget: null,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              _ItemsCard("Vasanth Steels", "Raw Materials","3.5 TMT", "₹2.1K", "2 Tons","05/Mar/2020 - 2:22 am","Their goal is to continue to be a leader in the construction industry within Newfoundland."),
              SizedBox(height: 10,),
              _ItemsCard("Vasanth Steels", "Raw Materials","3.5 TMT", "₹2.1K", "2 Tons","05/Mar/2020 - 2:22 am","Their goal is to continue to be a leader in the construction industry within Newfoundland."),
              SizedBox(height: 10,),
              _ItemsCard("Vasanth Steels", "Raw Materials","3.5 TMT", "₹2.1K", "2 Tons","05/Mar/2020 - 2:22 am","Their goal is to continue to be a leader in the construction industry within Newfoundland."),
              SizedBox(height: 50,),

            ],
          ),
        ),
      ),

    );
  }

  _ItemsCard(String CompanyName, String Category, String ItemName, String Price, String Quantity,String TimeDate,String Description )
  {
    return Column(children: <Widget>[
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
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 3.0, bottom: 0.0),
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
                    children: <Widget>[
                      Text(TimeDate)
                    ],
                  ),)),
            Positioned(
                left: 5.0,
                right: 5.0,
                top: 30.0,
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
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                  children: <Widget>[

                                    Text("Company Name",style: descriptionStyle,),
                                    SizedBox(height: 8,),
                                    Text(CompanyName,style: descriptionStyleDark,),
                                    SizedBox(height: 8,),
                                    Text("Item names",style: descriptionStyle,),
                                    SizedBox(height: 8,),
                                    Text(ItemName,style: descriptionStyleDark,),
                                  ]
                              ),
                              Column(
                                  children: <Widget>[

                                    Text("Category",style: descriptionStyle,),
                                    SizedBox(height: 8,),
                                    Text(Category,style: descriptionStyleDark,),
                                    SizedBox(height: 8,),
                                    Text("Quantity",style: descriptionStyle,),
                                    SizedBox(height: 8,),
                                    Text(Quantity,style: descriptionStyleDark,),
                                  ]
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
//                          Divider(
//                          color: Colors.black.withOpacity(0.5),
//                          ),
//                          SizedBox(height: 2,),
//                          Column(
//                            children: <Widget>[
//                              Text("Price",style: descriptionStyle,),
//                              SizedBox(height: 5,),
//                              Text(Price,style: highlightDescription,),
//                            ],
//                          ),
//                          SizedBox(height: 2,),
                          Divider(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          SizedBox(height: 2,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Description",style: descriptionStyle,),
                              SizedBox(height: 6,),
                              Text(Description,textAlign: TextAlign.center,),
                            ],
                          )
                        ]))),
          ]),
        ]);
  }


}
