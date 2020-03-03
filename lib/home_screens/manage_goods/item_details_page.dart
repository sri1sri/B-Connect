import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/items_entry_model.dart';
import 'package:bhavani_connect/firebase/database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_items_entry_page.dart';

class ItemDetailsPage extends StatelessWidget {
  ItemDetailsPage({@required this.database, @required this.goodsID, @required this.employee});
  Database database;
  String goodsID;
  EmployeeDetails employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ItemDetailsPage(database: database, goodsID: goodsID,employee: employee,),
    );
  }
}

class F_ItemDetailsPage extends StatefulWidget {
  F_ItemDetailsPage({@required this.database, @required this.goodsID, @required this.employee});
  Database database;
  String goodsID;
  EmployeeDetails employee;

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
          rightActionBar: Container(
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.black38,
            ),
          ),
          rightAction: () {

            widget.employee.role == 'Supervisor' ?
            GoToPage(
              context,
              ItemsEntryPage(
                database: widget.database,
                goodsID: widget.goodsID,
              ),
            ) : '';
//            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Item Details',
          tabBarWidget: null,
        ),
      ),
      body: _goodsItemsDetails(context),
    floatingActionButton: widget.employee.role == 'Supervisor' ? Container(): FloatingActionButton(
      elevation: 90,
      backgroundColor: backgroundColor,
      autofocus: true,
      onPressed: () {
        GoToPage(
          context,
          ItemsEntryPage(
            database: widget.database,
            goodsID: widget.goodsID,
          ),
        );
      },
      child: Icon(Icons.add),
      tooltip: 'Add Items',
    ),
    );
  }


  Widget _goodsItemsDetails(BuildContext context) {
    return StreamBuilder<List<ItemEntry>>(
      stream: widget.database.viewItemsList(widget.goodsID),
      builder: (context, snapshot) {
        return ListItemsBuilder<ItemEntry>(
          snapshot: snapshot,
          itemBuilder: (context, itemsData) => _OrderedItemsCard(itemsData),
        );
      },
    );
  }

  Widget _OrderedItemsCard(ItemEntry data) {
    return Container(
      height: 200,
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
                      Text(data.companyName,style: descriptionStyleDark,),
                      SizedBox(height: 10,),
                      Text("Item names",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(data.itemName,style: descriptionStyleDark,),
                    ]
                ),
                Column(
                    children: <Widget>[

                      Text("Category",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text(data.categoryName,style: descriptionStyleDark,),
                      SizedBox(height: 10,),
                      Text("Quantity",style: descriptionStyle,),
                      SizedBox(height: 10,),
                      Text('${data.quantity.toString()} ${data.measure}',style: descriptionStyleDark,),
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
