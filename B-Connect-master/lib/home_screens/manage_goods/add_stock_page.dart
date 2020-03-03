//import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:intl/intl.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:bhavani_connect/common_variables/app_colors.dart';
//import 'package:bhavani_connect/common_variables/app_fonts.dart';
//import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
//import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
//import 'package:bhavani_connect/home_screens/store_screen.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class AddStockPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: F_AddStockPage(),
//    );
//  }
//}
//
//
//class F_AddStockPage extends StatefulWidget {
//  @override
//  _F_AddStockPageState createState() => _F_AddStockPageState();
//}
//
//class _F_AddStockPageState extends State<F_AddStockPage> {
//
//
//  final GlobalKey<FormBuilderState> _fbkeyy = GlobalKey<FormBuilderState>();
//  int _n = 0;
//
//
//  @override
//  Widget build(BuildContext context) {
//    return offlineWidget(context);
//
//  }
//
//  Widget offlineWidget (BuildContext context){
//
//    return CustomOfflineWidget(
//      onlineChild: Padding(
//        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//        child: Scaffold(
//          body: _buildContent(context),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildContent(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Color(0xFF1F4B6E),
//        title: Center(child:Text('Add Stock',style: subTitleStyleLight,)),
//
//        leading: IconButton(icon:Icon(Icons.arrow_back),
//          onPressed:() => Navigator.pop(context, false),
//        ),
//        centerTitle: true,
//        actions: <Widget>[
//          FlatButton(
//            textColor: Colors.white,
//            onPressed: () {},
//            child: Text("Clear",style: subTitleStyleLight,),
//            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
//          ),
//        ],
//      ),
//      body: Container(
//        child: SingleChildScrollView(
//          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              Column(
//                children: <Widget>[
//                  FormBuilder(
//                    key: _fbkeyy,
//                    initialValue: {
//                      'date': DateTime.now(),
//                      'accept_terms': false,
//                    },
//                    autovalidate: true,
//                    child: Column(
//                      children: <Widget>[
//                        FormBuilderDateTimePicker(
//                          attribute: "date",
//                          inputType: InputType.date,
//                          format: DateFormat("yyyy-MM-dd"),
//                          decoration:
//                          InputDecoration(labelText: "Appointment Time"),
//                        ),
//                        FormBuilderSlider(
//                          attribute: "slider",
//                          validators: [FormBuilderValidators.min(6)],
//                          min: 0.0,
//                          max: 10.0,
//                          initialValue: 1.0,
//                          divisions: 20,
//                          decoration:
//                          InputDecoration(labelText: "Number of things"),
//                        ),
//                        FormBuilderCheckbox(
//                          attribute: 'accept_terms',
//                          label: Text(
//                              "I have read and agree to the terms and conditions"),
//                          validators: [
//                            FormBuilderValidators.requiredTrue(
//                              errorText:
//                              "You must accept terms and conditions to continue",
//                            ),
//                          ],
//                        ),
//                        FormBuilderDropdown(
//                          attribute: "gender",
//                          decoration: InputDecoration(labelText: "Gender"),
//                          // initialValue: 'Male',
//                          hint: Text('Select Gender'),
//                          validators: [FormBuilderValidators.required()],
//                          items: ['Male', 'Female', 'Other']
//                              .map((gender) => DropdownMenuItem(
//                              value: gender,
//                              child: Text("$gender")
//                          )).toList(),
//                        ),
//                        FormBuilderTextField(
//                          attribute: "age",
//                          decoration: InputDecoration(labelText: "Age"),
//                          validators: [
//                            FormBuilderValidators.numeric(),
//                            FormBuilderValidators.max(70),
//                          ],
//                        ),
//                        FormBuilderSegmentedControl(
//                          decoration:
//                          InputDecoration(labelText: "Movie Rating (Archer)"),
//                          attribute: "movie_rating",
//                          options: List.generate(5, (i) => i + 1)
//                              .map(
//                                  (number) => FormBuilderFieldOption(value: number))
//                              .toList(),
//                        ),
//                        FormBuilderSwitch(
//                          label: Text('I Accept the tems and conditions'),
//                          attribute: "accept_terms_switch",
//                          initialValue: true,
//                        ),
//                        FormBuilderStepper(
//                          decoration: InputDecoration(labelText: "Stepper"),
//                          attribute: "stepper",
//                          initialValue: 10,
//                          step: 1,
//                        ),
//                        FormBuilderRate(
//                          decoration: InputDecoration(labelText: "Rate this form"),
//                          attribute: "rate",
//                          iconSize: 32.0,
//                          initialValue: 1,
//                          max: 5,
//                        ),
//                        FormBuilderCheckboxList(
//                          decoration:
//                          InputDecoration(labelText: "The language of my people"),
//                          attribute: "languages",
//                          initialValue: ["Dart"],
//                          options: [
//                            FormBuilderFieldOption(value: "Dart"),
//                            FormBuilderFieldOption(value: "Kotlin"),
//                            FormBuilderFieldOption(value: "Java"),
//                            FormBuilderFieldOption(value: "Swift"),
//                            FormBuilderFieldOption(value: "Objective-C"),
//                          ],
//                        ),
//                        FormBuilderChoiceChip(
//                          attribute: "favorite_ice_cream",
//                          options: [
//                            FormBuilderFieldOption(
//                                child: Text("Vanilla"),
//                                value: "vanilla"
//                            ),
//                            FormBuilderFieldOption(
//                                child: Text("Chocolate"),
//                                value: "chocolate"
//                            ),
//                            FormBuilderFieldOption(
//                                child: Text("Strawberry"),
//                                value: "strawberry"
//                            ),
//                            FormBuilderFieldOption(
//                                child: Text("Peach"),
//                                value: "peach"
//                            ),
//                          ],
//                        ),
//                        FormBuilderFilterChip(
//                          attribute: "pets",
//                          options: [
//                            FormBuilderFieldOption(
//                                child: Text("Cats"),
//                                value: "cats"
//                            ),
//                            FormBuilderFieldOption(
//                                child: Text("Dogs"),
//                                value: "dogs"
//                            ),
//                            FormBuilderFieldOption(
//                                child: Text("Rodents"),
//                                value: "rodents"
//                            ),
//                            FormBuilderFieldOption(
//                                child: Text("Birds"),
//                                value: "birds"
//                            ),
//                          ],
//                        ),
//                        FormBuilderSignaturePad(
//                          decoration: InputDecoration(labelText: "Signature"),
//                          attribute: "signature",
//                          height: 100,
//                        ),
//                      ],
//                    ),
//                  ),
//                  Row(
//                    children: <Widget>[
//                      MaterialButton(
//                        child: Text("Submit"),
//                        onPressed: () {
//                          if (_fbkeyy.currentState.saveAndValidate()) {
//                            print(_fbkeyy.currentState.value);
//                          }
//                        },
//                      ),
//                      MaterialButton(
//                        child: Text("Reset"),
//                        onPressed: () {
//                          _fbkeyy.currentState.reset();
//                        },
//                      ),
//                    ],
//                  )
//                ],
//              )
//
//            ],
//          ),
//        ),
//      ),
//      bottomNavigationBar: BottomAppBar(
//          child:   FlatButton.icon(
//
//              color: activeButtonTextColor,
//              onPressed: () => { print ("Place Order")},
//              icon: Icon(Icons.shopping_cart,size: 30,color: backgroundColor,),
//              label: Text('Place Order',style:titleStyle))
//
//
//      ),
//
//    );
//  }
//  void add() {
//    setState(() {
//      _n++;
//    });
//  }
//
//  void minus() {
//    setState(() {
//      if (_n != 0)
//        _n--;
//    });
//  }
//
//  void _goToPage(BuildContext context, Widget page) {
//    Navigator.of(context).push(
//      MaterialPageRoute<void>(
//        fullscreenDialog: true,
//        builder: (context) => page,
//      ),
//    );
//  }
//  _ItemCard(String companyName, String itemName, String category, String quantity)
//  {
//    return Container(
//
//      child: Card(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(10.0),
//        ),
//        color: Colors.white,
//        elevation: 10,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//          children: <Widget>[
//            SizedBox(height: 20,),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: [
//                Column(
//                    children: <Widget>[
//
//                      Text("Company Name",style: descriptionStyle,),
//                      SizedBox(height: 10,),
//                      Text(companyName,style: descriptionStyleDark,),
//                      SizedBox(height: 10,),
//                      Text("Item names",style: descriptionStyle,),
//                      SizedBox(height: 10,),
//                      Text(itemName,style: descriptionStyleDark,),
//                    ]
//                ),
//                Column(
//                    children: <Widget>[
//
//                      Text("Category",style: descriptionStyle,),
//                      SizedBox(height: 10,),
//                      Text(category,style: descriptionStyleDark,),
//                      SizedBox(height: 10,),
//                      Text("Quantity",style: descriptionStyle,),
//                      SizedBox(height: 10,),
//                      Text(quantity,style: descriptionStyleDark,),
//                    ]
//                ),
//              ],
//            ),
//            SizedBox(height: 20,),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: [
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    new FloatingActionButton(
//                      onPressed: add,
//                      child: new Icon(Icons.add, color: Colors.white,),
//                      backgroundColor: backgroundColor,),
//                    SizedBox(width: 15,),
//
//                    new Text('$_n',
//                        style: new TextStyle(fontSize: 30.0)),
//                    SizedBox(width: 15,),
//                    new FloatingActionButton(
//                      onPressed: minus,
//                      child: new Icon(
//                        const IconData(0xe15b, fontFamily: 'MaterialIcons'),
//                        color: backgroundColor,),
//                      backgroundColor: Colors.white,),
//                  ],
//                ),
//                SizedBox(height: 10.0),
////                FloatingActionButton(
////                  onPressed: () => { print ("remove item")},
////                  child: new Icon(
////                    Icons.close,size: 30,color: Colors.white,),
////                  backgroundColor: removeButtonBackgroundColor),
//                ToDoButton(
//                  assetName: 'images/google-lodgo.png',
//                  text: 'Remove Item',
//                  textColor: activeButtonTextColor,
//                  backgroundColor: removeButtonBackgroundColor,
//                  onPressed: () => { print ("remove item")},
//                ),
//
//              ],
//            ),
//
//            SizedBox(height: 20,),
//          ],
//
//
//
//        ),
//      ),
//    );
//
//  }
//
//}
