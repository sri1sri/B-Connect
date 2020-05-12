import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Site_Activities/add_Site_Activity.dart';
import 'package:bhavani_connect/home_screens/Site_Activities/detail_description.dart';
import 'package:bhavani_connect/home_screens/Site_Activities/print_Activity.dart';
import 'package:bhavani_connect/home_screens/Site_Activities/search_Activity.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/AddNewInvoice.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/Stock_Filter.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/detail_description.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/vehicle_details_readings.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/add_vehicle_details.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SiteActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_SiteActivities(),
    );
  }
}

class F_SiteActivities extends StatefulWidget {
  @override
  _F_SiteActivities createState() => _F_SiteActivities();
}

class _F_SiteActivities extends State<F_SiteActivities> {
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
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15,),
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 45,
                        left: 20,
                      ),
                      child: InkWell(
                        child: Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),
                        onTap: (){
                          Navigator.pop(context,true);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           Text(
                            "Site Activities",
                            textAlign: TextAlign.center,
                            style: appBarTitleStyle,
                          ),
                        ],

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search,size: 25,color: Colors.white,),
                            onPressed: (){
                              GoToPage(
                                  context,
                                  SearchActivity(
                                  ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.print,size: 25,color: Colors.white,),
                              onPressed: (){
                                GoToPage(
                                    context,
                                    PrintActivity(
                                    ));
                              },
                          )
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ],

          ),
        )
      ),
      body:ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0),
            topLeft: Radius.circular(50.0)),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Text("23 October 2020",style: subTitleStyleDark1,),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    onSelectAll: (b) {},
                    sortAscending: true,
                    showCheckboxColumn: false,
                    dataRowHeight: 70.0,
                    columns: <DataColumn>[
                      DataColumn(label: Text("S.No.",style: subTitleStyle1,)),
                      DataColumn(label: Text("Date",style: subTitleStyle1,)),
                      DataColumn(label: Text("Site",style: subTitleStyle1,)),
                      DataColumn(label: Text("Block",style: subTitleStyle1,)),
                      DataColumn(label: Text("Category",style: subTitleStyle1,)),
                      DataColumn(label: Text("Sub Category",style: subTitleStyle1,)),
                      DataColumn(label: Text("UOM",style: subTitleStyle1,),),
                      DataColumn(label: Text("yesterday progress",style: subTitleStyle1,),),
                      DataColumn(label: Text("Total Progress",style: subTitleStyle1,)),
                      DataColumn(label: Text("Remarks",style: subTitleStyle1,)),
                    ],
                    rows: items
                        .map(
                          (itemRow) => DataRow(onSelectChanged: (b) {GoToPage(
                          context,
                              ActivityDetailDescription());},
                        cells: [
                          DataCell(
                            Text(itemRow.slNo,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.date,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.site,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.block,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.category,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.subCategory,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.uom,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.yesterdayProg,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.totalProg,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.remarks,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
                SizedBox(height: 500,)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          GoToPage(
              context,
              AddSiteActivity(
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class ItemInfo {
  String slNo;
  String date;
  String site;
  String block;
  String category;
  String uom;
  String subCategory;
  String yesterdayProg;
  String totalProg;
  String remarks;

  ItemInfo({
    this.slNo,
    this.date,
    this.site,
    this.category,
    this.uom,
    this.block,
    this.subCategory,
    this.yesterdayProg,
    this.totalProg,
    this.remarks,
  });
}

var items = <ItemInfo>[
  ItemInfo(
      slNo: '1',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      category: 'Iron/Steel',
      subCategory: 'TMT rod',
      uom: 'Tons',
      yesterdayProg: "20",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '2',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      category: 'Iron/Steel',
      subCategory: 'TMT rod',
      uom: 'Tons',
      yesterdayProg: "20",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '3',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      category: 'Iron/Steel',
      subCategory: 'TMT rod',
      uom: 'Tons',
      yesterdayProg: "20",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '3',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      category: 'Iron/Steel',
      subCategory: 'TMT rod',
      uom: 'Tons',
      yesterdayProg: "20",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '4',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      category: 'Iron/Steel',
      subCategory: 'TMT rod',
      uom: 'Tons',
      yesterdayProg: "20",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),

];