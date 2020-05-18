import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/approval_status.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/add_vehicle_details.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/filter_vehicle_list_details.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/vehicle_details_readings.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/vehicle_list_details.dart';
import 'package:bhavani_connect/utilities/date_time.dart';
import 'package:bhavani_connect/vehicle/vehicle_extras.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'vehicle_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class VehiclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehiclePageState();
  }
}

class VehiclePageState extends State<VehiclePage> {
  // Insert into injector file if you use it.
  // injector.map<VehicleBloc>((i) => VehicleBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<VehicleBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    context.bloc<VehicleBloc>().closeStream();
    context.bloc<VehicleBloc>().close();
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
    return SealedBlocBuilder4<VehicleBloc, VehicleState, Initial, Loading,
        Success, Failure>(builder: (context, states) {
      return states(
        (Initial initial) => Center(child: CircularProgressIndicator()),
        (Loading loading) => Center(child: CircularProgressIndicator()),
        (Success success) => Center(
            child: _buildBody(context,
                vehicleList: success.vehicleList, employee: success.employee)),
        (Failure failure) => Center(child: CircularProgressIndicator()),
      );
    });
  }

  Widget _buildBody(BuildContext context,
      {List<Vehicle> vehicleList, EmployeeDetails employee}) {
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
          rightActionBar: Icon(
            Icons.search,
            size: 25,
            color: Colors.white,
          ),
          rightAction: () {
            context.bloc<AuthenticationBloc>().gotoFilterVehicle();
          },
          primaryText: 'Vehicle Entries',
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${dMyyyyFormatDate(timestamp: DateTime.now())}',
                  style: subTitleStyleDark1,
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
//                        "${widget.database.readCommonVariables().first}",
                        "No",
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
                                  _parseTotalTiming(itemRow?.startTime, itemRow?.endTime),
                                  style: descriptionStyleDark,
                                ),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(
                                  _parseTotalReading(itemRow?.startRead, itemRow?.endRead),
                                  style: descriptionStyleDark,
                                ),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(
                                  '${itemRow?.totalTrips ?? '-'}',
                                  style: descriptionStyleDark,
                                ),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(
                                  '${itemRow?.unitsPerTrip ?? '-'}',
                                  style: descriptionStyleDark,
                                ),
                                showEditIcon: false,
                                placeholder: false,
                              ),
                              DataCell(
                                Text(
                                  parseRequest(
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
                                  parseApproval(
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
            ),
          ),
        ),
      ),
      floatingActionButton: _hasShowAddVehicleButton(employee.role)
          ? FloatingActionButton(
              onPressed: () {
                context.bloc<AuthenticationBloc>().gotoAddVehicle();
              },
              child: Icon(Icons.add),
              backgroundColor: backgroundColor,
            )
          : Container(),
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

  bool _hasShowAddVehicleButton(String role) {
    switch (role) {
      case EmployeeDetails.roleSecurity:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  String _parseTotalTiming(Timestamp startTime, Timestamp endTime) {
    if(startTime == null || endTime == null) return '-';
    else {
      return hhmmFormatOnly(timestamp: Timestamp.fromMillisecondsSinceEpoch((endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch)).toDate());
    }
  }

  String _parseTotalReading(String startRead, String endRead) {
    if(startRead == null || endRead == null) return '-';
    else {
      return (int.parse(startRead) - int.parse(endRead)).toString();
    }
  }
}
