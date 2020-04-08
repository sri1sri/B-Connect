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
import 'package:bhavani_connect/landing_page.dart';
import 'package:bhavani_connect/models/sign_up_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  DateTime selectedDate = DateTime.now();
  var customFormat = DateFormat("dd MMMM yyyy 'at' HH:mm:ss 'UTC+5:30'");
  var customFormat2 = DateFormat("dd MMMM yyyy");

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://bconnect-9d1b5.appspot.com/');
  StorageUploadTask _uploadTask;
  String _profilePicPathURL;

  bool _loading;
  double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }

  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2010),
        firstDate: DateTime(1930),
        lastDate: DateTime(2010),
    );
    if (picked != null){
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
          body: SingleChildScrollView(child: _buildContent(context)),
        ),
      ),
    );
  }

  Future<void> _captureImage() async{
    File profileImage = await ImagePicker.pickImage(source: IMAGE_SOURCE);
setState(() {
  _profilePic = profileImage;
  print(_profilePic);
});
  }

  Widget signupContent(Widget signInBtn){
   return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 50,),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Create your own \naccount today',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                Text(
                  'To create an Account enter your name and date of birth.',
                  style: descriptionStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 20,),

            Column(
              children: <Widget>[
                GestureDetector(onTap: _captureImage,
                    child: _profilePic == null ?
                    Container(
                      width: 120,
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(top:50,left: 25),
                        child: Text('Add Photo',style: descriptionStyle,),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,),
                    )
                        :
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(_profilePic),  // here add your image file path
                            fit: BoxFit.fill,
                          )),
                    )),

                SizedBox(height: 40.0),

                new TextFormField(
                  controller: _usernameController,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  focusNode: _usernameFocusNode,
                  onEditingComplete: () => _imageUpload(),
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

                SizedBox(height: 20.0),

                Padding(
                  padding: EdgeInsets.only(top: 0,bottom: 10),
                  child: Container(

                    child: RaisedButton(

                      color: Colors.white,
                      child: Container(
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children: <Widget>[
                              Text(
                                'Select your date of birth.',
                                style: descriptionStyle,
                                textAlign: TextAlign.center,
                              ),
                              Row(
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
                              SizedBox(width: 10,),
                          ],
                        ),
                      ),
                      onPressed: () => showPicker(context),

                    ),
                  ),

                ),
                SizedBox(height: 15.0),

                signInBtn,
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildContent(BuildContext context) {

    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events == null ? null :_uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            _progressValue =
            event != null ? event.bytesTransferred / event.totalByteCount : 0;

            return signupContent(
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LinearProgressIndicator(
                  value: _progressValue,
                ),
                Text('${(_progressValue * 100).round()}%'),
              ],
            ),
            );
          }
      );
    }else{
      return signupContent(
          ToDoButton(
            assetName: 'images/googl-logo.png',
            text: 'Register',
            textColor: Colors.white,
            backgroundColor: activeButtonBackgroundColor,
            onPressed: model.canSubmit ? () => _imageUpload() : null,
          ),
      );

    }
  }

  Future<void> _submit(String path) async {

    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final employeeDetails = EmployeeDetails(
        username: _usernameController.value.text,
        phoneNumber: '+91${widget.phoneNo}',
        gender: 'Not mentioned',
        dateOfBirth: Timestamp.fromDate(selectedDate),
        joinedDate: Timestamp.fromDate(DateTime.now()),
        latitude: '',
        longitude: '',
        role: 'Not assigned',
        employeeImagePath: path,
        deviceToken: DEVICE_TOKEN,
      );

      await FirestoreService.instance.setData(
        path: APIPath.employeeDetails(user.uid),
        data: employeeDetails.toMap(),
      );
      GoToPage(context, LandingPage());

    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Something went wrong.',
        exception: e,
      ).show(context);
    }
  }

  void _imageUpload() async {
    _loading = !_loading;
    if (_profilePic != null ) {
      String _profilePicPath = 'profile_pic_images/${DateTime.now()}.png';
      setState(() {
        _uploadTask =
            _storage.ref().child(_profilePicPath).putFile(_profilePic);
      });
      _profilePicPathURL = await (await _storage
          .ref()
          .child(_profilePicPath)
          .putFile(_profilePic)
          .onComplete)
          .ref
          .getDownloadURL();

      _submit(_profilePicPathURL);
    }
  }
}