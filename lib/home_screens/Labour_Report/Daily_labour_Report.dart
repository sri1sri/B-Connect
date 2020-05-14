import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Concrete_Entries/Entry_description.dart';
import 'package:bhavani_connect/home_screens/Concrete_Entries/Print_entries.dart';
import 'package:bhavani_connect/home_screens/Concrete_Entries/add_concrete_entry.dart';
import 'package:bhavani_connect/home_screens/Labour_Report/Add_report.dart';
import 'package:bhavani_connect/home_screens/Labour_Report/Detail_Report.dart';
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

import 'Print_Reports.dart';



class LabourEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_LabourEntries(),
    );
  }
}

class F_LabourEntries extends StatefulWidget {
  @override
  _F_LabourEntries createState() => _F_LabourEntries();
}

class _F_LabourEntries extends State<F_LabourEntries> {
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
        child: CustomAppBarDark(
          leftActionBar: Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),
          leftAction: (){
            Navigator.pop(context,true);
          },
          rightActionBar: Icon(Icons.print,size: 25,color: Colors.white,),
          rightAction: (){
            GoToPage(
                context,
                PrintReport(
                ));
          },
          primaryText: 'Daily Labour Report',
          tabBarWidget: null,
        ),
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
                      DataColumn(label: Text("Labour Type",style: subTitleStyle1,)),
                      DataColumn(label: Text("Construction Site",style: subTitleStyle1,)),
                      DataColumn(label: Text("Block",style: subTitleStyle1,)),
                      DataColumn(label: Text("Dealer Name",style: subTitleStyle1,)),
                      DataColumn(label: Text("No. of People ",style: subTitleStyle1,)),
                      DataColumn(label: Text("Propose",style: subTitleStyle1,)),
                    ],
                    rows: items
                        .map(
                          (itemRow) => DataRow(onSelectChanged: (b) {GoToPage(
                          context,
                              DetailReport());},
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
                            Text(itemRow.labourType,style:descriptionStyleDark,),
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
                            Text(itemRow.dealerName,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.noofPeople,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.purpose,style:descriptionStyleDark,),
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
              AddLabourReport(
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
  String labourType;
  String dealerName;
  String noofPeople;
  String purpose;

  ItemInfo({
    this.slNo,
    this.date,
    this.site,
    this.block,
    this.labourType,
    this.dealerName,
    this.noofPeople,
    this.purpose,
  });
}

var items = <ItemInfo>[
  ItemInfo(
      slNo: '1',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      labourType: "Self employees",
      dealerName: "Vasanth Agencies",
      noofPeople: "20",
      purpose: "Plumbing"

  ),
  ItemInfo(
      slNo: '2',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      labourType: "Out Sourcing employees",
      dealerName: "Vasanth Agencies",
      noofPeople: "20",
      purpose: "Plumbing"

  ),
  ItemInfo(
      slNo: '3',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      labourType: "Self employees",
      dealerName: "Vasanth Agencies",
      noofPeople: "20",
      purpose: "Plumbing"

  ),
  ItemInfo(
      slNo: '3',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      labourType: "Out Sourcing employees",
      dealerName: "Vasanth Agencies",
      noofPeople: "20",
      purpose: "Plumbing"

  ),
  ItemInfo(
      slNo: '4',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      labourType: "Self employees",
      dealerName: "Vasanth Agencies",
      noofPeople: "20",
      purpose: "Plumbing"

  ),

];