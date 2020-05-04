import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddVehicle(),
    );
  }
}

class F_AddVehicle extends StatefulWidget {
  @override
  _F_AddVehicle createState() => _F_AddVehicle();
}

class _F_AddVehicle extends State<F_AddVehicle> {
  final _formKey = GlobalKey<FormState>();
  String _myActivity;
  String _myActivityResult;
  FocusNode focusNode = FocusNode();
  final TextEditingController _sellerNameController = TextEditingController();
  final FocusNode _sellerNameFocusNode = FocusNode();
  final TextEditingController _vehicleNumberController = TextEditingController();
  final FocusNode _vehicleNumbeFocusNode = FocusNode();
  final TextEditingController _vehicleUnitController = TextEditingController();
  final FocusNode _vehicleUnityFocusNode = FocusNode();
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
    _myActivity = '';
    _myActivityResult = '';
    focusNode.addListener(() {
      focusNode.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
//      focusNode.
    });
  }

//  _saveForm() {
//    var form = formKey.currentState;
//    if (form.validate()) {
//      setState(() {
//        _myActivityResult = _myActivity;
//      });
//    }
//  }


  var category = [
    "Jcb/Hitachi",
    "Tractor",
    "Road Roller",
    "Cement Mixer",
    "Excavator",
    "BoreWell",
    "Pickup Truck",
    "GoodsTruck",
    "Driller",
    "Crane",
    "Fork Lift",
    "Others"
  ];
  List<String> F_image = [
    "images/jcb.png",
    "images/c1.png",
    "images/c9.png",
    "images/c3.png",
    "images/c4.png",
    "images/c5.png",
    "images/c6.png",
    "images/c7.png",
    "images/c8.png",
    "images/c10.png",
    "images/inventory.png",
    "images/c11.png",


  ];


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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        //preferredSize : Size(double.infinity, 100),
        child: CustomAppBar(
          leftActionBar: Container(
            child: Icon(
              Icons.arrow_back,
              size: 40,
              color: Colors.black38,
            ),
          ),
          leftAction: () {
            Navigator.pop(context, true);
          },
          rightActionBar: null,
          rightAction: () {
            print('right action bar is pressed in appbar');
          },
          primaryText: null,
          secondaryText: 'Add Vehicle',
          tabBarWidget: null,
        ),
      ),
      body:SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Vehicle category",style: titleStyle,),
                ),
          ExpansionTile(
            title: Text("Choose the Vehicle",style: descriptionStyleDarkBlur1,),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 420,
                  child: Expanded(
                    child: GridView.builder(
                      itemCount: category.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 10
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return new GestureDetector(
                          child: new Card(
                            elevation: 10.0,
                            child: new Container(
                              alignment: Alignment.center,
                              margin: new EdgeInsets.only(
                                  top: 5.0, bottom: 0.0, left: 0.0, right: 0.0),
                              child: new Column(
                                children: <Widget>[
                                  Image.asset(
                                    F_image[index],height: 70,
                                  ),
                                  SizedBox(height: 5,),
                                  new Text(
                                    category[index],
                                    style: descriptionStyle,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            switch (category[index]) {
                              case 'Jcb/Hitachi':
                                {
                                  print("case 1 is selected");
                                }
                                break;

                              case 'Tractor':
                                {
                                  print("case 2 is selected");
                                }
                                break;
                              case 'Road Roller':
                                {
                                  print("case 3 is selected");
                                }
                                break;

                              case 'Cement Mixer':
                                {
                                  print("case 4 is selected");
                                }
                                break;

                              case 'Excavator':
                                {
                                  print("case 5 is selected");
                                }
                                break;
                              case 'BoreWell':
                                {
                                  print("case 6 is selected");
                                }
                                break;
                              case 'Pickup Truck':
                                {
                                  print("case 7 is selected");
                                }
                                break;
                              case 'GoodsTruck':
                                {
                                  print("case 8 is selected");
                                }
                                break;
                              case 'Driller':
                                {
                                  print("case 9 is selected");
                                }
                                break;
                              case 'Crane':
                                {
                                  print("case 10 is selected");
                                }
                                break;

                              case 'Fork Lift':
                                {
                                  print("case 11 is selected");
                                }
                                break;
                              case 'Others':
                                {
                                  print("case 12 is selected");
                                }
                                break;


                              default:
                                {}
                                break;
                            }

                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]
          ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Seller Name",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _sellerNameController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'company name cant\'t be empty.',
                        focusNode: _sellerNameFocusNode,
                       // onSaved: (value) => _name = value,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box,
                            color: backgroundColor,
                          ),
                          labelText: 'Enter Seller name',
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
                      SizedBox(height: 20,),
                      Text("Vehicle Number ",style: titleStyle,),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _vehicleNumberController,
                        //initialValue: _name,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        validator: (value) => value.isNotEmpty ? null : 'company name cant\'t be empty.',
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
                      SizedBox(height: 20,),
                      Text("Vehicle Measure",style: titleStyle,),
                      SizedBox(height: 20,),
                      DropDownFormField(
                        innerBackgroundColor: Colors.white,
                        wedgeIcon: Icon(Icons.keyboard_arrow_down),
                        wedgeColor: Colors.grey,
                        innerTextStyle: descriptionStyleDark,
                        focusNode: focusNode,
                        inputDecoration: OutlinedDropDownDecoration(
                            labelStyle: TextStyle(color: backgroundColor),
                            labelText: "Select the measure",
                            borderColor: backgroundColor),
                        hintText: 'Choose Vehicle Measure',
                        value: _myActivity,
                        onSaved: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        dataSource: dataSource,
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 180,
                      child: GestureDetector(
                        onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => LoginPage(),),
//                      );
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

