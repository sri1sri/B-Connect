import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Concrete_Entries/Entry_description.dart';
import 'package:bhavani_connect/home_screens/Concrete_Entries/Print_entries.dart';
import 'package:bhavani_connect/home_screens/Concrete_Entries/add_concrete_entry.dart';
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



class ConcreteEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ConcreteEntries(),
    );
  }
}

class F_ConcreteEntries extends StatefulWidget {
  @override
  _F_ConcreteEntries createState() => _F_ConcreteEntries();
}

class _F_ConcreteEntries extends State<F_ConcreteEntries> {
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
                PrintEntries(
                ));
          },
          primaryText: 'Concrete Entries',
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
                      DataColumn(label: Text("Concrete Type",style: subTitleStyle1,)),
                      DataColumn(label: Text("Construction Site",style: subTitleStyle1,)),
                      DataColumn(label: Text("Block",style: subTitleStyle1,)),
                      DataColumn(label: Text("Yesterday's Progress",style: subTitleStyle1,)),
                      DataColumn(label: Text("Total Progress",style: subTitleStyle1,)),
                      DataColumn(label: Text("Remarks",style: subTitleStyle1,)),
                    ],
                    rows: items
                        .map(
                          (itemRow) => DataRow(onSelectChanged: (b) {GoToPage(
                          context,
                              EntryDescription());},
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
                            Text(itemRow.concreteType,style:descriptionStyleDark,),
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
                            Text(itemRow.yestProg,style:descriptionStyleDark,),
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
              AddConcreteEntry(
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
  String concreteType;
  String yestProg;
  String totalProg;
  String remarks;

  ItemInfo({
    this.slNo,
    this.date,
    this.site,
    this.block,
    this.concreteType,
    this.yestProg,
    this.totalProg,
    this.remarks,
  });
}

var items = <ItemInfo>[
  ItemInfo(
      slNo: '1',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      concreteType: "Strong Cement",
      block: "8th",
      yestProg: "30",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '2',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      concreteType: "Strong Cement",
      yestProg: "30",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '3',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      concreteType: "Strong Cement",
      yestProg: "30",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '3',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      concreteType: "Strong Cement",
      yestProg: "30",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),
  ItemInfo(
      slNo: '4',
      date: '29/Oct/2020',
      site: 'Bhavani Vivan',
      block: "8th",
      concreteType: "Strong Cement",
      yestProg: "30",
      totalProg: "60",
      remarks: 'Transfer from store to cnstruction Site'

  ),

];