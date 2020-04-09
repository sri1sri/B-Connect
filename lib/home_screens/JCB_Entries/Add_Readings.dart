import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:bhavani_connect/common_widgets/list_item_builder/list_items_builder.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/database_model/attendance_model.dart';
import 'package:bhavani_connect/firebase/database.dart';
import 'package:bhavani_connect/home_screens/manage_goods/add_goods_entry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReadingPage extends StatelessWidget {
  AddReadingPage({@required this.database});
  Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddReadingPagePage(),
    );
  }
}

class F_AddReadingPagePage extends StatefulWidget {
  F_AddReadingPagePage({@required this.database});
  Database database;
  @override
  _F_AddReadingPagePageState createState() => _F_AddReadingPagePageState();
}

class _F_AddReadingPagePageState extends State<F_AddReadingPagePage> {
  final GlobalKey<FormState> _startFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _endFormKey = GlobalKey<FormState>();

//  final _startFormKey = GlobalKey<FormState>();
//  final _endFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

//  bool _validateAndSaveForm() {
//    final form = _startFormKey.currentState;
//    if (form.validate()) {
//      form.save();
//      return true;
//    }
//    return false;
//  }


  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
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
              rightActionBar: Container(),
              rightAction: () {
                print('right action bar is pressed in appbar');
              },
              primaryText: null,
              secondaryText: 'Add Itachi Reading',
              tabBarWidget: null,
            ),
          ),
          body:  SingleChildScrollView(child: _buildContent()),
          bottomNavigationBar: BottomAppBar(
              child: FlatButton(
                  color: activeButtonTextColor,
                  onPressed: (){
                    final FormState form = _startFormKey.currentState;
                    final FormState formm = _endFormKey.currentState;
                    if (form.validate()) {
                      print('Form is valid');
                    } else {
                      print('Form is invalid');
                    }
                    if (formm.validate()) {
                      print('Form is valid');
                    } else {
                      print('Form is invalid');
                    }
                  },
//        icon: Icon(
//          Icons.cloud_upload,
//          size: 30,
//          color: backgroundColor,
//        ),

                  child: Text('Submit', style: titleStyle))),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Card(
      child: Column(
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text("Start Time", style: subTitleStyle),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Start Reading", style: subTitleStyle),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Form(
                          key: _endFormKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: new TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          print('value is null');
                                          return 'should not be empty';
                                        } else {
                                          print('value is not null');
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10))),
                                ),
                              ),
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: new TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          print('value is null');
                                          return 'should not be empty';
                                        } else {
                                          print('value is not null');
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                )),
            SizedBox(
              height: 30,
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text("End Time", style: subTitleStyle),
                            SizedBox(
                              width: 10,
                            ),
                            Text("End Reading", style: subTitleStyle),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Form(
                          key: _startFormKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: new TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'should not be empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10))),
                                ),
                              ),
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: new TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'should not be empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                )),
          ]),
        ],
      ),
    );
  }
}
