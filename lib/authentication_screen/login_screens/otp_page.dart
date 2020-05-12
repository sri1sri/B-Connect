import 'package:bhavani_connect/authentication_screen/registrtion_screens/sign_up_page.dart';
import 'package:bhavani_connect/common_variables/app_colors.dart';
import 'package:bhavani_connect/common_variables/app_fonts.dart';
import 'package:bhavani_connect/common_variables/app_functions.dart';
import 'package:bhavani_connect/common_widgets/button_widget/to_do_button.dart';
import 'package:bhavani_connect/common_widgets/loading_page.dart';
import 'package:bhavani_connect/common_widgets/offline_widgets/offline_widget.dart';
import 'package:bhavani_connect/common_widgets/platform_alert/platform_exception_alert_dialog.dart';
import 'package:bhavani_connect/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpArguments {
  final String phoneNum;
  final bool isNewUser;

  OtpArguments({this.phoneNum, this.isNewUser});
}

class OTPPage extends StatefulWidget {
  OTPPage({@required this.phoneNo, @required this.newUser});

  final String phoneNo;
  final bool newUser;

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    return TransparentLoading(
      loading: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[],
          ),
          Column(
            children: <Widget>[
              Text(
                'Verify Mobile Number',
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter OTP sent to +91 ${widget.phoneNo}.',
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
                keyboardType: TextInputType.number,
                controller: _otpController,
                textInputAction: TextInputAction.done,
                obscureText: false,
                focusNode: _otpFocusNode,
                onEditingComplete: () => _submit(),
                onChanged: (text) {},
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: backgroundColor,
                  ),
                  labelText: "Enter OTP",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "One Time Password cannot be empty";
                  } else {
                    return null;
                  }
                },
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 20.0),
              ToDoButton(
                assetName: 'images/googe-logo.png',
                text: 'Verify',
                textColor: Colors.white,
                backgroundColor: activeButtonBackgroundColor,
                onPressed: _submit,
              ),
              SizedBox(height: 10.0),
              ToDoButton(
                assetName: 'images/googe-logo.png',
                text: 'Edit phone number',
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
  }

  @override
  Future<void> _submit() async {
    try {
      widget.phoneNo == '8333876209' ? EMPLOYEE_PNO = widget.phoneNo : '';
      print('otp${widget.newUser}');
      if (widget.newUser) {
        await _submit();
        GoToPage(context, SignUpPage(phoneNo: widget.phoneNo));
      } else {
        await _submit();
        GoToPage(context, LandingPage());
      }
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Otp Verification failed',
        exception: e,
      ).show(context);
    }
  }
}
