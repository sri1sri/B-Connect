import 'package:bhavani_connect/auth/bloc.dart';
import 'package:bhavani_connect/authentication_screen/login_screens/otp_page.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/loading_page.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/models/phone_number_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is PhoneNumberVerified) {
          context.bloc<AuthenticationBloc>().gotoOtpPage(
              phoneNumber: state.phoneNumber, isNewUser: state.isNewUser);
        } else if (state is PhoneNumberVerifyFailed) {
          PlatformAlertDialog(
            title: 'Logout',
            content: 'Are you sure that you want to logout?',
            defaultActionText: 'Close',
          ).show(context);
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, state) {
          bool isLoading = state is PhoneNumberLoading;
          return TransparentLoading(
            loading: isLoading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Enter Mobile Number',
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'To create an Account or SignIn \nuse your phone number.',
                      style: descriptionStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[],
                ),
                Column(
                  children: <Widget>[
                    new TextFormField(
                      controller: _phoneNumberController,
                      textInputAction: TextInputAction.done,
                      obscureText: false,
                      focusNode: _phoneNumberFocusNode,
                      onEditingComplete: () => _submit(context,
                          phoneNumber: _phoneNumberController?.value?.text),
                      onChanged: (text) {},
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: backgroundColor,
                        ),
                        labelText: "Enter your mobile no.",
                        //fillColor: Colors.redAccent,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Phone number cannot be empty";
                        } else if (val.length == 10) {
                          return null;
                        } else {
                          return "Phone number you entered is invalid.";
                        }
                      },
                      keyboardType: TextInputType.phone,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ToDoButton(
                      assetName: 'images/googl-logo.png',
                      text: 'Get OTP',
                      textColor: Colors.white,
                      backgroundColor: activeButtonBackgroundColor,
                      onPressed: () {
                        _submit(context,
                            phoneNumber: _phoneNumberController.value.text);
                      },
                    ),
                    SizedBox(height: 10.0),
                    ToDoButton(
                      assetName: 'images/googl-logo.png',
                      text: 'back',
                      textColor: Colors.black,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _submit(BuildContext context, {String phoneNumber}) async {
    try {
      Firestore.instance
          .collection('employees')
          .where('employee_contact_number',
              isEqualTo: '+91${_phoneNumberController.value.text}')
          .snapshots()
          .listen((data) => onData(data, phoneNumber: phoneNumber));
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Phone number failed',
        exception: e,
      ).show(context);
    }
  }

  onData(QuerySnapshot data, {String phoneNumber}) {
    if (data.documents.length == 0) {
      context
          .bloc<AuthenticationBloc>()
          .add(SubmitPhoneNumber(phoneNumber: phoneNumber, isNewUser: true));
    } else {
      context
          .bloc<AuthenticationBloc>()
          .add(SubmitPhoneNumber(phoneNumber: phoneNumber, isNewUser: false));
    }
  }
}
