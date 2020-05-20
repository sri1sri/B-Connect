import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar_2.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/vehicle_category.dart';
import 'package:bhavani_connect/database_model/vehicle_type.dart';
import 'package:bhavani_connect/vehicle/add/add_vehicle_extras.dart';
import 'package:bhavani_connect/vehicle/vehicle_const.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'add_vehicle_bloc.dart';

// Uncomment if you use injector package.
// import 'package:my_app/framework/di/injector.dart';

class AddVehiclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddVehiclePageState();
  }
}

class AddVehiclePageState extends State<AddVehiclePage> {
  // Insert into injector file if you use it.
  // injector.map<AddVehicleBloc>((i) => AddVehicleBloc(i.get<Repository>()), isSingleton: true);

  // Uncomment if you use injector.
  // final _bloc = injector.get<AddVehicleBloc>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _myActivityVehicleType;
  String _myActivityResult;
  FocusNode focusNode = FocusNode();
  final TextEditingController _sellerNameController = TextEditingController();
  final FocusNode _sellerNameFocusNode = FocusNode();
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  final FocusNode _vehicleNumbeFocusNode = FocusNode();
  final TextEditingController _UnitController = TextEditingController();
  final FocusNode _UnitFocusNode = FocusNode();
  List dataSource = [
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
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          key: _scaffoldKey,
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SealedBlocBuilder7<
        AddVehicleBloc,
        AddVehicleState,
        Initial,
        Loading,
        LoadingInit,
        Success,
        SuccessInit,
        Failure,
        FailureInit>(builder: (context, states) {
      return states(
        (Initial initial) => Center(child: CircularProgressIndicator()),
        (Loading loading) => Center(child: CircularProgressIndicator()),
        (LoadingInit loadingInit) => Center(child: CircularProgressIndicator()),
        (Success success) => Center(child: Text('Saved')),
        (SuccessInit successInit) => initWidget(
            vehicleCateList: successInit.vehicleCateList,
            vehicleTypeList: successInit.vehicleTypeList),
        (Failure failure) => Center(child: CircularProgressIndicator()),
        (FailureInit failureInit) => Center(child: CircularProgressIndicator()),
      );
    });
  }

  initWidget(
      {List<VehicleCategory> vehicleCateList,
      List<VehicleType> vehicleTypeList}) {
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
            padding: EdgeInsets.only(top: 10),
            child: InkWell(
                child: Icon(
                  Icons.more_vert,
                  color: backgroundColor,
                  size: 30,
                ),
                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => SettingsPage() ),
//                  );
                }),
          ),
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: 'Add vehicle',
          tabBarWidget: null,
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
        child: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Vehicle category",
                      style: titleStyle,
                    ),
                  ),
                  ExpansionTile(
                      title: Text(
                        "Choose the Vehicle",
                        style: descriptionStyleDarkBlur1,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 420,
                            child: Expanded(
                              child: GridView.builder(
                                itemCount: vehicleCateList.length,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return new GestureDetector(
                                    child: new Card(
                                      elevation: 10.0,
                                      child: new Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: (vehicleCateList[index]
                                                    .hasSelected)
                                                ? Colors.grey
                                                : Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Column(
                                            children: <Widget>[
                                              Image.network(
                                                vehicleCateList[index].image,
                                                height: 70,
                                                cacheHeight: 70,
                                                cacheWidth: 70,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              new Text(
                                                vehicleCateList[index].name,
                                                style: descriptionStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        vehicleCateList.forEach((element) {
                                          element.hasSelected = false;
                                        });
                                        vehicleCateList[index].hasSelected =
                                            true;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Seller Name",
                          style: titleStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _sellerNameController,
                          //initialValue: _name,
                          textInputAction: TextInputAction.done,
                          obscureText: false,
                          validator: (value) => value.isNotEmpty
                              ? null
                              : 'company name cant\'t be empty.',
                          focusNode: _sellerNameFocusNode,
                          // onSaved: (value) => _name = value,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_box,
                              color: backgroundColor,
                            ),
                            labelText: 'Enter Dealer name',
                            //fillColor: Colors.redAccent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),

                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Vehicle Number ",
                          style: titleStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _vehicleNumberController,
                          //initialValue: _name,
                          textInputAction: TextInputAction.done,
                          obscureText: false,
                          validator: (value) => value.isNotEmpty
                              ? null
                              : 'company name cant\'t be empty.',
                          focusNode: _vehicleNumbeFocusNode,
                          //onSaved: (value) => _name = value,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.keyboard,
                              color: backgroundColor,
                            ),
                            labelText: 'Enter Vehicle Number',
                            //fillColor: Colors.redAccent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),

                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Units per Trip",
                          style: titleStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _UnitController,
                          //initialValue: _name,
                          textInputAction: TextInputAction.done,
                          obscureText: false,
                          validator: (value) => value.isNotEmpty
                              ? null
                              : 'Units per Trip cant\'t be empty.',
                          focusNode: _UnitFocusNode,
                          //onSaved: (value) => _name = value,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.track_changes,
                              color: backgroundColor,
                            ),
                            labelText: 'Enter Units per Trip',
                            //fillColor: Colors.redAccent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                          ),

                          keyboardType: TextInputType.number,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Vehicle Type",
                          style: titleStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          child: DropDownFormField(
                            titleText: 'Vehicle Type',
                            hintText: 'Please choose one',
                            value: _myActivityVehicleType,
                            validator: (value) => value?.isNotEmpty == true
                                ? null
                                : 'Please select vehicle type.',
                            onSaved: (value) {
                              setState(() {
                                _myActivityVehicleType = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _myActivityVehicleType = value;
                              });
                            },
                            dataSource: vehicleTypeList
                                .map((e) => {'name': e.name, 'id': e.id})
                                .toList(),
                            textField: 'name',
                            valueField: 'id',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 55,
                        width: 180,
                        child: GestureDetector(
                          onTap: () {
                            _isVehicleSelected(vehicleCateList);
                            if (_formKey.currentState.validate()) {
                              context.bloc<AddVehicleBloc>().add(SubmitVehicle(
                                  vehicleCateSelected:
                                      _cateSelected(vehicleCateList),
                                  dealerName: _sellerNameController.value.text,
                                  vehicleNo:
                                      _vehicleNumberController.value.text,
                                  unitPerTrip: _UnitController.value.text,
                                  vehicleTypeSelected: _typeSelected(
                                      vehicleTypeList,
                                      _myActivityVehicleType)));
                              final snackBar =
                                  SnackBar(content: Text('Processing Data'));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
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
                                    "Create",
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
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isVehicleSelected([List<VehicleCategory> vehicleCateList]) =>
      _cateSelected(vehicleCateList) != null;

  VehicleCategory _cateSelected([List<VehicleCategory> vehicleCateList]) =>
      vehicleCateList?.firstWhere((element) => element.hasSelected, orElse: () => null);

  VehicleType _typeSelected(
          List<VehicleType> vehicleTypeList, String myActivityVehicleType) =>
      vehicleTypeList
          ?.firstWhere((element) => element?.id == myActivityVehicleType, orElse: () => null);
}
