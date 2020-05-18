import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/approval_status.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/database_model/vehicle_trip_record.dart';
import 'package:bhavani_connect/utilities/date_time.dart';
import 'package:bhavani_connect/vehicle/detail/trip/vehicle_detail_trip_extras.dart';
import 'package:bhavani_connect/vehicle/vehicle_extras.dart' as vehicleExtra;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vehicle_detail_trip_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class VehicleDetailTripPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehicleDetailTripPageState();
  }
}

class VehicleDetailTripPageState extends State<VehicleDetailTripPage> {
  // Insert into injector file if you use it.
  // injector.map<VehicleDetailTripBloc>((i) => VehicleDetailTripBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<VehicleDetailTripBloc>();

  final List time = [
    DateTime.now().toIso8601String(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleDetailTripBloc, VehicleDetailTripState>(
      listener: (BuildContext context, VehicleDetailTripState state) {},
      child: BlocBuilder<VehicleDetailTripBloc, VehicleDetailTripState>(
        builder: (BuildContext context, VehicleDetailTripState state) {
          return offlineWidget(context);
        },
      ),
    );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
            body: BlocListener<VehicleDetailTripBloc, VehicleDetailTripState>(
          listener: (BuildContext context, VehicleDetailTripState state) {},
          child: BlocBuilder<VehicleDetailTripBloc, VehicleDetailTripState>(
            builder: (BuildContext context, VehicleDetailTripState state) {
              if (state is Success) {
                return _buildContent(context,
                    vehicle: state.vehicle,
                    tripRecordList: state.tripRecordList);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        )),
      ),
    );
  }

  Widget _buildContent(BuildContext context,
      {Vehicle vehicle, List<VehicleTripRecord> tripRecordList}) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBarDark(
            leftActionBar: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
            leftAction: () {
              Navigator.pop(context, true);
            },
            // rightActionBar: Icon(Icons.border_color,size: 25,color: Colors.white,),
            rightAction: () {
//            GoToPage(
//                context,
//                AddInvoice(
//                ));
            },
            primaryText: 'Vehicle Details',
            tabBarWidget: null,
          ),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Trip Records",
                    style: titleStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    //height: 150,
                    width: MediaQuery.of(context).size.width,

                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 30, left: 20, right: 20),
                      child: DataTable(
                          showCheckboxColumn: false, // <-- this is important
                          columns: [
                            DataColumn(
                                label: Text(
                              'Round',
                              style: subTitleStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Time',
                              style: subTitleStyle,
                            )),
                          ],
                          rows: tripRecordList
                              ?.map(
                                (e) => DataRow(
                                  cells: [
                                    DataCell(Text(
                                      '${e?.round ?? '-'}',
                                      style: descriptionStyleDark,
                                    )),
                                    DataCell(Text(
                                      '${hhmmFormatDate(timestamp: e.time.toDate())}',
                                      style: descriptionStyleDark,
                                    )),
                                  ],
                                ),
                              )
                              ?.toList()),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Approval Status",
                    style: titleStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    //height: 150,
                    width: MediaQuery.of(context).size.width,

                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 30, left: 5, right: 10),
                      child: DataTable(
                          showCheckboxColumn: false, // <-- this is important
                          columns: [
                            DataColumn(
                                label: Text(
                              'Status',
                              style: subTitleStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: subTitleStyle,
                            )),
                            DataColumn(
                                label: Text(
                              'Time',
                              style: subTitleStyle,
                            )),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text(
                                  'Requested By',
                                  style: descriptionStyleDark,
                                )),
                                DataCell(Text(
                                  vehicleExtra.parseRequest(
                                      vehicle.requestedByUserId,
                                      vehicle.requestedByUserName,
                                      vehicle.requestedByUserRole),
                                  style: descriptionStyleDark,
                                )),
                                DataCell(Text(
                                  '${hhmmVehicleDetailFormat(timestamp: vehicle?.dateRequest?.toDate())}',
                                  style: descriptionStyleDark,
                                )),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                  'Approved By',
                                  style: descriptionStyleDark,
                                )),
                                DataCell(Text(
                                  vehicleExtra.parseApproval(
                                      vehicle.approvedByUserId,
                                      vehicle.approvedByUserName,
                                      vehicle.approvedByUserRole),
                                  style: descriptionStyleDark,
                                )),
                                DataCell(Text(
                                  '${hhmmVehicleDetailFormat(timestamp: vehicle?.dateApproval?.toDate())}',
                                  style: descriptionStyleDark,
                                )),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Details",
                    style: titleStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    //height: 150,
                    width: MediaQuery.of(context).size.width,

                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Seller",
                            style: subTitleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${vehicle.sellerName}',
                            style: descriptionStyleDark,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Vehicle No.",
                            style: subTitleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${vehicle.vehicleNo}',
                            style: descriptionStyleDark,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Units per",
                            style: subTitleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${vehicle.unitsPerTrip}',
                            style: descriptionStyleDark,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: (vehicle.approvalStatus == null || vehicle.approvalStatus ==
                ApprovalStatus.approvalPending)
            ? null
            : Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        context
                            .bloc<VehicleDetailTripBloc>()
                            .add(TripRecord(vehicle: vehicle));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green.withOpacity(0.8),
                        ),
                        height: 35,
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ADD",
                              style: subTitleStyleLight1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  void addItem() {
    setState(() {
      time.add(time[0]);
      time.length;
    });
  }
}
