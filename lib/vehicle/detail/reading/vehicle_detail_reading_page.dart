import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/utilities/date_time.dart';
import 'package:bhavani_connect/vehicle/detail/reading/vehicle_detail_reading_extras.dart';
import 'package:bhavani_connect/vehicle/vehicle_extras.dart' as vehicleExtra;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'vehicle_detail_reading_bloc.dart';
import 'package:vector_math/vector_math.dart' as math;

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class VehicleDetailReadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehicleDetailReadingPageState();
  }
}

class VehicleDetailReadingPageState extends State<VehicleDetailReadingPage> {
  // Insert into injector file if you use it.
  // injector.map<VehicleDetailReadingBloc>((i) => VehicleDetailReadingBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<VehicleDetailReadingBloc>();

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
            body: BlocListener<VehicleDetailReadingBloc,
                VehicleDetailReadingState>(
          listener: (BuildContext context, VehicleDetailReadingState state) {},
          child:
              BlocBuilder<VehicleDetailReadingBloc, VehicleDetailReadingState>(
            builder: (BuildContext context, VehicleDetailReadingState state) {
              if (state is Success) {
                return _buildContent(context, vehicle: state.vehicle);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        )),
      ),
    );
  }

  Widget _buildContent(BuildContext context, {Vehicle vehicle}) {
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
          //rightActionBar: Icon(Icons.border_color,size: 25,color: Colors.white,),
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
                  "Records",
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
                            'Time',
                            style: subTitleStyle,
                          )),
                          DataColumn(
                              label: Text(
                            'Readings',
                            style: subTitleStyle,
                          )),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              DataCell(Text(
                                'Initial',
                                style: descriptionStyleDark,
                              )),
                              DataCell(Text(
                                '${hhmmFormatDate(timestamp: vehicle?.startTime?.toDate())}',
                                style: descriptionStyleDark,
                              )),
                              DataCell(Text(
                                '${vehicle?.startRead ?? '-'}',
                                style: descriptionStyleDark,
                              )),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text(
                                'Final',
                                style: descriptionStyleDark,
                              )),
                              DataCell(Text(
                                '${hhmmFormatDate(timestamp: vehicle?.endTime?.toDate())}',
                                style: descriptionStyleDark,
                              )),
                              DataCell(Text(
                                '${vehicle?.endRead ?? '-'}',
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
                                '${formatDateRow(timestamp: vehicle?.dateRequest?.toDate())}',
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
                                '${formatDateRow(timestamp: vehicle?.dateApproval?.toDate())}',
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
      floatingActionButton: buildButtonState(context, vehicle),
    );
  }
}

Widget buildButtonState(BuildContext context, Vehicle vehicle) {
  return (vehicle.startTime != null && vehicle.endTime != null) ? Container() : Padding(
    padding: const EdgeInsets.all(40.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (vehicle.startTime == null)
              startReadingDialogue(context, vehicle: vehicle);
            else
              endReadingDialogue(context, vehicle: vehicle);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: (vehicle.startTime == null)
                  ? Colors.green.withOpacity(0.8)
                  : Colors.red.withOpacity(0.8),
            ),
            height: 35,
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${vehicle.startTime == null ? 'START' : 'STOP'}',
                  style: subTitleStyleLight1,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void startReadingDialogue(BuildContext contextDialog, {Vehicle vehicle}) {
  final _formKey = GlobalKey<FormState>();
  String _updatedGangName;

  showGeneralDialog(
      context: contextDialog,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 250.0,
                  width: 400.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Enter Start Readings",
                                  style: highlightDescription,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (value) =>
                                            _updatedGangName = value,
                                        autocorrect: true,
                                        obscureText: false,
                                        keyboardType: TextInputType.text,
                                        keyboardAppearance: Brightness.light,
                                        autofocus: true,
                                        cursorColor: backgroundColor,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: InputDecoration(
                                          counterStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          hintText: "ODO Reading",
                                          hintStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          print(value);
                                          if (value.isEmpty) {
                                            return 'Please enter new gang name.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  width: 180,
                                  child: GestureDetector(
                                    onTap: () {
                                      contextDialog
                                          .bloc<VehicleDetailReadingBloc>()
                                          .add(StartReading(
                                              vehicle: vehicle,
                                              odoReading: _updatedGangName));
                                      Navigator.pop(context);

//                                      final updatedGangDetails  = GangDetails(gangName: _updatedGangName);
//                                      DBreference.updateGang(updatedGangDetails, gangDetails.gangID);
//
//                                      GoToPage(context, LandingPage());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Start",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  //fontFamily: mainFontFamily,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(1.05, -1.05),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}

void endReadingDialogue(BuildContext buildContext, {Vehicle vehicle}) {
  final _formKey = GlobalKey<FormState>();
  String _updatedGangName;

  showGeneralDialog(
      context: buildContext,
      pageBuilder: (context, anim1, anim2) {},
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.rotate(
          angle: math.radians(anim1.value * 360),
          child: Opacity(
            opacity: anim1.value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 250.0,
                  width: 400.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Enter End Readings",
                                  style: highlightDescription,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (value) =>
                                            _updatedGangName = value,
                                        autocorrect: true,
                                        obscureText: false,
                                        keyboardType: TextInputType.text,
                                        keyboardAppearance: Brightness.light,
                                        autofocus: true,
                                        cursorColor: backgroundColor,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: InputDecoration(
                                          counterStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          hintText: "ODO Reading",
                                          hintStyle: TextStyle(
                                            // fontFamily: mainFontFamily,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          print(value);
                                          if (value.isEmpty) {
                                            return 'Please enter ODO reading.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  width: 180,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        buildContext.bloc<VehicleDetailReadingBloc>().add(StopReading(vehicle: vehicle, odoReading: _updatedGangName));
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Stop",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  //fontFamily: mainFontFamily,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(1.05, -1.05),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}
