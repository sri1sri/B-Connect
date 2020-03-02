import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ItemDetailsPage(),
    );
  }
}

class F_ItemDetailsPage extends StatefulWidget {
  @override
  _F_ItemDetailsPageState createState() => _F_ItemDetailsPageState();
}

class _F_ItemDetailsPageState extends State<F_ItemDetailsPage> {
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
                  child: Text(
                    "",
                    style: subTitleStyle,
                  ),
                  //shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                )),
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Item Details',
          tabBarWidget: null,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10,),
              _OrderedItemsCard('vasanth steel', 'iron rod', 'beam', '3 tons'),
              _OrderedItemsCard('sri bricks', 'bricks', 'wall', '2 load'),
              _OrderedItemsCard('vamsi cements', 'cements', 'patch', '1 ton'),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),

    );
  }

  _OrderedItemsCard(String companyName, String itemName, String category, String quantity)
  {

    print('details == ${companyName}, ${itemName}, ${category}, ${quantity.toString()}');
    return Container(

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    children: <Widget>[

                      Text("Company Name",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(companyName,style: descriptionStyleDark,),
                      SizedBox(height: 10,),
                      Text("Item names",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(itemName,style: descriptionStyleDark,),
                    ]
                ),
                Column(
                    children: <Widget>[

                      Text("Category",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(category,style: descriptionStyleDark,),
                      SizedBox(height: 10,),
                      Text("Quantity",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(quantity,style: descriptionStyleDark,),
                    ]
                ),
              ],
            ),
            SizedBox(height: 20,),
          ],



        ),
      ),
    );


  }

}
