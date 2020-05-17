import 'package:bhavani_connect/auth/authentication_bloc.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/vehicle_model.dart';
import 'package:bhavani_connect/filter/vehicle/filter_vehicle_extras.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/filtered_vehicle_list_details.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'filter_vehicle_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class FilterVehiclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilterVehiclePageState();
  }
}

class FilterVehiclePageState extends State<FilterVehiclePage> {
  // Insert into injector file if you use it.
  // injector.map<FilterVehicleBloc>((i) => FilterVehicleBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<FilterVehicleBloc>();

  String _sellerName;
  String _siteName;

  final _formKey = GlobalKey<FormState>();
  int _n = 0;

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  var customFormat = DateFormat("dd MMMM yyyy 'at' HH:mm:ss 'UTC+5:30'");
  var customFormat2 = DateFormat("dd MMM yyyy");

  Future<Null> showPickerFrom(BuildContext context) async {
    final DateTime pickedFrom = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2021),
    );
    if (pickedFrom != null) {
      setState(() {
        print(customFormat.format(pickedFrom));
        selectedDateFrom = pickedFrom;
      });
    }
  }

  Future<Null> showPickerTo(BuildContext context) async {
    final DateTime pickedTo = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2021),
    );
    if (pickedTo != null) {
      setState(() {
        print(customFormat.format(pickedTo));
        selectedDateTo = pickedTo;
      });
    }
  }

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
            rightActionBar: Container(
              width: 10,
            ),
            rightAction: () {},
            primaryText: 'Search Vehicle',
            tabBarWidget: null,
          ),
        ),
        body: SealedBlocBuilder4<FilterVehicleBloc, FilterVehicleState, Initial,
            Loading, Success, Failure>(builder: (context, states) {
          return states(
            (Initial initial) => Center(child: CircularProgressIndicator()),
            (Loading loading) => Center(child: CircularProgressIndicator()),
            (Success success) => _bodySuccess(context, success.data),
            (Failure failure) => Center(),
          );
        }));
  }

  _bodySuccess(BuildContext context, List<Vehicle> data) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dealer Name",
                              style: titleStyle,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DropDownFormField(
                              titleText: 'Dealer Name',
                              hintText: 'Please choose one',
                              value: _sellerName,
                              onSaved: (value) {
                                setState(() {
                                  _sellerName = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _sellerName = value;
                                });
                              },
                              dataSource: data
                                  .map((e) => {
                                        'name': e.sellerName,
                                        'value': e.sellerName
                                      })
                                  .toList(),
                              textField: 'name',
                              valueField: 'value',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Construction Site",
                              style: titleStyle,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DropDownFormField(
                              titleText: 'Site Name',
                              hintText: 'Please choose one',
                              value: _siteName,
                              onSaved: (value) {
                                setState(() {
                                  _siteName = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _siteName = value;
                                });
                              },
                              dataSource: [
                                {'name': 'site name', 'value': 'site'}
                              ],
                              textField: 'name',
                              valueField: 'value',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      25,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "From",
                                        style: titleStyle,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () => showPickerFrom(context),
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.date_range,
                                                size: 18.0,
                                                color: backgroundColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  '${customFormat2.format(selectedDateFrom)}',
                                                  style: subTitleStyle),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      25,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "To",
                                        style: titleStyle,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () => showPickerTo(context),
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.date_range,
                                                size: 18.0,
                                                color: backgroundColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  '${customFormat2.format(selectedDateTo)}',
                                                  style: subTitleStyle),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 55,
                            width: 180,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState.validate() &&
                                    _sellerName != null &&
                                    _sellerName.isNotEmpty) {
                                  print(selectedDateFrom);
                                  print(selectedDateTo);
                                  context
                                      .bloc<AuthenticationBloc>()
                                      .gotoVehicleResult(
                                          sellerName: _sellerName,
                                          siteName: _siteName,
                                          dateFrom: selectedDateFrom,
                                          dateTo: selectedDateTo);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        "Search",
                                        style: activeSubTitleStyle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 500,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
