import 'dart:io';

import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/loading_page.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/database_model/employee_details_model.dart';
import 'package:bhavani_connect/firebase/api_path.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/firebase/firestore_service.dart';
import 'package:bhavani_connect/home_screens/home_page.dart';
import 'package:bhavani_connect/models/sign_up_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({@required this.phoneNo});
  String phoneNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_SignUpPage.create(context, phoneNo),
    );
  }
}

class F_SignUpPage extends StatefulWidget {
  F_SignUpPage({this.model, @required this.phoneNo});
  final SignUpModel model;
  String phoneNo;

  static Widget create(BuildContext context, String phoneNo) {
    final AuthBase auth = Provider.of<AuthBase>(context);

    return ChangeNotifierProvider<SignUpModel>(
      create: (context) => SignUpModel(auth: auth),
      child: Consumer<SignUpModel>(
        builder: (context, model, _) => F_SignUpPage(model: model, phoneNo: phoneNo),
      ),
    );
  }
  @override
  _F_SignUpPageState createState() => _F_SignUpPageState();
}

class _F_SignUpPageState extends State<F_SignUpPage> {

  File _profilePic;
  bool isProfilePic = false;
  //Date Picker
  DateTime selectedDate = DateTime.now();
  var customFormat = DateFormat("dd MMMM yyyy 'at' HH:mm:ss 'UTC+5:30'");
  var customFormat2 = DateFormat("dd MMMM yyyy");

  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2010),
        firstDate: DateTime(1930),
        lastDate: DateTime(2010),
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        print(customFormat.format(picked));
        selectedDate = picked;
      });
    }
  }



  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();

  SignUpModel get model => widget.model;

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget (BuildContext context){
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  Future<void> _captureImage() async{
    File profileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
setState(() {
  _profilePic = profileImage;
  print(_profilePic);

});
  }

  Widget _buildContent(BuildContext context) {
    return TransparentLoading(
      loading: widget.model.isLoading,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Create your own \naccount today',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                Text(
                  'To create an Account enter your name and date of birth.',
                  style: descriptionStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            Column(
              children: <Widget>[

               GestureDetector(
                  onTap: _captureImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _profilePic == null
                              ? Text('Add Photo',style: descriptionStyle,)
                              : FileImage(_profilePic),  // here add your image file path
                          fit: BoxFit.fill,
                        )),
                  )),

                SizedBox(height: 20.0),

                new TextFormField(
                  controller: _usernameController,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  focusNode: _usernameFocusNode,
                  onEditingComplete: () => _submit(),
                  onChanged: model.updateUsername,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: backgroundColor,
                    ),
                    labelText: "Enter your name",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if(val.length==0) {
                      return "Username cannot be empty";
                    }else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),

                SizedBox(height: 10.0),

                Padding(
                  padding: EdgeInsets.only(top: 0,bottom: 10),
                  child: Container(

                    child: RaisedButton(

                      color: Colors.white,
                      child: Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: backgroundColor,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                      '${customFormat2.format(selectedDate)}',
                                      style: subTitleStyle
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              'Change',
                              style: subTitleStyle
                            ),
                          ],
                        ),
                      ),
                      onPressed: () => showPicker(context),

                    ),

                  ),

                ),


                ToDoButton(
                  assetName: 'images/googl-logo.png',
                  text: 'Register',
                  textColor: Colors.white,
                  backgroundColor: activeButtonBackgroundColor,
                  onPressed: model.canSubmit ? () => _submit() : null,
                ),
                SizedBox(height: 100.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      final employeeDetails = EmployeeDetails(
        username: _usernameController.value.text,
        phoneNumber: '+91${widget.phoneNo}',
        gender: 'N',
        dateOfBirth: Timestamp.fromDate(DateTime.parse('2000-01-01 00:00:00.000')),
        joinedDate: Timestamp.fromDate(DateTime.now()),
        latitude: '',
        longitude: '',
        role: 'Not assigned',
      );

      FirestoreService.instance.setData(
        path: APIPath.employeeDetails(user.uid),
        data: employeeDetails.toMap(),
      );
      GoToPage(context, HomePage());
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Something went wrong.',
        exception: e,
      ).show(context);
    }
  }
}