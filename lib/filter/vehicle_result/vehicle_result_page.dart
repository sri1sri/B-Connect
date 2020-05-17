import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/approval_status.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/filter/vehicle_result/vehicle_result_extras.dart';
import 'package:bhavani_connect/utilities/date_time.dart';
import 'package:bhavani_connect/vehicle/vehicle_extras.dart' as vehicleExtras;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import 'vehicle_result_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class VehicleResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehicleResultPageState();
  }
}

class VehicleResultPageState extends State<VehicleResultPage> {
  // Insert into injector file if you use it.
  // injector.map<VehicleResultBloc>((i) => VehicleResultBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<VehicleResultBloc>();

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
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
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
            rightActionBar: Icon(Icons.print, size: 25, color: Colors.white),
            rightAction: () {
              print('right action bar is pressed in appbar');
            },
            primaryText: 'Vehicle Entries',
            tabBarWidget: null,
          ),
        ),
        body: SealedBlocBuilder4<VehicleResultBloc, VehicleResultState, Initial,
            Loading, Success, Failure>(builder: (context, states) {
          return states(
            (Initial initial) => Center(child: CircularProgressIndicator()),
            (Loading loading) => Center(child: CircularProgressIndicator()),
            (Success success) => _bodySuccess(context,
                vehicleList: success.data,
                sellerName: success.sellerName,
                siteName: success.siteName,
                dateFrom: success.dateFrom,
                dateTo: success.dateTo),
            (Failure failure) => Center(),
          );
        }));
  }

  _bodySuccess(context,
      {List<Vehicle> vehicleList,
      String sellerName,
      String siteName,
      Timestamp dateFrom,
      Timestamp dateTo}) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "${yyyyMdFormatDate(timestamp: dateFrom.toDate())} to ${yyyyMdFormatDate(timestamp: dateTo.toDate())} ",
              style: subTitleStyleDark1,
            ),
            Text(
              "$sellerName | ${siteName ?? '-'}",
              style: descriptionStyleDarkBlur1,
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                onSelectAll: (b) {},
                sortAscending: true,
                showCheckboxColumn: false,
                dataRowHeight: 90.0,
                columns: <DataColumn>[
                  DataColumn(
                      label: Text(
                    "S.No.",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Date",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Vehicle Number",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Site",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Dealer Name",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                    label: Text(
                      "Category",
                      style: subTitleStyle1,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Vehicle Type",
                      style: subTitleStyle1,
                    ),
                  ),
                  DataColumn(
                      label: Text(
                    "Start Time",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Start Readings",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "End Time",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "End Readings",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Total Timings",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Total Reading",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Total Trips",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Units per Trip",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Requested by",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Approved by",
                    style: subTitleStyle1,
                  )),
                  DataColumn(
                      label: Text(
                    "Approval Status",
                    style: subTitleStyle1,
                  )),
                ],
                rows: vehicleList
                    .map(
                      (itemRow) => DataRow(
                        onSelectChanged: (b) {
                          context
                              .bloc<AuthenticationBloc>()
                              .gotoVehicleDetail(vehicle: itemRow);
                        },
                        cells: [
                          DataCell(
                            Text(
                              '${vehicleList.indexOf(itemRow) + 1}',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              '${(formatDateRow(timestamp: itemRow?.date?.toDate()))}',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.vehicleNo ?? '',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.site ?? '-',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.sellerName ?? '',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(Column(
                            children: [
                              Image.network(
                                itemRow?.categoryImage ?? '',
                                height: 60,
                                width: 60,
                              ),
                              Text(
                                itemRow?.categoryName ?? '',
                                style: descriptionStyleDark,
                              )
                            ],
                          )),
                          DataCell(
                            Text(
                              itemRow?.vehicleTypeName ?? '',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              hhmmFormatDate(
                                  timestamp: itemRow?.startTime?.toDate()),
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.startRead ?? '-',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              hhmmFormatDate(
                                  timestamp: itemRow?.endTime?.toDate()),
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.endRead ?? '-',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.totalTime ?? '-',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.totalRead ?? '-',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.totalTrips ?? '-',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              itemRow?.unitsPerTrip ?? '-',
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              vehicleExtras.parseRequest(
                                  itemRow?.requestedByUserId,
                                  itemRow?.requestedByUserName,
                                  itemRow?.requestedByUserRole),
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              vehicleExtras.parseApproval(
                                  itemRow?.approvedByUserId,
                                  itemRow?.approvedByUserName,
                                  itemRow?.approvedByUserRole),
                              style: descriptionStyleDark,
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _parseColorApproval(
                                      itemRow?.approvalStatus)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      _parseStringApproval(
                                          itemRow?.approvalStatus),
                                      style: subTitleStyleLight1,
                                    ),
                                  )
                                ],
                              ))),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              height: 500,
            )
          ],
        )),
      ),
    );
  }

  Color _parseColorApproval(int approvalStatus) {
    switch (approvalStatus) {
      case ApprovalStatus.approvalPending:
        return Colors.orange.withOpacity(0.8);
        break;
      case ApprovalStatus.approvalApproved:
        return Colors.green.withOpacity(0.8);
        break;
      case ApprovalStatus.approvalDecline:
        return Colors.red.withOpacity(0.8);
        break;
    }
    return Colors.orange.withOpacity(0.8);
  }

  String _parseStringApproval(int approvalStatus) {
    switch (approvalStatus) {
      case ApprovalStatus.approvalPending:
        return 'Pending';
        break;
      case ApprovalStatus.approvalApproved:
        return 'Approved';
        break;
      case ApprovalStatus.approvalDecline:
        return 'Decline';
        break;
    }
    return 'Pending';
  }
}
