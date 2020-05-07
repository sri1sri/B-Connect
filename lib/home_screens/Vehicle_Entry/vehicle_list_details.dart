import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/Filtered_vehicle_list_details.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/filter_vehicle_list_details.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/vehicle_details_readings.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/add_vehicle_details.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'vehicle_details_trip.dart';

class DaySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_DaySelection(),
    );
  }
}

class F_DaySelection extends StatefulWidget {
  @override
  _F_DaySelection createState() => _F_DaySelection();
}

class _F_DaySelection extends State<F_DaySelection> {
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
          rightActionBar:Icon(Icons.search,size: 25,color: Colors.white,),
          rightAction: (){
            GoToPage(
                context,
                VehicleFilter(
                ));
          },
          primaryText: 'Vehicle Entries',
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
                    dataRowHeight: 90.0,
                    columns: <DataColumn>[
                      DataColumn(label: Text("S.No.",style: subTitleStyle1,)),
                      DataColumn(label: Text("Date",style: subTitleStyle1,)),
                      DataColumn(label: Text("Vehicle Number",style: subTitleStyle1,)),
                      DataColumn(label: Text("Site",style: subTitleStyle1,)),
                      DataColumn(label: Text("Dealer Name",style: subTitleStyle1,)),
                      DataColumn(label: Text("Category",style: subTitleStyle1,),),
                      DataColumn(label: Text("Vehicle Type",style: subTitleStyle1,),),
                      DataColumn(label: Text("Start Time",style: subTitleStyle1,)),
                      DataColumn(label: Text("Start Readings",style: subTitleStyle1,)),
                      DataColumn(label: Text("End Time",style: subTitleStyle1,)),
                      DataColumn(label: Text("End Readings",style: subTitleStyle1,)),
                      DataColumn(label: Text("Total Timings",style: subTitleStyle1,)),
                      DataColumn(label: Text("Total Reading",style: subTitleStyle1,)),
                      DataColumn(label: Text("Total Trips",style: subTitleStyle1,)),
                      DataColumn(label: Text("Units per Trip",style: subTitleStyle1,)),
                      DataColumn(label: Text("Requested by",style: subTitleStyle1,)),
                      DataColumn(label: Text("Approved by",style: subTitleStyle1,)),
                      DataColumn(label: Text("Approval Status",style: subTitleStyle1,)),
                    ],
                    rows: items
                        .map(
                          (itemRow) => DataRow(onSelectChanged: (b) {GoToPage(
                              context,
                              AddVehicleDetails());},
                        cells: [
                          DataCell(
                            Text(itemRow.slno,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.date,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.vehicleNo,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.site,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.delName,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(Column(
                            children:
                            [
                              Image.asset(itemRow.imgCate,height: 60,width: 60,),
                              Text(itemRow.nameCat,style:descriptionStyleDark,)
                            ],
                          )),
                          DataCell(
                            Text(itemRow.vehicleType,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.startTime,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.startRead,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.endTime,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.endRead,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.totalTime,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.totalRead,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.totalTrips,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.unitsPerTrip,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.requestedBy,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(itemRow.approvedBy,style:descriptionStyleDark,),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: itemRow.approvalStatus == 'Approved' ? Colors.green.withOpacity(0.8) :
                                (itemRow.approvalStatus == 'Pending' ? Colors.orange.withOpacity(0.8) :
                                Colors.red.withOpacity(0.8))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(itemRow.approvalStatus,style:subTitleStyleLight1,),
                                  )
                                ],
                              )
                          )),
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
              AddVehicle(
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class ItemInfo {
  String slno;
  String date;
  String vehicleNo;
  String site;
  String delName;
  String imgCate;
  String nameCat;
  String vehicleType;
  String startTime;
  String startRead;
  String endTime;
  String endRead;
  String totalTime;
  String totalRead;
  String totalTrips;
  String unitsPerTrip;
  String requestedBy;
  String approvedBy;
  String approvalStatus;

  ItemInfo({
    this.slno,
    this.date,
    this.vehicleNo,
    this.site,
    this.delName,
    this.imgCate,
    this.nameCat,
    this.vehicleType,
    this.startTime,
    this.startRead,
    this.endTime,
    this.endRead,
    this.totalTime,
    this.totalRead,
    this.totalTrips,
    this.unitsPerTrip,
    this.requestedBy,
    this.approvedBy,
    this.approvalStatus,

  });
}

var items = <ItemInfo>[
  ItemInfo(
    slno: '1',
    date: '29/10/2020',
    vehicleNo: 'TN66V6571',
    site: 'Bhavani Vivan',
    delName: 'Vasanth Motors',
    imgCate: 'images/jcb.png',
    nameCat: 'JCB/Hitachi',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Pending',
  ),
  ItemInfo(
    slno: '2',
    date: '30/10/2020',
    vehicleNo: 'TN33V6371',
    site: 'Bhavani Aravindham',
    delName: 'Sri motors',
    imgCate: 'images/c1.png',
    nameCat: 'Tractor',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Approved',
  ),
  ItemInfo(
    slno: '3',
    date: '04/04/2020',
    vehicleNo: 'TN66V6571',
    site: 'Bhavani Vivan',
    delName: 'Vasanth Motors',
    imgCate: 'images/c9.png',
    nameCat: 'Road Roller',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Decline',
  ),
  ItemInfo(
    slno: '4',
    date: '20/12/2020',
    vehicleNo: 'TN66V6571',
    site: 'Bhavani Vivan',
    delName: 'Vasanth Motors',
    imgCate: 'images/c5.png',
    nameCat: 'BoreWell',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Approved',
  ),
  ItemInfo(
    slno: '5',
    date: '29/10/2020',
    vehicleNo: 'TN66V6571',
    site: 'Bhavani Vivan',
    delName: 'Vasanth Motors',
    imgCate: 'images/jcb.png',
    nameCat: 'JCB/Hitachi',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Approved',
  ),
  ItemInfo(
    slno: '6',
    date: '30/10/2020',
    vehicleNo: 'TN33V6371',
    site: 'Bhavani Aravindham',
    delName: 'Sri motors',
    imgCate: 'images/c1.png',
    nameCat: 'Tractor',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Decline',
  ),
  ItemInfo(
    slno: '7',
    date: '04/04/2020',
    vehicleNo: 'TN66V6571',
    site: 'Bhavani Vivan',
    delName: 'Vasanth Motors',
    imgCate: 'images/c9.png',
    nameCat: 'Road Roller',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Decline',
  ),
  ItemInfo(
    slno: '8',
    date: '20/12/2020',
    vehicleNo: 'TN66V6571',
    site: 'Bhavani Vivan',
    delName: 'Vasanth Motors',
    imgCate: 'images/c5.png',
    nameCat: 'BoreWell',
    vehicleType: 'Trip',
    startTime: '10.30am',
    startRead: '8723711',
    endTime: '06.34pm',
    endRead: '3838282',
    totalTime: '3hrs',
    totalRead: '7677',
    totalTrips: '10',
    unitsPerTrip: '3',
    requestedBy: 'Vasanth (Supervisor)',
    approvedBy: 'Srivatsav (Manager)',
    approvalStatus: 'Pending',
  ),
];