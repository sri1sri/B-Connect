import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/AddNewInvoice.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/Stock_Data_List.dart';
import 'package:bhavani_connect/home_screens/Stock_Register/detail_description.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/vehicle_details_readings.dart';
import 'package:bhavani_connect/home_screens/Vehicle_Entry/add_vehicle_details.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class StockFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_StockFilter(),
    );
  }
}

class F_StockFilter extends StatefulWidget {
  @override
  _F_StockFilter createState() => _F_StockFilter();
}

class _F_StockFilter extends State<F_StockFilter> {

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  var customFormat = DateFormat("dd MMMM yyyy 'at' HH:mm:ss 'UTC+5:30'");
  var customFormat2 = DateFormat("dd MMM yyyy");
  Future<Null> showPickerFrom(BuildContext context) async {
    final DateTime pickedFrom = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1930),
      lastDate: DateTime(2010),
    );
    if (pickedFrom != null){
      setState(() {
        print(customFormat.format(pickedFrom));
        selectedDateFrom = pickedFrom;
      });
    }
  }
  Future<Null> showPickerTo(BuildContext context) async {
    final DateTime pickedTo = await showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1930),
      lastDate: DateTime(2010),
    );
    if (pickedTo != null){
      setState(() {
        print(customFormat.format(pickedTo));
        selectedDateTo = pickedTo;
      });
    }
  }
  String _SellerName;
  String _ItemName;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sellerNameController = TextEditingController();
  final FocusNode _sellerNameFocusNode = FocusNode();
  final TextEditingController _itemNameController = TextEditingController();
  final FocusNode _itemNameFocusNode = FocusNode();
  final TextEditingController _fromDateController = TextEditingController();
  final FocusNode _fromDateFocusNode = FocusNode();
  final TextEditingController _toDateController = TextEditingController();
  final FocusNode _toDateFocusNode = FocusNode();
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
          rightActionBar: Container(width: 10,),
          rightAction: (){
            print('right action bar is pressed in appbar');
          },
          primaryText: 'Search Stock',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 50,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Seller Name",style: titleStyle,),
                              SizedBox(height: 15,),
                              DropDownFormField(
                                titleText: 'Seller Name',
                                hintText: 'Please choose one',
                                value: _SellerName,
                                onSaved: (value) {
                                  setState(() {
                                    _SellerName = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _SellerName = value;
                                  });
                                },
                                dataSource: [
                                  {
                                    "display": "Running",
                                    "value": "Running",
                                  },
                                  {
                                    "display": "Climbing",
                                    "value": "Climbing",
                                  },
                                  {
                                    "display": "Walking",
                                    "value": "Walking",
                                  },
                                  {
                                    "display": "Swimming",
                                    "value": "Swimming",
                                  },
                                  {
                                    "display": "Soccer Practice",
                                    "value": "Soccer Practice",
                                  },
                                  {
                                    "display": "Baseball Practice",
                                    "value": "Baseball Practice",
                                  },
                                  {
                                    "display": "Football Practice",
                                    "value": "Football Practice",
                                  },
                                ],
                                textField: 'display',
                                valueField: 'value',
                              ),
                              SizedBox(height: 20,),
                              Text("Item Name",style: titleStyle,),
                              SizedBox(height: 15,),
                              DropDownFormField(
                                titleText: 'Seller Name',
                                hintText: 'Please choose one',
                                value: _ItemName,
                                onSaved: (value) {
                                  setState(() {
                                    _ItemName = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _ItemName = value;
                                  });
                                },
                                dataSource: [
                                  {
                                    "display": "Running",
                                    "value": "Running",
                                  },
                                  {
                                    "display": "Climbing",
                                    "value": "Climbing",
                                  },
                                  {
                                    "display": "Walking",
                                    "value": "Walking",
                                  },
                                  {
                                    "display": "Swimming",
                                    "value": "Swimming",
                                  },
                                  {
                                    "display": "Soccer Practice",
                                    "value": "Soccer Practice",
                                  },
                                  {
                                    "display": "Baseball Practice",
                                    "value": "Baseball Practice",
                                  },
                                  {
                                    "display": "Football Practice",
                                    "value": "Football Practice",
                                  },
                                ],
                                textField: 'display',
                                valueField: 'value',
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2 - 25,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("From",style: titleStyle,),
                                        SizedBox(height: 15,),
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
                                                SizedBox(width: 10,),
                                                Text(
                                                    '${customFormat2.format(selectedDateFrom)}',
                                                    style: subTitleStyle
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2 - 25,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("To",style: titleStyle,),
                                        SizedBox(height: 15,),
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
                                                SizedBox(width: 10,),
                                                Text(
                                                    '${customFormat2.format(selectedDateTo)}',
                                                    style: subTitleStyle
                                                ),
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
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 180,
                              child: GestureDetector(
                                onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StockDataList(),),
                      );
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
                        SizedBox(height: 500,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}